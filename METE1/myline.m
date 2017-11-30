function [ ] = myline()
    persistent i;
    if isempty(i)
        i = 0;
    end
    i = i + 1;
    fprintf('- %02d ----------------------------------------------------------------------\n', i);
end

