%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LR TRIDIAG                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter

function [L,R]=LR_Tridiag_Solver(A)
[m,n]=size(A);

R=zeros(n,n);
L=eye(n,n);

R(1,1)=A(1,1);
for j = (2:n)
    L(j,j-1) = A(j,j-1)/R(j-1,j-1);
    R(j-1,j) = A(j-1,j);
    R(j,j) = A(j,j)-L(j,j-1)*R(j-1,j);
end
