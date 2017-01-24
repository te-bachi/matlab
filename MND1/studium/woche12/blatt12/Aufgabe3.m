b=dlmread('../Aufgaben/dataAufgabe3.txt');
imshow(b)
colormap(flipud(gray))

[m,n] = size(b);

% Koordinaten der Ellipse ermitteln
boundary=[];
for i=(1:m)
    for j=(1:n)
        if b(i,j)==1
            boundary = [boundary [i;j]];
        end
    end
end

boundary = boundary';

xi = boundary(:,1);
yi = boundary(:,2);
A = [xi.^2,2*xi.*yi,yi.^2,2*xi,2*yi];
[Q,R] = qr(A);
p=backward(R(1:5,:),-Q'*ones(length(boundary),1));

a=p(1);
h=p(2);
b=p(3);
g=p(4);
f=p(5);

C=a*b-h^2;
R=sqrt((a-b)^2+4*h^2);
D=a*(-b+f^2)+b*g^2+h*(-2*f*g+h);

x0=(h*f-b*g)/C
y0=(g*h-a*f)/C

rmax=sqrt(2*D/(C*(a+b-R)))
rmin=sqrt(2*D/(C*(a+b+R)))

angle = -asin(sqrt(a-b+R)/sqrt(2*R))

t=linspace(-pi,pi,200);
x=x0+rmax*cos(angle)*cos(t) - rmin*sin(angle)*sin(t);
y=y0+rmax*cos(t)*sin(angle) + rmin*cos(angle)*sin(t);

hold on
plot(y,x,'r*-')
