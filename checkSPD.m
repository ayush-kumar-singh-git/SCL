function [x] = checkSPD(A)
    x = 1;
    n = size(A);
    dim = n(1);
    if ~isequal(A,A') 
        x = 0;
        return;
    end
    y = eig(A);
    for i = 1 : dim
        if y(i) <= 0
            x = 0;
            break;
        end
    end
end
