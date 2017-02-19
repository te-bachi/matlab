clc, clear all, clf;
f=@(x) (1./sqrt(pi)).*exp(-x.^2);

x=[-1 -0.4 0 0.4 1];
plot(x,f(x))

%% Interpolation
x=[-1,-.4,0,.4,1];
n=length(x)+1

yf=f(x); % Vorsicht: f(0) ist unbestimmt
yf(3) = 1; % Korrektur, Grenzwert existiert.
df = yf;

s=[df(1)];


k=1;
while  (length(df) >1)
    df=(df(2:end)-df(1:(end-1)))./(x((1+k):end)-x(1:(end-k)));
    s=[s,df(1)];
    k=k+1;
end
s

%% Graphische Darstellung
xPlot=linspace(-1,1,300);
yPoly=newtonPolynom(xPlot,x,s);

plot(xPlot,yPoly)
hold on
plot(xPlot,f(xPlot),'--')
plot(x,yf,'o')


