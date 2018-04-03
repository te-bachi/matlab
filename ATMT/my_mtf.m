
function [t2, y2] = my_mtf(A)
    t = A(:,1)';
    x = A(:,2)';

    figure;
    subplot(3, 1, 1);
    my_win(t, x)

    y = [0, diff(x)];
    subplot(3, 1, 2);
    my_win(t, y);

    s     = sum(y);
    y_fft = abs(fft(y)) / s;
    subplot(3, 1, 3);
    my_win(t, y_fft);

    N     = length(y_fft);
    y2    = y_fft(1:round(N/2));
    t2    = t(1:round(N/2));
end
