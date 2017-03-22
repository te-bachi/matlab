clc, clear all, clf;
%% Modell   aus einer Aufgabenstelleung
f = @(x)[((x(1)-1)^2)+8*((x(2)-(1/2))^2)-3;
         ((x(1)-(1/2))^4)+((x(2)-(1/2))^4)-1];
     
df = @(x)[2*x(1),16*x(2)-8;
          x(1)^3/4,4*x(2)^3-6*x(2)^2+3*x(2)-0.5 ];
          
%% Solver
x = Newton_Iteration_Solver(f, df, 100, 1e-5,[1 1]', 1)