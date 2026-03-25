function P = recurse(f, a, b, fa, fb, epsi)

    % midpoint
    m = (a + b)/2;
    fm = f(m);

    % linear polynomial coefficients
    p1 = (fb - fa)/(b - a);
    p0 = fa - p1 * a;

    % error at midpoint
    approx = p0 + p1 * m;
    err = abs(fm - approx);

    if err < epsi
        % store: [a, b, p0, p1]
        P = [a, b, p0, p1];
    else
        % split
        P1 = recurse(f, a, m, fa, fm, epsi);
        P2 = recurse(f, m, b, fm, fb, epsi);

        % concatenate rows
        P = [P1; P2];
    end

end