
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

% Gr�sse der Matrix A bestimmen
[rows, cols]            = size(A);

% Einheitsmatrix erstellen aufgrund der Gr�sse der Matrix A
I                       = eye(rows);

% Householder-Funktion
H                       = @(i,w) (I(i:end,i:end) - 2 * (w*w')/(w'*w));

% d Vektor initialisieren auf Null-Vektor
d                       = zeros(rows, 1);

% Qt initialisieren auf Einheitsmatrix
Qt                      = I;

% Matrix Ai initialieren auf Matrix A
% Pages werden f�r jede Iteration gespeichert
Ai(:,:,1)               = A;

if (cols == rows)
    cols = cols - 1;
end
for i = 1:cols
    fprintf('=== %d. Schritt =================\n', i);
    
    % Ein Spalten-Vektor von der Einheitsmatrix extrahieren
    e                   = I(:,i);
    
    % Erster Spalten-Vektor der Untermatrix extrahieren
    y                   = Ai(i:end,i,i);
    
    % Diagonalelement berechnen
    %d(i)                = sign(y(1)) * norm(y);
    d(i)                = norm(y);
    
    % Vektor w berechnen
    w                   = y + d(i) * e(i:end);
    
    % Initialisiere Vollmatrix Pi mit Einheitsmatrix
    Qi(:,:,i)           = I;
    
    % Speichere Untermatrix der Householder-Funktion
    % in Vollmatrix Pi
    Qi(i:end,i:end,i)   = H(i,w);
    
    % Berechne neue Matrix Ri mit alter Matrix Pi 
    % und alter Matrix Ri (Unterer Spalten-Vektor => Null)
    Ai(:,:,i+1)         = Qi(:,:,i) * Ai(:,:,i);
    
    Qt                  = Qi(:,:,i) * Qt;
    
    printmat('y', y);
    printmat('d', d(i,1));
    printmat('w', w);
    printmat('Qi', Qi(:,:,i));
    printmat('Ai', Ai(:,:,i+1));
    printmat('Qt', Qt);
end

fprintf('****************************************\n');
printmat('d', d);

fprintf('=== Q*R = A =================\n');

% === Q ===
Q      = Qt';
printmat('Q', Q);

% === R ===
R = A;
for j = 1:i
    R = Qi(:,:,j) * R;
end
printmat('R', R);

printmat('A', Q*R);

