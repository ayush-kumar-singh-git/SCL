function [p, itr] = secantMethod(f, a, b, maxItr, err)
    itr = 0;
    p = 0;
    g = @(x,y) f(x) * ((x-y)/(f(x)-f(y)));
    while itr < maxItr
        itr = itr + 1;
        p = b - g(b,a);
        if abs(p-b) < err
            break
        end
        a = b;
        b = p;
    end
end
