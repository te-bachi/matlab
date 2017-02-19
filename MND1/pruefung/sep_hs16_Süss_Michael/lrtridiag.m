function [l,r]=lrtridiag(a)
% Iterativer Tridiag-Gl-Löser
[m,n]=size(a);

r=zeros(n,n);
l=eye(n,n);

r(1,1)=a(1,1);
for j = (2:n)
    l(j,j-1) = a(j,j-1)/r(j-1,j-1);
    r(j-1,j) = a(j-1,j);
    r(j,j) = a(j,j)-l(j,j-1)*r(j-1,j);
end
