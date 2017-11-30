/************************************************************************************/
/*
                            P R O C E S S I N G . C

 ------------------------------------------------------------------------------------

  (c) Copyright       ZSN/ZHAW
                      Technikumstr. 9
                      CH-8401 Winterthur

					  Author: 31.7.2017 / zols
                      Version: 25.8.2017 / wyrs

 ------------------------------------------------------------------------------------

  Subsystem         : APP (Application)
  Module            : Signal Processing
  Type of SW-Unit   : C File

 ------------------------------------------------------------------------------------

  Description:
  ------------
  DSP operation on the audio stream.

  It is recommended to use the CMSI DSP library developed by ARM for standard
  operations like FIR / IIR filter, FFT, matrix operation or math functions like sin.

  Most routines can be used with fp32, q31 or q15. The performance is improved if
  the block size is a multiple of 8.

  For documentation of the CMSIS lib look here:
  http://arm-software.github.io/CMSIS_5/DSP/html/index.html

 ------------------------------------------------------------------------------------

*/
/************************************************************************************/


/*** Imported external Objects ******************************************************/
/************************************************************************************/
#include "Processing.h"
#include "main.h"
#include "math.h"
#include "Coeff.h"
#include "LAB_CONFIG.h"
#include "core_cm7.h"
#include "arm_math.h"





int32_t Koeff_FIR[10] MAP_TO_DTCM ={2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647};
// entspricht 1 ; (2^31-1)

#include "IIR.h"
#include "IIRq15.h"



/*** Module Objects *****************************************************************/
/************************************************************************************/

/*** Constants **********************************************************************/

/*** Types **************************************************************************/

/*** Variables **********************************************************************/

// create the CMSIS LIB instances here if needed

int32_t Filter_State_FIR[10 + BUFFER_SIZE_SAMPLES] MAP_TO_DTCM; // FIR-Filter States
int32_t Filter_State_FIR2[10 + BUFFER_SIZE_SAMPLES] MAP_TO_DTCM; // FIR-Filter States

arm_fir_instance_q31 FIR_Filter MAP_TO_DTCM;
arm_fir_instance_q31 FIR_Filter2 MAP_TO_DTCM;

int32_t Filter_State_IIR[25] MAP_TO_DTCM; // IIR-Filter States
arm_biquad_casd_df1_inst_q31 IIR_Filter MAP_TO_DTCM;

int16_t Filter_State_IIR_2[30] MAP_TO_DTCM; // IIR-Filter States
arm_biquad_casd_df1_inst_q15 IIR_Filter_2 MAP_TO_DTCM;



/*** Functions **********************************************************************/


/***********************************************************************************/
/*
	processing_init

 	Initialization of the processing. This function is called once after start-up.
 	Init the CMSIS lib functions here if needed.
*/
/***********************************************************************************/
void processing_init(void){

arm_fir_init_q31(&FIR_Filter, 11, Koeff_FIR, Filter_State_FIR, BUFFER_SIZE_SAMPLES);
arm_fir_init_q31(&FIR_Filter2, 11, Koeff_FIR, Filter_State_FIR2, BUFFER_SIZE_SAMPLES);

arm_biquad_cascade_df1_init_q31(&IIR_Filter, 5, Koeff_IIR, Filter_State_IIR,1);
arm_biquad_cascade_df1_init_q15(&IIR_Filter_2, 5, Koeff_IIR_q15, Filter_State_IIR_2,1);

}
/************************************************************************************/



/***********************************************************************************/
/*
	audio_signal_processing

 	Main signal processing routine:
 	 - input_data_CH1:  input data channel 1, array length = BUFFER_SIZE_SAMPLES
 	 - input_data_CH2:  input data channel 2, array length = BUFFER_SIZE_SAMPLES
 	 - output_data_CH1: output data channel 1, array length = BUFFER_SIZE_SAMPLES
 	 - output_data_CH2: output data channel 2, array length = BUFFER_SIZE_SAMPLES

 	The samples are directly taken from the ADC without conversation. As the ADC has
 	a resolution of 24 bit, the input data goes from -2^23 to +2^23 - 1.

 	If floating point processing is used, the values are automatically converted to
 	the floating point version of the buffers:

 	 - input_data_CH1_f
 	 - input_data_CH2_f
 	 - output_data_CH1_f
 	 - output_data_CH2_f

*/
/***********************************************************************************/
void audio_signal_processing(int32_t * input_data_CH1, int32_t * input_data_CH2, int32_t * output_data_CH1, int32_t * output_data_CH2){
	uint32_t i;
	uint32_t k;

//

#define M 10 // Filter

static int16_t data_in_CH1_16[M+1]={0}; // Schieberegisterwerte
static int16_t data_in_CH2_16[M+1]={0}; // Schieberegisterwerte
int16_t sum_CH1_16=0;
int16_t sum_CH2_16=0;
int16_t Z16=3276; // entspricht 1/10; round(2^15/10)

static int32_t data_in_CH1_32[M+1]={0}; // Schieberegisterwerte
static int32_t data_in_CH2_32[M+1]={0}; // Schieberegisterwerte
int32_t sum_CH1_32=0;
int32_t sum_CH2_32=0;
int32_t Z32=214748365; // entspricht 1/10; round(2^31/10)
int32_t b_koeff[] = {2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647,2147483647};// entspricht 1 (2^31-1)
static int32_t w32=0,x32=0,y32=0;
static int16_t w16=0,x16=0,y16=0;

static int16_t data_out_CH2_16[1]={0}; // Schieberegisterwerte


	// ---------------------------------------------------------------------------------------
	// Initialization: generate floating point variants of the buffers if needed
	// ---------------------------------------------------------------------------------------
	#if USE_FP_PROCESSING == 1
		#if USE_FP_PROCESSING_ON_CH1 == 1
			float input_data_CH1_f[BUFFER_SIZE_SAMPLES];
			float output_data_CH1_f[BUFFER_SIZE_SAMPLES];
		#endif

		#if USE_FP_PROCESSING_ON_CH2 == 1
			float input_data_CH2_f[BUFFER_SIZE_SAMPLES];
			float output_data_CH2_f[BUFFER_SIZE_SAMPLES];
		#endif
	#endif

	#if USE_FP_PROCESSING == 1
		for(i = 0; i < BUFFER_SIZE_SAMPLES; i++){
			#if USE_FP_PROCESSING_ON_CH1 == 1
				input_data_CH1_f[i] = input_data_CH1[i];
			#endif

			#if USE_FP_PROCESSING_ON_CH2 == 1
			input_data_CH2_f[i] = input_data_CH2[i];
			#endif
		}
	#endif
	// ---------------------------------------------------------------------------------------


	BSP_LED_On(LED_GREEN);

	switch(user_mode){

		case 0:
		// ---------------------------------------------------------------------------------------
		// no mode selected by the user -> set output to 0
		// ---------------------------------------------------------------------------------------
			for(i = 0; i < BUFFER_SIZE_SAMPLES; i++){
				#if USE_FP_PROCESSING_ON_CH1 == 1
					output_data_CH1_f[i] = 0;
				#else
					output_data_CH1[i] = 0;
				#endif

				#if USE_FP_PROCESSING_ON_CH2 == 1
					output_data_CH2_f[i] = 0;
				#else
					output_data_CH2[i] = 0;
				#endif
			}
		// ---------------------------------------------------------------------------------------
		break;

		case 1:
			// ---------------------------------------------------------------------------------------
			// Mode 1 selected with GUI:
			// ---------------------------------------------------------------------------------------
			for(i = 0; i < BUFFER_SIZE_SAMPLES; i++){

				output_data_CH1[i] = input_data_CH1[i];
				output_data_CH2[i] = input_data_CH1[i];
			}



			// ---------------------------------------------------------------------------------------
			break;

		case 2:
			// ---------------------------------------------------------------------------------------
			// Mode 2 selected with GUI:
			// ---------------------------------------------------------------------------------------

			for (k=M; k>0;k--){// Werte im Schieberegister "schieben"
				data_in_CH1_32[k]=data_in_CH1_32[k-1];
				data_in_CH2_32[k]=data_in_CH2_32[k-1];
			}

			// neue ADC-Werte einlesen
			data_in_CH1_32[0]=((int64_t)(input_data_CH1[0]<<8)*Z32)>>31; // 24 bit ADC und Skalierung mit 1/10
			data_in_CH2_32[0]=((int64_t)(input_data_CH2[0]<<8)*Z32)>>31; // 24 bit ADC und Skalierung mit 1/10

			for (k=0; k<M; k++){

				sum_CH1_32=sum_CH1_32+(int32_t) (((int64_t) data_in_CH1_32[k]*(int64_t) b_koeff[k])>>31);
				sum_CH2_32=sum_CH2_32+(int32_t) (((int64_t) data_in_CH2_32[k]*(int64_t) b_koeff[k])>>31);

			}

			output_data_CH1[0]=sum_CH1_32>>8; // 24 bit DAC
			output_data_CH2[0]=sum_CH2_32>>8; // 24 bit DAC


			// ---------------------------------------------------------------------------------------
			break;

		case 3:
			// ---------------------------------------------------------------------------------------
			// Mode 3 selected with GUI:
			// ---------------------------------------------------------------------------------------

			input_data_CH1[0]=((int64_t)(input_data_CH1[0]<<8)*Z32)>>39;//input_data_CH1[0]=input_data_CH1[0]/M;
			arm_fir_q31(&FIR_Filter, (q31_t *)&input_data_CH1[0], (q31_t *)&output_data_CH1[0], BUFFER_SIZE_SAMPLES);

			input_data_CH2[0]=((int64_t)(input_data_CH2[0]<<8)*Z32)>>39;//input_data_CH2[0]=input_data_CH2[0]/M;
			arm_fir_q31(&FIR_Filter2, (q31_t *)&input_data_CH2[0], (q31_t *)&output_data_CH2[0], BUFFER_SIZE_SAMPLES);

			// ---------------------------------------------------------------------------------------
			break;

		case 4:
			// ---------------------------------------------------------------------------------------
			// Mode 4 selected with GUI:
			// ---------------------------------------------------------------------------------------

			output_data_CH1[0] = input_data_CH1[0];
			output_data_CH2[0] = input_data_CH1[0];


			// ---------------------------------------------------------------------------------------
			break;

		case 5:
			// ---------------------------------------------------------------------------------------
			// Mode 5 selected with GUI:
			// ---------------------------------------------------------------------------------------

			arm_biquad_cascade_df1_q31(&IIR_Filter, (q31_t *)&input_data_CH1[0], (q31_t *)&output_data_CH1[0], BUFFER_SIZE_SAMPLES);

			data_in_CH2_16[0]=input_data_CH2[0]>>8;  // 24 bit DAC
			arm_biquad_cascade_df1_q15(&IIR_Filter_2, (q15_t *)&data_in_CH2_16[0], (q15_t *)&data_out_CH2_16[0], BUFFER_SIZE_SAMPLES);
			output_data_CH2[0]=((int32_t)data_out_CH2_16[0])<<8;  // 24 bit DAC

			// ---------------------------------------------------------------------------------------
			break;

		default:
		// ---------------------------------------------------------------------------------------
		// undefined mode -> set output to 0
		// ---------------------------------------------------------------------------------------
			user_mode = 1;

			for(i = 0; i < BUFFER_SIZE_SAMPLES; i++){
				#if USE_FP_PROCESSING_ON_CH1 == 1
					output_data_CH1_f[i] = 0;
				#else
					output_data_CH1[i] = 0;
				#endif

				#if USE_FP_PROCESSING_ON_CH2 == 1
					output_data_CH2_f[i] = 0;
				#else
					output_data_CH2[i] = 0;
				#endif
			}
		// ---------------------------------------------------------------------------------------

		break;
	}


	BSP_LED_Off(LED_GREEN);


	// ---------------------------------------------------------------------------------------
	// Postprocessing: copy the processed data to the output buffer if needed
	// ---------------------------------------------------------------------------------------
#if USE_FP_PROCESSING == 1
	for(i = 0; i < BUFFER_SIZE_SAMPLES; i++){
#if USE_FP_PROCESSING_ON_CH1 == 1
		output_data_CH1[i] = output_data_CH1_f[i];
#endif

#if USE_FP_PROCESSING_ON_CH2 == 1
		output_data_CH2[i] = output_data_CH2_f[i];
#endif
	}
#endif
	// ---------------------------------------------------------------------------------------
}

/************************************************************************************/


/***********************************************************************************/
/*
	waveform_generator

	Waveform generator to test the output path of the codec.

*/
/***********************************************************************************/
void waveform_generator(int32_t * output_data_CH1, int32_t * output_data_CH2){
	uint32_t i;

	static double phase_accumulator = 0;
	double phase_increment;

	phase_increment = 2 * M_PI * (double)(wav_gen_output_frequency)/ (double)CODEC_SAMPLING_FREQUENCY;

	for(i = 0; i < BUFFER_SIZE_SAMPLES; i ++){
		switch(wav_gen){
		case WAV_SINUS:
			output_data_CH1[i] = sin(phase_accumulator) * (double)8388607;
			//	output_data_CH1[i] = mySin(phase_accumulator) * (double)8388607;
			output_data_CH2[i] = -output_data_CH1[i];
			break;

		case WAV_RECTANGLE:
			if(phase_accumulator >= M_PI){
				output_data_CH1[i] = 8388607;
				output_data_CH2[i] = -8388607;
			}

			else{
				output_data_CH1[i] = -8388607;
				output_data_CH2[i] = 8388607;
			}
			break;

		case WAV_SAWTOOTH:
			output_data_CH1[i] = phase_accumulator / (2 * M_PI) * 8388607 * 2 - 8388607;
			output_data_CH2[i] = -output_data_CH1[i];
			break;
		}

		phase_accumulator += phase_increment;

		if(phase_accumulator > (2 * M_PI)){
			phase_accumulator -= (2 * M_PI);
		}
	}
}
/***********************************************************************************/


