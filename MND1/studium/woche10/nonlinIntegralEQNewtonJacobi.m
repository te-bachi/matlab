function y=nonlinIntegralEQNewtonJacobi(x,u,p)
n=length(u);

y=eye(n)+1/n*cos(4*pi*x*x').^2*diag((u.^(p-1)));
