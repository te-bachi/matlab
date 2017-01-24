% reellwerte Funktion zweidimensional
f = @(x,y) [-1 + x^3 - 3*x*y^2; 3*x^2*y - y^3];
df = @(x,y) [3*x^2 - 3*y^2, - 6*x*y; 6*x*y, 3*x^2 - 3*y^2];

n=500; % Anzahl Punkte pro Achse
x0=linspace(-1,1,n);
y0=linspace(-1,1,n);
[x0,y0] = meshgrid(x0,y0);

% Matrix fuer das Resultat
g = zeros(n,n,3);

% exakte Nullstellen des komplexwertigen Polynoms
z0=[1;0];
z1=[-1/2;sqrt(3)/2];
z2=[-1/2;-sqrt(3)/2];

maxIter=20; % maximale Newton-Schritte
tol=1e-4;   % Toleranz fuer Newton-Verfahren
for k=(1:n)
    for l=(1:n)
        % Startwert fuer Newton-Verfahren
        xn=x0(k,l);
        yn=y0(k,l);
        
        % Newton Verfahren
        iter=0;
        while(iter < maxIter && norm([xn;yn]-z0) > tol && norm([xn;yn]-z1) > tol && norm([xn;yn]-z2) > tol)
            A=df(xn,yn);
            [L,R,P] = lu(A);
            z=forward(L,P*f(xn,yn));
            s=backward(R,z);
            x = [xn;yn]-s;
            xn=x(1);
            yn=x(2);
            iter = iter + 1;
        end
        
        % Farben speichern proportional zur Anzahl Iterationen
        % falls keine Konvergenz innerhalb von maxIter 
        % => Pixel bleibt schwarz
        if(norm([xn;yn]-z0)<tol)
            g(k,l,1)=iter;                  % Rot fuer z0
        elseif(norm([xn;yn]-z1)<tol)
            g(k,l,2)=iter;                  % Gruen fuer z1
        elseif(norm([xn;yn]-z2)<tol)
            g(k,l,3)=iter;                  % Blau fuer z2
        end
    end
end

% Bild darstellen pro Pixel ein RGB Wert (0-1)
imshow(g/maxIter*1.5)
