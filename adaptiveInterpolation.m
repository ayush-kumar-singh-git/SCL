function [p] = adaptiveInterpolation(f, a, b, epsi)
    x = [a, b]
    y = f(x)
    p = polyfit(x,y,2)
    m = (b+a)/2
    if abs(polyval(p,m) - f(m)) < epsi
        return
    
    p = adaptiveInterpolation(f,a,m,epsi)
    p = adaptiveInterpolation(f,m,b,epsi)
end