%%
% Piezobalken, 08.03.2017
% Autoren: Giaele Quadri, Nicolas Borla, Andreas Bachmann


% max(simout.signals.values(:,2));
% min(simout.signals.values(:,2);
% (max(simout.signals.values(:,2)) - min(simout.signals.values(:,2))) / 2

% Tabelle
% Frequenz
f  = [      1,     10,      20,     40,     50,     60,    100,    200,    300,    400,    500,    600 ];
% Eingangssignal
e  = [      4,      4,       4,      4,      4,      4,      4,      4,      4,      4,      4,      4 ];
% Ausgangssignal
a  = [ 0.2910, 0.3052,  0.3422, 0.5601, 0.8509, 1.8533, 0.4685, 0.1074, 0.0727, 0.5000, 0.0513, 0.0354 ];

% Auswertung
figure(2)
semilogx(f,db(a./e));

open('piezobalken_figure1.fig');
%open('piezobalken_figure2.fig');

open('piezobalken.slx');

