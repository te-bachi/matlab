
function printmat(str, A)
    [rows, cols] = size(A);
    fprintf('%s = \n', str);
    for i = 1:rows
        fprintf('\t');
        fprintf('%14.10f\t', A(i,:));
        fprintf('\n');
    end;
    fprintf('\n');    
end
