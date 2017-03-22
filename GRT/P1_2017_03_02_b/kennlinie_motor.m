
%%
load('data_2v.mat');
load('data_4v.mat');
load('data_6v.mat');
load('data_8v.mat');
load('data_10v.mat');

%%
plot(data_2v.time(:), data_2v.signals.values(:,2))

%%
hold on
t = 7150;
% plot(data_2v.time(1:t), data_2v.signals.values(1:t,2))
% plot(data_4v.time(1:t), data_4v.signals.values(1:t,2))
% plot(data_6v.time(1:t), data_6v.signals.values(1:t,2))
% plot(data_8v.time(1:t), data_8v.signals.values(1:t,2))
% plot(data_10v.time(1:t), data_10v.signals.values(1:t,2))



%plot(data_2v.time(:), data_2v.signals.values(:,2))
%pp2v = polyfit(data_2v.time(:), data_2v.signals.values(:,2), 1)
plot(data_4v.time(:), data_4v.signals.values(:,2))
pp4v = polyfit(data_4v.time(:), data_4v.signals.values(:,2), 1)
m4v = pp4v(1)
plot(data_6v.time(:), data_6v.signals.values(:,2))
pp6v = polyfit(data_6v.time(:), data_6v.signals.values(:,2), 1)
m6v = pp6v(1)
plot(data_8v.time(:), data_8v.signals.values(:,2))
pp8v = polyfit(data_8v.time(:), data_8v.signals.values(:,2), 1)
m8v = pp8v(1)
plot(data_10v.time(:), data_10v.signals.values(:,2))
pp10v = polyfit(data_10v.time(:), data_10v.signals.values(:,2), 1)
m10v = pp10v(1)
legend('data_2v','data_4v','data_6v','data_8v','data_10v');
xlabel('zeit [sec]');
ylabel('Ausgangsspannung des Drucksensors [V]');
