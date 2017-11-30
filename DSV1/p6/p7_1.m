clear;
close all;
clc;

% "FIR"
M=[4 11 50 101];
for m = M
    b = ones(m,1) / m;
    [H W] = freqz(b,1,2^15);
    GLZ   = grpdelay(b,1,2^15);
    PLZ   = phasedelay(b,1,2^15);
    W     = W/2/pi;
    
    figure(1);semilogx(W,20*log10(abs(H)),'LineWidth',1);hold on;
    figure(2);plot(W,GLZ,'LineWidth',1); hold on;
    figure(3);plot(W,PLZ,'LineWidth',1); hold on;
end

figure(1);
axis([1e-3 0.5 -50 0]);
grid on;
legend('M=4','M=11','M=50','M=101','Location','southwest');
xlabel('f \rightarrow [f_s]');
ylabel('Amplitudengang \rightarrow [dB]');

figure(2);
axis([1e-3 0.5 0 60]);
grid on;
legend('M=4','M=11','M=50','M=101','Location','northeast');
xlabel('f \rightarrow [f_s]');
ylabel('Gruppenlaufzeit \rightarrow [Samples]');

figure(3);
axis([1e-3 0.5 0 60]);
grid on;
legend('M=4','M=11','M=50','M=101','Location','northeast');
xlabel('f \rightarrow [f_s]');
ylabel('Phasenlaufzeit \rightarrow [Samples]');
