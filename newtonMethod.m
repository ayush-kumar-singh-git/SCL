function [p, itr] = newtonMethod(f, df, a, b, maxItr, err)
    [prev, itr] = bisectionMethod(f,a,b,5,1e-3);
    curr = prev;
    while itr < maxItr
        itr = itr + 1;
        curr = prev - (f(prev)/df(prev));
        if abs(curr - prev) < err
            break
        end
        prev = curr;
    end
    p = curr;
end
