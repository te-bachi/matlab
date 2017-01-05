
t = 0:0.001:3;

phi1 = pi/3;
phi2 = -pi;

f = 1;

ud1 = 14;
ud2 = 10;

u1 = @(t) ud1*cos(2*pi*f*t+phi1);
u2 = @(t) ud2*cos(2*pi*f*t+phi2);

u1k = ud1*exp(1i*phi1);
u2k = ud2*exp(1i*phi2);

u1a = real(u1k);
u1b = imag(u1k);
u2a = real(u2k);
u2b = imag(u2k);

disp([num2str(round(u1a,4)) '/' num2str(round(u1b,4))]);
disp([num2str(round(u2a,4)) '/' num2str(round(u2b,4))]);

u3k = u1k + u2k;
ud3 = abs(u3k);
phi3 = angle(u3k);
u3 = @(t) ud3*cos(2*pi*f*t+phi3);

figure;
plot(t, u1(t), 'b:');
hold on;
plot(t, u2(t), 'b--');
%plot(t, u1(t) + u2(t), 'g');
plot(t, u3(t), ':r');
xlabel('t [s]');
ylabel('u [V]');
legend('u1','u2', 'u3');
grid on;

figure;
compass(u1k, 'b:');
hold on;
compass(u2k, 'b--');
compass(u3k, 'r:');
legend('u1','u2', 'u3');
%polarplot(u2k, 'b--');


