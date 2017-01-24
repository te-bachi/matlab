load diode_UI_kennline.mat

y = log(Im)';
upn = Um;
m=length(y)

A = [ones(m,1),upn']

[q,r] = qr(A,0);

x = backward(r, q'*y)

Is = exp(x(1))
UT = 1/x(2)

upnPlot = 10.^linspace(log10(min(upn)),log10(max(upn)),100);

semilogy(Um,Im,'ro')
hold on
semilogy(upnPlot, Is*exp(1/UT*upnPlot))
xlabel('Upn')
ylabel('ID')