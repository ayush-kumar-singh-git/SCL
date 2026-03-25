% brute force algorithm
function [val] = lagrangeInterpolation(x,f,a)
    [m,n] = size(x);
    l = zeros(n,1);
    for i = 1 : n
        p = 1;
        q = 1;
        for j = 1 : n
            if i == j
                continue
            end
            p = (p*(a - x(j)));
            q = (q*(x(i) - x(j)));
        end
        l(i) = (p/q);
    end

    val = 0;
    for i = 1 : n
        val = (val + (l(i)*f(i)));
    end
end