
function printmat(str, A)
    fprintf('%s = \n', str);
    for i = 1:length(A)
        fprintf('\t');
        fprintf('%14.10f\t', A(i,:));
        fprintf('\n');
    end;
    fprintf('\n');    
end
