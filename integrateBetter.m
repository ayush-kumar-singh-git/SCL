function [Integral] = integrate(f, a, b)
    N = [];
    A = [];
    for n = 2 : 100
        x = linspace(a, b, 2*n+1);
        y = f(x);
        h = (b-a)/(2*n);
        odd_sum  = sum(y(2:2:end-1));   
        even_sum = sum(y(3:2:end-2));
        I = h/3 * (y(1) + y(end) + 4*odd_sum + 2*even_sum);
        N(end + 1) = 2*n+1;
        A(end + 1) = I;
    end
    plot(N, A)
    Integral = A(end);
end