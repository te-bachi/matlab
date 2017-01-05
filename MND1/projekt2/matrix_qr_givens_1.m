
clear;
clc;

A                       = [  2,  2,  3,  6,  2  ;
                             1,  7,  5,  2,  7  ;
                             4,  1,  2,  3,  1  ;
                             6,  2,  2,  4,  8  ;
                             1,  3,  7,  2,  9  ;
                             1,  2,  3,  4,  5  ;
                             9,  8,  7,  5,  4  ;
                             5,  4,  5,  4,  5 ];

printmat('A', A);

[rows, cols]            = size(A);
I                       = eye(rows);

% Funktionen fuer die Berechnung der sinus, cosinus Werte
s                       = @(a,b) sign(a) * b/sqrt(a^2+b^2);
c                       = @(s) sqrt(1-s^2);

Qt                      = I;
Ri(:,:,1)               = A;

k = 1;
for j = 1:cols
    for i = 1:rows
        if (i > j)
            fprintf('=== %d. Schritt (%d/%d) =================\n', k, i, j);
            
            s1              = s(Ri(j,j,k), Ri(i,j,k));
            c1              = c(s1);
            
            Qi(:,:,k)       = I;
            Qi(j,j,k)       = c1;
            Qi(i,i,k)       = c1;
            Qi(i,j,k)       = -s1;
            Qi(j,i,k)       = s1;
            
            Ri(:,:,k + 1)   = Qi(:,:,k) * Ri(:,:,k);
            
            printmat('Qi', Qi(:,:,k));
            printmat('Ri', Ri(:,:,k + 1));
            
            R               = Ri(:,:,k + 1);
            Qt              = Qi(:,:,k) * Qt;
            
            k               = k + 1;
        end
    end
end

fprintf('=== Resultat =================\n');
Q = Qt';
printmat('Q', Q);
printmat('R', R);
printmat('Q*R', Q*R);
