clear all

n=1000;
m=eye(n);
b=ones(n,1);
x=(1:n)/n;
for i=(1:n)
    for j=(i:n)
        if(i==j)
            m(i,j) = m(i,j) + 1/n*cos(4*pi*i*j/(n^2))^2;
        else
            m(i,j) = 1/n*cos(4*pi*i*j/(n^2))^2;
            m(j,i) = m(i,j);
        end
    end
end

% tic
% [L,D] = mychol(m);
% 
% y = forwardscript(L,b);
% u = backwardscript(L',D'.^(-1).*y);
% toc

fprintf('\nCholesky-Zerlegung for/backward Fortran Matrix Memorylayout\n')
tic
L = chol(m); %,'lower');
y = forwardT(L,b);
u1 = backwardT(L',y);
toc

fprintf('\nCholesky-Zerlegung for/backward C Matrix Memorylayout\n')
tic
L = chol(m,'lower');
y = forward(L,b);
u1 = backward(L',y);
toc

fprintf('\nCholesky-Zerlegung for/backward matlab solver\n')
tic
L = chol(m,'lower');
y = L\b;
u2 = L'\y;
toc

fprintf('\nmatlab solver\n')
tic
u3 = m\b;
toc

%plot(x,u)
hold on
plot(x,u1)
plot(x,u2)
