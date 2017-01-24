//
//  main.c
//  CholeskyVerfahren
//
//  Created by Simon Iwan Stingelin on 12/08/15.
//  Copyright (c) 2015 ZHAW. All rights reserved.
//
//
//  main.c
//  FinalLR
//
//  Created by Simon Iwan Stingelin on 12/08/15.
//  Copyright (c) 2015 ZHAW. All rights reserved.
//

#include <stdio.h>
#include <math.h>

#define N 4

void printmat(double A[N][N])
{
    for(int i=0; i<N;i++){
        for(int k=0; k<N; k++)
            printf("%12.6g\t",A[i][k]);
        printf("\n");
    }
    printf("\n");
}

int main(int argc, const char * argv[]) {
    double A[N][N] = {{2, 1, 3, -1},
        {1, 5, 1, -1},
        {3, 1, 10, -6},
        {-1, -1, -6, 8}}; // Matrix
    
    printf("Original Matrix A\n");
    printmat(A);
    
    for(int k=0; k<N;k++){
    	// Sum lkj^2 djj
        double sum = 0;
        for(int j=0; j<k;j++){
            sum += A[k][j]*A[k][j]*A[j][j];
        }
        double diag = A[k][k] - sum;
        if(diag < 0){
            printf("Falsche Matrix Struktur\n%g\t%g\n",diag,1e-5*A[k][k]);
            break;
        }
        A[k][k] = diag;
        
        for(int i = k+1; i<N; i++){
	    	// Sum lij djj lkj
            double sum=0;
            for(int j=0; j<k; j++){
                sum += A[i][j]*A[j][j]*A[k][j];
            }
            
            A[i][k] = (A[i][k] - sum)/A[k][k];
        }
    }
    
    
    printf("Cholesky Decomposed Matrix A\n");
    printmat(A);
    
    
    return 0;
}
