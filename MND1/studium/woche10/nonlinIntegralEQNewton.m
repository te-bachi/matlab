function y=nonlinIntegralEQNewton(x,u,p)
n=length(u);

y=u+1/(n*p)*cos(4*pi*x*x').^2*(u.^p)-1;
