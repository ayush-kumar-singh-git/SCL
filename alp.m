function [p] = alp(f, a, b, epsi)
    x = [a, b]
    y = f(x)
    p = polyfit(x,y,1)
    m = (b+a)/2
    if abs(polyval(p,m) - f(m)) < epsi
        return
    
    p = alp(f,a,m,epsi)
    p = alp(f,m,b,epsi)
end