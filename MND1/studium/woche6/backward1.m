function x=backward1(R,b)

n=length(R);
x=zeros(n,1);

x(n)=b(n)/R(n,n);
for k=n-1:-1:1
    x(k)=(b(k)-R(k,((k+1):n))*x((k+1):n))/R(k,k);
end
