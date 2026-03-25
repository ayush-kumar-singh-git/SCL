function [x] = DFP(g, H, x, err)
    [n, m] = size(H);
    B = eye(n);
    % for i = 1 : n
    %     for j = 1 : n
    %         B(i,j) = i+j;
    %     end
    % end
    while true 
        curr_grad = g(x);
        if norm(curr_grad, 2) < err
            break
        end

        d = -1 * (B * curr_grad);
        a = els(curr_grad, H, d);
        new_x = x + (a*d);
        s = new_x - x;
        y = g(new_x) - curr_grad;
        B = B + ((s*s')/(s'*y)) - (((B*y)*(B*y)')/(y'*B*y))
        x = new_x;
    end
end