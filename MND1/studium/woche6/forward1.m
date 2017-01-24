function z=forward1(L,b)

n=length(L);
z=zeros(n,1);

z(1)=b(1);
for k=2:n
    z(k)=b(k)-L(k,(1:(k-1)))*z(1:(k-1));
end
