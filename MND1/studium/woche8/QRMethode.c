//
//  main.c
//  QRDecomposition
//
//  Created by Simon Iwan Stingelin on 19/08/15.
//  Copyright (c) 2015 ZHAW. All rights reserved.
//

#include <stdio.h>
#include <math.h>

#define N 2
#define M 3

int main(int argc, const char * argv[]) {

    double a[M][N] = {{3,7},{0,12},{4,1}};
    double d[N];
    double b[M] = {1,1,1};
    double QTb[N];
    
    double q[M][N] = {{1,0},{0,1},{0,0}};
    double r[N][M];
    double x[N];
    
// Berechnung von R
    for(int j=0; j<N; j++){
        double s = 0;
        for(int i=j; i<M; i++) s+= a[i][j]*a[i][j];
        s = sqrt(s);
        d[j] = (a[j][j]>0) ? -s : s;
        double alpha = sqrt(s*(s+fabs(a[j][j])));
        a[j][j] -= d[j];
        for(int k=j; k<M; k++) a[k][j] /= alpha;
        for(int i=j+1; i<N;i++){
            s=0;
            for(int k=j; k<M; k++) s += a[k][j]*a[k][i];
            for(int k=j; k<M; k++) a[k][i] -= a[k][j]*s;
        }
    }
    
// Zusammenstellen von R (nur illustrativ in a und d gespeichert)
    for(int i=0; i<N; i++){
        for(int j=i; j<N; j++){
            if(i==j)
                r[i][j] = d[i];
            else
                r[i][j] = a[i][j];
        }
    }

// Berechnung von Q^T b
    for(int j=0;j<N;j++){
        double s=0;
        for(int k=j;k<M;k++) s += a[k][j]*b[k];
        for(int k=j;k<M;k++) b[k] -= a[k][j]*s;
        QTb[j] = b[j];
    }
    
// Berechnung von Q (wird in der Regel nicht gemacht)
    for(int i=0;i<N;i++){
        for(int j=N-1;j>=0;j--){
            double s=0;
            for(int k=j;k<M;k++) s+= a[k][j]*q[k][i];
            for(int k=j;k<M;k++) q[k][i] -= a[k][j]*s;
        }
    }
    
    printf("Q = \n");
    for(int i=0; i<M;i++){
        for(int k=0; k<N; k++)
            printf("%12.6g\t",q[i][k]);
        printf("\n");
    }
    printf("\n\n");

    printf("R = \n");
    for(int i=0; i<N;i++){
        for(int k=0; k<N; k++)
            printf("%12.6g\t",r[i][k]);
        printf("\n");
    }
    printf("\n\n");
    
    printf("QTb = \n");
    for(int k=0; k<N; k++)
        printf("%12.6g\n",QTb[k]);
    printf("\n\n");


// Lösen von R x = Q^T b mittels Rückwärtseinsetzen
    x[N-1] = b[N-1]/d[N-1];
    for(int j=N-2; j>=0; j--){
        double sum=0;
        for(int k=j+1; k<N;k++)
            sum += a[j][k]*x[k];
//            sum += r[j][k]*x[k];
        x[j] = (QTb[j] - sum)/d[j];
//        x[j] = (QTb[j] - sum)/r[j][j];
    }
    
    printf("x = \n");
    for(int j=0;j<N;j++)
        printf("%f\n",x[j]);

    
    return 0;
}
