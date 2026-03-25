function [x] = conjGrad(g, H, x, err)
    curr_grad = g(x);
    d = -curr_grad;
    b = 0;
    while true 
        if norm(curr_grad, 2) < err
            break
        end
        a = (-d'*curr_grad)/(d'*H*d);
        x = x + a*d;
        new_grad = g(x);
        b = (new_grad' * H * d)/(curr_grad' * H * d);
        d = -new_grad + b*d;
        curr_grad = new_grad;
    end
end