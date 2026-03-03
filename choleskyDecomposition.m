function [L] = choleskyDecomposition(A)
    [m, n] = size(A);
    L = zeros(m,n);
    if ~checkSPD(A)
        return;
    end
    for i = 1:n
        for j = 1:i
            s = 0;
            for k = 1:j-1
                s = s + L(i,k)*L(j,k);
            end
            
            if i == j
                L(i,j) = sqrt(A(i,i) - s);
            else
                L(i,j) = (A(i,j) - s) / L(j,j);
            end
        end
    end

end
