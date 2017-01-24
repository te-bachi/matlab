function yi=splinePoly(x,xi,fi,mi)

n=length(xi)-1;
yi=[fi(1)];
h=xi(2)-xi(1);

for j=(1:n)
    ind = (xi(j)<x)&(x<=xi(j+1));
    y1 = ((xi(j+1)-x(ind)).^3*mi(j)+(x(ind)-xi(j)).^3*mi(j+1))/(6*h);
    y2 = ((xi(j+1)-x(ind))*fi(j)   +(x(ind)-xi(j))*fi(j+1))/h ;
    y3 = -h/6*((xi(j+1)-x(ind))*mi(j)   +(x(ind)-xi(j))*mi(j+1));
    sum = y1+y2+y3;
    yi=[yi, sum];
end
