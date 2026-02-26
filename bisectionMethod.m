function [p, itr] = bisectionMethod(f, a, b, maxItr, err)
    itr = 0;
    p = 0;
    while itr < maxItr && (b-a)/2 > err 
        itr = itr+1;
        p = (b+a)/2;
        if f(p) == 0
            break
        else if f(p) < 0
            a = p;
        else 
            b = p;
        end
    end
end
