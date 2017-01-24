/*==========================================================
 * tridiagsolver.c - example in MATLAB External Interfaces
 *
 * tridiagnoal Matrix Solver
 *
 * The calling syntax is:
 *
 *		x = tridiagsolver(ad,al,au,b)
 *
 * This is a MEX-file for MATLAB.
 * Copyright 2016, ZHAW / stiw
 *
 *========================================================*/

#include "mex.h"

void tridiagsolver(double *ad, double *al, double *au, double *b, double *x, mwSize n)
{
    mxArray *ym;
    double *y;
    mwSize j;
    
    ym = mxCreateDoubleMatrix((mwSize)n,1,mxREAL);
    y = mxGetPr(ym);
    
    // mexPrintf("%d\n", n);
    // ad au 0
    // al ad au
    // 0  al ad
    for (j=1; j<n; j++){
        al[j-1] /= ad[j-1];
        ad[j] -= al[j-1]*au[j-1];
    }
    // Vorwaerts einsetzen
    y[0] = b[0];
    for (j=1; j<n; j++){
        y[j] = b[j] - al[j-1]*y[j-1];
    }
    // Rueckwaerts einsetzen
    x[n-1] = y[n-1]/ad[n-1];
    for (j=n-2; j >= 0; j--){
        x[j] = (y[j] - au[j]*x[j+1])/ad[j];
    }
    mxDestroyArray(ym);
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double *ad;              /* Nx1 matrix */
    double *al;              /* Nx1 matrix */
    double *au;              /* Nx1 matrix */
    double *b;               /* Nx1 input matrix */
    
    size_t nrow;                   /* size of matrix */
    double *x;              /* output matrix */

    /* check for proper number of arguments */
    if(nrhs!=4) {
        mexErrMsgIdAndTxt("tridiagsolver","Four inputs required.");
    }
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("tridiagsolver","One output required.");
    }
    
    /* make sure the first input argument is scalar */
    if( !mxIsDouble(prhs[0]) || 
         mxIsComplex(prhs[0]) ) {
        mexErrMsgIdAndTxt("tridiagsolver:notDouble","Input matrix must be type double.");
    }
    
    /* make sure the second input argument is type double */
    if( !mxIsDouble(prhs[1]) || 
         mxIsComplex(prhs[1])) {
        mexErrMsgIdAndTxt("tridiagsolver:notDouble","Input matrix must be type double.");
    }
    
    /* make sure the third input argument is type double */
    if( !mxIsDouble(prhs[2]) || 
         mxIsComplex(prhs[2])) {
        mexErrMsgIdAndTxt("tridiagsolver:notDouble","Input matrix must be type double.");
    }

    /* make sure the fourth input argument is type double */
    if( !mxIsDouble(prhs[3]) || 
         mxIsComplex(prhs[3])) {
        mexErrMsgIdAndTxt("tridiagsolver:notDouble","Input matrix must be type double.");
    }

    /* check that number of rows in second input argument is 1 */
    
    if(mxGetN(prhs[1])!=1) {
        mexErrMsgIdAndTxt("tridiagsolver:notRowVector","Input must be a row vector.");
    }
    
    /* create a pointer to the real data in the input matrix  */
    ad = mxGetPr(prhs[0]);
    al = mxGetPr(prhs[1]);
    au = mxGetPr(prhs[2]);
    b  = mxGetPr(prhs[3]);

    /* get dimensions of the input matrix */
    nrow = mxGetM(prhs[0]);
    //mexPrintf("%d\n", nrow);
    
    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)nrow,1,mxREAL);

    /* get a pointer to the real data in the output matrix */
    x = mxGetPr(plhs[0]);

    /* call the computational routine */
    tridiagsolver(ad,al,au,b,x,(mwSize)nrow);
}

