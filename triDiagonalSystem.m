function x = triDiagonalSystem(A,d)

    a = [0; diag(A,-1)];
    b = diag(A);
    c = [diag(A,1); 0];
    n = length(b);

    % Forward elimination
    for i = 2:n
        w = a(i)/b(i-1);
        b(i) = b(i) - w*c(i-1);
        d(i) = d(i) - w*d(i-1);
    end

    % Back substitution
    x = zeros(n,1);
    x(n) = d(n)/b(n);

    for i = n-1:-1:1
        x(i) = (d(i) - c(i)*x(i+1))/b(i);
    end

end
