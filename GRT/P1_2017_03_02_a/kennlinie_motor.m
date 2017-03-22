
%%
load('data_2v.mat');
load('data_4v.mat');
load('data_6v.mat');
load('data_8v.mat');
load('data_10v.mat');

%%
plot(data_2v.time(:), data_2v.signals.values(:,2))
plot(data_2v.time(:), data_2v.signals.values(:,2))
plot(data_4v.time(:), data_4v.signals.values(:,2))
plot(data_6v.time(:), data_6v.signals.values(:,2))
plot(data_8v.time(:), data_8v.signals.values(:,2))
plot(data_10v.time(:), data_10v.signals.values(:,2))