
function [A, P]=my_permute(A, P)
    [rows, cols] = size(A);

    for j = 1:cols
        p = j;
        for i = (j+1):rows
            if (abs(A(p,j)) <= abs(A(i,j)))
                p = i;
            end
        end

        if (p ~= j)
            A([p j],:) = A([j p],:);
            P([p j],:) = P([j p],:);
        end

    end
end
