f = @(x) 1./(1+x.^2);

%% n=6
x=linspace(-5,5,7);
n=length(x)+1

s=[f(x(1))];
df=f(x);

k=1;
while  (length(df) >1)
    df=(df(2:end)-df(1:(end-1)))./(x((1+k):end)-x(1:(end-k)));
    s=[s,df(1)];
    k=k+1;
end
x6=x;
s6=s;

%% n=9
x=linspace(-5,5,10);
n=length(x)+1

s=[f(x(1))];
df=f(x);

k=1;
while  (length(df) >1)
    df=(df(2:end)-df(1:(end-1)))./(x((1+k):end)-x(1:(end-k)));
    s=[s,df(1)];
    k=k+1;
end
x9=x;
s9=s;

%% n=15
x=linspace(-5,5,16);
n=length(x)+1

s=[f(x(1))];
df=f(x);

k=1;
while  (length(df) >1)
    df=(df(2:end)-df(1:(end-1)))./(x((1+k):end)-x(1:(end-k)))
    s=[s,df(1)]
    k=k+1;
end
x15=x;
s15=s;

%% Graphische Darstellung
xPlot=linspace(-5,5,300);
yPoly6=newtonPolynom(xPlot,x6,s6);
yPoly9=newtonPolynom(xPlot,x9,s9);
yPoly15=newtonPolynom(xPlot,x15,s15);

plot(xPlot,yPoly6)
hold on
plot(xPlot,yPoly9)
plot(xPlot,yPoly15)
plot(xPlot,f(xPlot),'--')
plot(x,f(x),'o')