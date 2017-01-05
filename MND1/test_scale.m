
clear;
clc;

A = [
  1.00000000      2.00000000      3.00000000    ;
  1.00000000      1.00000000      1.00000000    ;
  3.00000000      3.00000000      1.00000000    ;
];

n = length(A);
for i=1:n
    d = 0;
    for k=1:n
        d = d + A(i,k);
    end
    d = 1 / d;
    A(i) = A(i) .* d;
end

A

%{
    for (i = 0; i < n; i++) {
        d[i] = 0;
        for (k = 0; k < n; k++) {
            d[i] += fabs(A[i][k]);
        }
        d[i] = 1.0 / d[i];
        for (k = 0; k < n; k++) {
            A[i][k] *= d[i];
        }
    }
%}