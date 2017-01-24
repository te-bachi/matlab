//
//  main.c
//  Rueckwaertseinsetzen
//
//  Created by Simon Iwan Stingelin on 12/08/15.
//  Copyright (c) 2015 ZHAW. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    int n=3;
    double A[3][3] = {{3,-1,2},{0,1,3},{0,0,2}};
    double b[3] = {0,1,4};
    double x[3];
    
    x[2] = b[2]/A[2][2];
    for(int j=n-2; j>=0; j--){
        double sum=0;
        for(int k=j+1; k<n;k++)
            sum += A[j][k]*x[k];
        x[j] = (b[j] - sum)/A[j][j];
    }
    
    for(int j=0;j<n;j++)
        printf("%f\n",x[j]);
    
    return 0;
}
