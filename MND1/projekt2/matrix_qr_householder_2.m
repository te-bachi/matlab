
clear;
clc;

A                       = [  2,  2,  3,  6,  2  ;
                             1,  7,  5,  2,  7  ;
                             4,  1,  2,  3,  1  ;
                             6,  2,  2,  4,  8  ;
                             1,  3,  7,  2,  9 ];

printmat('A', A);

[rows, cols]            = size(A);
I                       = eye(rows);
H                       = @(i,w) (I(i:end,i:end) - 2 * (w*w')/(w'*w));

Ai(:,:,1)               = A;
for i = 1:(rows - 1)
    fprintf('=== %d. Schritt =================\n', i);
    e                   = I(:,i);
    y                   = Ai(i:end,i,i);
    w                   = y + sign(y(1)) * norm(y) * e(i:end);
    Q(:,:,i)            = I;
    Q(i:end,i:end,i)    = H(i,w);
    Ai(:,:,i+1)         = Q(:,:,i) * Ai(:,:,i);
    
    printmat('s', sum(Ai(i:end,i,i).^2));
    printmat('y', y);
    printmat('Q', Q(:,:,i));
    printmat('A', Ai(:,:,i+1));
end

fprintf('=== Q4*Q3*Q2*Q1*A = R =================\n');
R = Q(:,:,4)*Q(:,:,3)*Q(:,:,2)*Q(:,:,1)*A;
printmat('R', R);

fprintf('=== Q*R = A =================\n');
Qtotal = (Q(:,:,4)*Q(:,:,3)*Q(:,:,2)*Q(:,:,1))';
printmat('A', Qtotal*R);

