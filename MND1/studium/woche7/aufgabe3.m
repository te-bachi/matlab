y=[0.5,0.0249,0.00124,0.0000617]';
t=(0:3)';

A=[ones(4,1),t];

x= A'*A\(A'*log(y))

ti=linspace(0,3,100);

plot(ti,exp(x(1))*exp(x(2)*ti))
hold on
plot(t,y,'o')
