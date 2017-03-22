
%% Aufgabe 1.1
% Andreas Bachmann
% 12.03.2017

syms x;

f = sin(x)^2;
I = int(f, 0, 2*pi);
%fplot(x, f, [0 2*pi]);


a = 0;
b = 2*pi;
h = [      ...
    10e-1, ...
    10e-2, ...
    10e-4, ...
    10e-8  ...
];

if ((b - a) < h)
    error(['h must be lower than (b - a)!']);
end

for i = 1:length(h)
    I_num = 0;
    n     = (1 / h(i)) + 1;
    t     = linspace(a, b, n);
    fprintf('h = %6.8f\n', h(i));
    fprintf('  size(t)= %d\n', length(t));
    for k = 2:length(t)
        
    end
end