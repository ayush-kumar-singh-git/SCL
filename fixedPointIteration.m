function [p, itr] = fixedPointIteration(f, initGuess, maxItr, err)
    prev = initGuess;
    itr = 0;
    curr = prev;
    while itr < maxItr
        itr = itr + 1;
        curr = f(prev);
        if abs(curr - prev) < err
            break
        end
        prev = curr;
    end 
    p = curr;
end
