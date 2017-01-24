%% Data Interpolation
% fuer kubische Splines!

% Spline Ordnung
k=4;
% St?tzstellen f?r die Splines
nodes = linspace(0,1,6);
l=length(nodes)-2
% erweiterte Knotenmenge
extnodes= [nodes(1)*ones(1,k-1),nodes,nodes(end)*ones(1,k)];

% Messdaten basierend auf sinus Funktion
f = @(x) sin((4 *pi)./(1 + 1/4*x.^2).*x).* (x.* (x - 1));

% Import der Messdaten
data = importdata('messung_spline.txt');
ti = data(:,1);
fi = data(:,2);
m=length(data)

% 
A=zeros(m,l+k);
b=zeros(m,1);
for i=(1:m)
    for j=(1:l+k)
        A(i,j) = BSplineBasis(k,extnodes,j,ti(i));
    end
    b(i) = fi(i);
end


[q,r] = qr(A,0);
c = backward(r,q'*b);

% plot x-Data
x=linspace(min(ti),max(ti),500);

% spline interpolation
y=c(1)*BSplineBasis(k,extnodes,1,x);
for i=(2:l+k)
    y = y + c(i)*BSplineBasis(k,extnodes,i,x);
end

plot(x,y)
hold on
plot(x,f(x))
plot(ti,fi,'.')
