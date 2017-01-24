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
    
    <<< snipp, selber machen >>>
    
    for(int j=0;j<n;j++)
        printf("%f\n",x[j]);
    
    return 0;
}
