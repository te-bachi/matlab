
function z=lr_forward(L,b)
    n    = length(L);
    z    = zeros(n, 1);
    z(1) = b(1);
    
    %{
    disp(['L = ' num2str(L)]);
    disp(['b = ' num2str(b)]);
    disp(['n = ' num2str(n)]);
    disp(['z = ' num2str(n)]);
    %}
    
    for k=2:n
        z(k) = b(k) - L(k, (1:(k-1))) * z(1:(k-1));
    end
end