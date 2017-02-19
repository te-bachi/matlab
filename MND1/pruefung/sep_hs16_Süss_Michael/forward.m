function x = forward(a,b)
%% funktion z = forward(L,Atb) oder funktion z = forward(L,P*b)


    n=length(a);
    x=zeros(n,1);
    
    x(1) = b(1)/a(1,1);
    for j = (2:n)
        x(j) = (b(j) - a(j,(1:j-1))*x(1:j-1))/a(j,j);
    end
    
return;
