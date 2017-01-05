
clc;
clear;

F    = @(x) [ (-6*x(1) + 2*x(2)      + cos(x(1)));
              (-8*x(2) + x(1)*x(2)^2 + sin(x(1))) ];
          
x = [ (-10:1:10);
      (-10:1:10); ];

  
for a = 1:21
    for b = 1:21
        y(a,b) = F([a; b]);
    end
end

  
figure;
surf(x(1), x(2), y);


