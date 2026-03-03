function [x] = checkSDD(A)
    [n, m] = size(A);
    x = 1;
    for i = 1 : n
        currSum = 0;
        for j = 1 : n
            if i ~= j
                currSum = currSum + abs(A(i,j));
            end
        end
        if abs(A(i,i))<= currSum
            x = 0;
            return;
        end
    end
end
