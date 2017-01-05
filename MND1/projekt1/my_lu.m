
function [L, U]=my_lu(A)

    [rows, cols] = size(A);
    
    if rows ~= cols
        error('rows and columns must match');
    end
    
    L = eye(rows, cols);
    U = A;
    
    for j = 1:cols
        for i = j + 1:rows
            L(i,j) = U(i,j) / U(j,j);
            for k = j:cols
                U(i,k) = U(i,k) - (L(i,j) * U(j,k));
            end
        end
    end

end