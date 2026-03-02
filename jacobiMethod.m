function [x] = jacobiMethod(A, b, maxItr, err)
    n = length(b);
    D = zeros(n,n);
    L = zeros(n,n);
    U = zeros(n,n);
    for i = 1 : n 
        for j = 1 : n
            if i == j
                D(i,j) = A(i,j);
            elseif i>j
                L(i,j) = -1* A(i,j);
            else
                U(i,j) = -1*A(i,j);
            end
        end
    end
    M = D;
    N = L+U;
    invM = inv(M);
    T = invM * N; %% can use M \ N instead
    C = invM * b;
    prev_x = zeros(n,1);
    curr_x = zeros(n,1);
    itr = 0;
    while itr < maxItr
        itr = itr + 1;
        curr_x = T*prev_x + C;
        if norm(curr_x-prev_x, inf) < err
            break;
        end
        prev_x = curr_x;
    end
    x = curr_x;
end
