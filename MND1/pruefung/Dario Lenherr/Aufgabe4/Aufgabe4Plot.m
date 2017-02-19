clc,clear all,clf;
%Die Funktion muss =0 gesetzt werden
f1=@(x,y) ((x-1)^2)+8*((y-(1/2))^2)-3;
f2=@(x,y) ((x-(1/2))^4)+((y-(1/2))^4)-1;

x=linspace(-1,3,100);
y=linspace(-1,2,100);

[x,y] = meshgrid(x,y);
f1=f1(x,y);
f2=f2(x,y);

contour(x,y,f1,[0 0],'b');
hold on
contour(x,y,f2,[0 0],'r');