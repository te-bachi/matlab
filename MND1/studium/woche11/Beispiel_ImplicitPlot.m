f1=@(x,y) exp(1-x)-cos(y)+2/10;
f2=@(x,y) x.^2+y-(1+y).*x-sin(x)-2/10;

x=linspace(-2,5,100);
y=linspace(-4,10,100);

[x,y] = meshgrid(x,y);
f1=f1(x,y);
f2=f2(x,y);

contour(x,y,f1,[0 0],'b');
hold on
contour(x,y,f2,[0 0],'r');
