function mat = d2phiBeispiel222(t,x,b)
f = @(t,x) x(1)*exp(-x(2)*t).*sin(x(3)*t+x(4));
%d2f = (d2f/(dxi dxj))_{i,j=1,..,4}
d2f = @(t,x) [0, -t.*exp(-x(2)*t).*sin(x(3)*t+x(4)), t.*exp(-x(2)*t).*cos(x(3)*t+x(4)), exp(-x(2)*t).*cos(x(3)*t+x(4));
 -t.*exp(-x(2)*t).*sin(x(3)*t+x(4)),  t.^2*x(1).*exp(-x(2)*t).*sin(x(3)*t+x(4)),  -t.^2*x(1).*exp(-x(2)*t).*cos(x(3)*t+x(4)),  -t.*x(1).*exp(-x(2)*t).*cos(x(3)*t+x(4));
 exp(-x(2)*t).*t.*cos(x(3)*t+x(4)), -t.^2.*x(1)*exp(-x(2)*t).*cos(x(3)*t+x(4)), -x(1)*exp(-x(2)*t).*t.^2.*sin(x(3)*t+x(4)), -x(1)*exp(-x(2)*t).*t.*sin(x(3)*t+x(4));
 exp(-x(2)*t).*cos(x(3)*t+x(4)), -t.*x(1)*exp(-x(2)*t).*cos(x(3)*t+x(4)), -x(1)*exp(-x(2)*t).*t.*sin(x(3)*t+x(4)), -x(1)*exp(-x(2)*t).*sin(x(3)*t+x(4))];

n=length(x);
mat=zeros(n,n);
for i=(1:length(t))
    mat = mat + d2f(t(i),x)*(f(t(i),x)-b(i));
end
