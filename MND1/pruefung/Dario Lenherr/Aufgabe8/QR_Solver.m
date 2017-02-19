%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QR ZERLEGUNG                %
% James Kiwic HS16 MND1       %
% v1                28.12.2016%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x] = QR_Solver(A,b)

% Parameter
[m n] = size(A);


% Matrix des Gleichungs systems Ax = b
%A = [1,2; 2,5;]


% Vektor/Matrix des Gleichungssystems Ax = b
%b = eye(n);
 

% QR zerlegung
[Q,R] = qr(A);     %Q=Transformationsmatrix, R=rechtsobere
x = zeros(n,length(b(1,:)));
% Auflösen
for j=1:length(b(1,:))
    %löse R*x = Q'*b
    x(:,j) = backward(R,Q'*b(:,j))
end