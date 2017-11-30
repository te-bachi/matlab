function [ y ] = dft(x, N)

    y = zeros(1,N);

    for m = 0:N-1

        for n = 0:N-1
            %fprintf('%d / %d\n', m, n);
            y(m+1) = y(m+1) + x(n+1) * exp(-1i * ((2 * pi) / N) * m * n);
        end

    end
    
    %y = round(real(y), 3);
    y = round(y, 3) / N;
end

