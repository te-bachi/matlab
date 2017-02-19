function y = newtonPolynom(x,xi,deltan)

n=length(xi);
y=0;
for k=(n:-1:2)
    y = (y+deltan(k)).*(x-xi(k-1));
end
y=y+deltan(1);
