clc,clear close all

%A1 SEP 24.01.17
%a)
% syms x y z f(x,y,z)
% 
% f(x,y,z) = [1/3*sin(x)*cos(y);1/(2*(y+1));1/8*exp(-x^2-y^2-z^2)];
% 
% dx = diff(f,x)
% dy = diff(f,y)
% dz = diff(f,z)


%b)

diff = 1;
x=0.5;
y=0.5;
z =0.5;
u=[x;y;z];
F = @(u) [1/3*sin(u(1))*cos(u(2));1/(2*(u(2)+1));1/8*exp(-u(1)^2-u(2)^2-u(3)^2)];
eps = 1e-8;
itr = 0;
nmax = 50;
usol=u;
while(diff>eps) && (itr<nmax)
    ud = F(usol(:,end));
    diff = norm(ud-usol(:,end),'inf');
    usol=[usol,ud];
    itr = itr+1;
end
usol(:,end)
