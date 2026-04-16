function intervals = subdivide(f, a, b, tol, intervals)
    fa = f(a);
    fb = f(b);
    
    % Linear interpolation coefficients
    l = (fb - fa) / (b - a);
    m = fa - l * a;
    
    % Midpoint check
    mid = (a + b) / 2;
    fmid = f(mid);
    pmid = l * mid + m;
    
    err = abs(fmid - pmid);
    
    if err < tol
        % Accept interval
        intervals = [intervals; a, b, l, m];
    else
        % Split interval
        intervals = subdivide(f, a, mid, tol, intervals);
        intervals = subdivide(f, mid, b, tol, intervals);
    end
end