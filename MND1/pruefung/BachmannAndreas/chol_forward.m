
function z=chol_forward(L,b)
    n    = length(L);
    z    = zeros(n, 1);
    z(1) = b(1)/L(1,1);
    
    %fprintf('test\n');
    for k=2:n
        %fprintf('k=%d: (%f - %f) / %f \n\n', k, b(k), L(k, (1:(k-1))) * z(1:(k-1)), L(k,k));
        z(k) = (b(k) - L(k, (1:(k-1))) * z(1:(k-1))) / L(k,k);
    end
end