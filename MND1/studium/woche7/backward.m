function x = backward(a,b)
    n=length(a);
    x=zeros(n,1);
    
    x(n) = b(n)/a(n,n);
    for j = (n-1:-1:1)
        x(j) = (b(j) - a(j,(j+1:n))*x(j+1:n))/a(j,j);
    end
    
return;
