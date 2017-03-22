function  z = forward(L,b)
%Diese Funktion ist normiert
n = length(L);
z = zeros(n,1);

z(1) = b(1)/L(1,1);
for k=2:n
    z(k)=b(k)-L(k,(1:(k-1)))*z(1:(k-1))/L(k,k);
end
