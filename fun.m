function [B, C] = fun(A)
    [m, n] = size(A);
    B = A*A;
    %% C = A.^2;
    C = zeros(m,n);
    for i = 1 : m
        for j = 1:n
            C(i,j) = A(i,j)^2;
        end
    end
end
