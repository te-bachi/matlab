function y=nonlinIntegralEQFixPkt(x,u,p)
n=length(u);

y=1-1/(n*p)*cos(4*pi*x*x').^2*(u.^p);
