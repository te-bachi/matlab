
clear;
clc;

% dim(A) = 8x5
A                       = [  2,  2,  3,  6,  2  ;
                             1,  7,  5,  2,  7  ;
                             4,  1,  2,  3,  1  ;
                             6,  2,  2,  4,  8  ;
                             1,  3,  7,  2,  9  ;
                             1,  2,  3,  4,  5  ;
                             9,  8,  7,  5,  4  ;
                             5,  4,  5,  4,  5 ];

printmat('A', A);

% Grösse der Matrix A bestimmen
[rows, cols]            = size(A);

% Einheitsmatrix erstellen aufgrund der Grösse der Matrix A
I                       = eye(rows);

% Householder-Funktion
H                       = @(i,w) (I(i:end,i:end) - 2 * (w*w')/(w'*w));

% d Vektor initialisieren auf Null-Vektor
d                       = zeros(rows, 1);

% Qt initialisieren auf Einheitsmatrix
Qt                      = I;

% Matrix Ri initialieren auf Matrix A
% Pages werden für jede Iteration gespeichert
Ri(:,:,1)               = A;

for i = 1:cols
    fprintf('=== %d. Schritt =================\n', i);
    
    % Ein Spalten-Vektor von der Einheitsmatrix extrahieren
    e                   = I(:,i);
    
    % Erster Spalten-Vektor der Untermatrix extrahieren
    y                   = Ri(i:end,i,i);
    
    % Diagonalelement berechnen
    d(i)                = sign(y(1)) * norm(y);
    
    % Vektor w berechnen
    w                   = y + d(i) * e(i:end);
    
    % Initialisiere Vollmatrix Pi mit Einheitsmatrix
    Pi(:,:,i)           = I;
    
    % Speichere Untermatrix der Householder-Funktion
    % in Vollmatrix Pi
    Pi(i:end,i:end,i)   = H(i,w);
    
    % Berechne neue Matrix Ri mit alter Matrix Pi 
    % und alter Matrix Ri (Unterer Spalten-Vektor => Null)
    Ri(:,:,i+1)         = Pi(:,:,i) * Ri(:,:,i);
    
    Qt                  = Pi(:,:,i) * Qt;
    
    printmat('y', y);
    printmat('d', d(i,1));
    printmat('w', w);
    printmat('Pi', Pi(:,:,i));
    printmat('Ri', Ri(:,:,i+1));
    printmat('Qt', Qt);
end

fprintf('****************************************\n');
printmat('d', d);


fprintf('=== P5*P4*P3*P2*P1*A = R =================\n');
R = Pi(:,:,5)*Pi(:,:,4)*Pi(:,:,3)*Pi(:,:,2)*Pi(:,:,1)*A;
printmat('R', R);

fprintf('=== Q*R = A =================\n');
Qtotal = Pi(:,:,5)*Pi(:,:,4)*Pi(:,:,3)*Pi(:,:,2)*Pi(:,:,1);
printmat('Qtotal', Qtotal);
printmat('Qt', Qt);
Q      = Qt';
printmat('A', Q*R);

