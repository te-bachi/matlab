
while error > tol && iter <= iterMax
    A               = dF(x(:, iter));
    b               = F(x(:, iter));
    [Q,R]           = qr(A);
    s               = chol_backward(R, Q'*b);
    x(:, iter + 1)  = x(:, iter) - s;
    error           = norm(F(x(:, iter)));
    
    % y = x
    %fprintf('(x%d/y%d) = %6.3f/%6.3f\n', iter, iter, x(1, iter), x(2, iter));
    iter            = iter + 1;
end

fprintf('(x%d/y%d) = %6.3f/%6.3f\n', iter, iter, x(1, iter), x(2, iter));
% Prüfen
fprintf('f1 = %8.4f\n', f1(x(1,iter), x(2,iter)));
fprintf('f1 = %8.4f\n', f2(x(1,iter), x(2,iter)));
