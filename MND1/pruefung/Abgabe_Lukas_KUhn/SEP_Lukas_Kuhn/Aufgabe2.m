%banachscher_Fixpunktsatz
%für lineare und nicht lineare Systeme
clc,clear all, close all

%Funktion
%Überprüfe ob es die Vorschriften einhält!!!
%Die Gleichung muss immer auf x1=.... und x2=.... umgeformt werden
%Die Gleichung x1 muss zuoberst sein und x2-Gleichung zu unterst.
f=@(x1,x2,x3) [1/8*exp(-x1^2-x2^2-x3^2);1/3*sin(x1)*cos(x2);1/(2*(x3+1))];

%Parameter
iter=0;
maxIter=5;
x0=[0.5;0.5;0.5]
%Auf Dezimalstellen genau...viel grössere tol nehmen
tol=1e-12;
error=1;
xalt=x0;

while (error > tol) && (iter < maxIter)
    % Fixpunkt-Iteration
    xneu = f(xalt(1),xalt(2),xalt(3));
    
    % Norm der Differenz
    error=norm(xalt-xneu,'inf');
    
    % speichern der Loesung
    xalt = xneu;
    iter = iter+1;
end
format long
error
xneu
iter
format short
