function y = eval_piecewise(intervals, x)
    y = zeros(size(x));
    
    for i = 1:length(x)
        xi = x(i);
        
        for j = 1:size(intervals,1)
            a = intervals(j,1);
            b = intervals(j,2);
            l = intervals(j,3);
            m = intervals(j,4);
            
            if xi >= a && xi <= b
                y(i) = l * xi + m;
                break;
            end
        end
    end
end