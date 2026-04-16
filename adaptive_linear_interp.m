function intervals = adaptive_linear_interp(f, a, b, tol)
    % Each row: [a, b, l, m]
    intervals = [];
    
    % Start recursion
    intervals = subdivide(f, a, b, tol, intervals);
end