
function x=chol_backward(R,b)
    n    = length(R);
    x    = zeros(n, 1);
    x(n) = b(n) / R(n,n);
    
    %{
    disp(['L = ' num2str(L)]);
    disp(['b = ' num2str(b)]);
    disp(['n = ' num2str(n)]);
    disp(['z = ' num2str(n)]);
    %}
    
    for k=n-1:-1:1
        x(k) = (b(k) - R(k, ((k+1):n)) * x((k+1):n)) / R(k,k);
    end
end