function [Integral] = integrate(f, a, b)
    N = [];
    A = [];
    for n = 2 : 100
        x = linspace(a, b, n+1);
        y = f(x);
        h = (b-a)/n;
        I = h/2 * (y(1) + 2* sum(y(2:n)) + y(n+1));
        N(end + 1) = n;
        A(end + 1) = I;
    end
    plot(N, A)
    Integral = A(end);
end