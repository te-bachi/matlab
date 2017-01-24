/*==========================================================
 * forward.c - example in MATLAB External Interfaces
 *
 * lower triangle Matrix Solver
 *
 * The calling syntax is:
 *
 *		x = forward(L,b)
 *
 * This is a MEX-file for MATLAB.
 * Copyright 2016, ZHAW / stiw
 *
 *========================================================*/

#include "mex.h"

void forward(double *L, double *b, double *x, mwSize n)
{
    mwSize j;

    x[0] = b[0]/L[0];
    
    for (j=1; j<n; j++){
        double sum=0;
        for(mwSize i=0; i<j; i++) sum += L[j*n+i]*x[i];
        x[j] = (b[j] - sum)/L[j+j*n];
    }
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double *L;              /* NxN matrix */
    double *b;               /* Nx1 input matrix */
    
    size_t nrow;                   /* size of matrix */
    double *x;              /* output matrix */

    /* check for proper number of arguments */
    if(nrhs!=2) {
        mexErrMsgIdAndTxt("forward","Two inputs required.");
    }
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("tridiagsolver","One output required.");
    }
    
    /* make sure the first input argument is type double */
    if( !mxIsDouble(prhs[0]) || 
         mxIsComplex(prhs[0]) ) {
        mexErrMsgIdAndTxt("tridiagsolver:arrayProduct:notDouble","Input matrix must be a double.");
    }
    
    /* make sure the second input argument is type double */
    if( !mxIsDouble(prhs[1]) || 
         mxIsComplex(prhs[1])) {
        mexErrMsgIdAndTxt("tridiagsolver:notDouble","Input matrix must be type double.");
    }
        
    /* create a pointer to the real data in the input matrix  */
    L = mxGetPr(prhs[0]);
    b  = mxGetPr(prhs[1]);

    /* get dimensions of the input matrix */
    nrow = mxGetM(prhs[0]);

    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)nrow,1,mxREAL);

    /* get a pointer to the real data in the output matrix */
    x = mxGetPr(plhs[0]);

    /* call the computational routine */
    forward(L,b,x,(mwSize)nrow);
}

