%% Aufgabe 2
% Simon Stingelin

%% Einlesen der Messdaten
% Import
data = importdata('induced_voltage.txt','\t');

data=data.data;
v = data(:,1);
ui = data(:,4);
n=length(v);

A = [v];
c = A'*ui/(A'*A)

A1 = [ones(n,1),v];
c1 = (A1'*A1)\(A1'*ui)

semilogx(v, (ui./(c*v)-1)*100)
hold on
semilogx(v, ((ui./v)/(ui(20)/v(20))-1)*100)
semilogx(v, (ui./(c1(1)+c1(2)*v)-1)*100)
