function [L, U] = croutsLUDecomposition(A)
    [n,m] = size(A);

    L = zeros(n);
    U = eye(n);   % diagonal of U is 1

    for j = 1:n
        
        % Compute L(i,j)
        for i = j:n
            s = 0;
            for k = 1:j-1
                s = s + L(i,k)*U(k,j);
            end
            L(i,j) = A(i,j) - s;
        end
        
        % Compute U(j,i)
        for i = j+1:n
            s = 0;
            for k = 1:j-1
                s = s + L(j,k)*U(k,i);
            end
            U(j,i) = (A(j,i) - s)/L(j,j);
        end
    end
end
