function [a] = els(g, H, d)
    x = -1 * (d' * g);
    y = d' * H * d;
    a = x/y; 
end