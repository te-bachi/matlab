clc,clear

%A5 SEP 24.01.17

%a)Graphische Darstellung

% syms x y f(x,y)
% ezplot(10*(x-2/3)^2+(y-1/2)^2-3),hold on
% ezplot((x-1)^4+(y-1/2)^4-1),grid

%b)

diff = 1;
x=0.5;
y=0.5;
u=[x;y];
F = @(u) [1/sqrt(10)*(sqrt(3)-u(2)+7/6);-u(1)+9/2]
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