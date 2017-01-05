
%f = [ 1000 0 ];
%f = linspace(1000, 10000, 10);

%disp(num2str(f));

f      = [ 1000   2000   3000   4000   5000   6000   7000   8000   9000  10000 ];
uc     = [ 8      5.6    4.2    3.4    2.8    2.4    2.0    1.8    1.6   1.4   ];
ic     = [ 0.136  0.192  0.216  0.224  0.224  0.232  0.232  0.232  0.232 0.232 ];
uc_eff = [ 5.59   3.95   2.97   2.37   1.97   1.68   1.45   1.29   1.15  1.04  ];
ic_eff = [ 0.097  0.134  0.148  0.154  0.158  0.160  0.161  0.162  0.163 0.163 ];


%plot(f, uc_eff);

subplot(2,2,1)
plot(f,uc_eff,'*-r')
xlabel('Freguenz f in Hz');
ylabel('Spannung Ueff [V]');
axis([0 10000 0 6]);
grid on
hold on

subplot(2,2,2)
plot(f,ic_eff,'*-g')
xlabel('Freguenz f in Hz');
ylabel('Strom Ieff [A]');
axis([0 10000 0 0.2]);
grid on

subplot(2,2,3)
plot(2*pi*f,uc_eff./ic_eff,'*-b')
xlabel('Kreisfrequenz ohmega in Hz');
ylabel('Scheinwiderstand Z');
grid on

subplot(2,2,4)
plot(2*pi*f,ic_eff./uc_eff,'*-y')
xlabel('Kreisfrequenz ohmega in Hz');
ylabel('Scheinleitwert Y');
grid on

%disp([num2str(round(uc_eff,4)) '/' num2str(round(ic_eff,4))]);

