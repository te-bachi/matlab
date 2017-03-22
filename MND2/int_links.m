
function I = int_links(f, a, b, h)
    n  = (b - a) / h;
    t  = linspace(a, b, n);
    Ik = zeros(1, length(t));
    for j = 1:length(t)
        Ik(j) = f(t(j));
    end
    I = sum(Ik) * h;
end
