function [y] = A(x)
    %{
    % Noob Way
    y = zeros(size(x));
    for i = 1 : length(x)
        if x(i) > 0
            y(i) = 2*x(i);
        else 
            y(i) = abs(x(i));
        end
    end
    %}
    % Pro Way
    x(x>0) = 2 * x(x>0);
    x(x<0) = abs(x(x<0));
    y = x;
end
