%% Input is Augmented Matrix
function [x] = gaussianEliminationWithoutPivoting(A)
    [n, m] = size(A) % n = # equations, m = n+1

     % Forward Elimination
    for k = 1:n-1
        for i = k+1:n
            factor = A(i,k) / A(k,k);
            A(i, k:m) = A(i, k:m) - factor * A(k, k:m);
        end
    end

    % Back Substitution
    x = zeros(n,1);

    for i = n:-1:1
        sumVal = A(i,i+1:n) * x(i+1:n);
        x(i) = (A(i,m) - sumVal) / A(i,i);
    end
end
