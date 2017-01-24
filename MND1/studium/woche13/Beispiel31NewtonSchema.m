x = [2,4,6,8,10];
T = [40,20,10,6,4];

n=length(x)+1

s=[T(1)];
df=T;

k=1;
while  (length(df) >1)
    df=(df(2:end)-df(1:(end-1)))./(x((1+k):end)-x(1:(end-k)))
    s=[s,df(1)]
    k=k+1;
end

xPlot=linspace(2,10,150);
yPoly=newtonPolynom(xPlot,x,s);

plot(xPlot,yPoly)
hold on
plot(x,T,'o')