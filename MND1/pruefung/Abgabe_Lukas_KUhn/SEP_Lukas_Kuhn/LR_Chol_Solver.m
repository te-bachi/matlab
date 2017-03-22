%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LR Cholesky ZERLEGUNG       %
% James Kiwic HS16 MND1       %
% v1                28.12.2016%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x = LR_Chol_Solver(A,b)
% Parameter
[m n] = size(A);


v = eig(A);
if v(1:length(v)) <= 0
    disp('matrix is not pos definit');
    return 
end


% Matrix des Gleichungs systems Ax = b
%A = [1,2; 2,5;]

% Vektor/Matrix des Gleichungssystems Ax = b
%b = eye(n)

% Cholesky Zerlegung
[R] = chol(A);
x = zeros(m,length(b(1,:)));

% Auflösen
for j = 1:length(b(1,:));
    clear y;
    y = forward(R,b(:,j));
    x(:,j) = backward(R',y);
end