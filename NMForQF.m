function [curr] = NMForQF(g, Q, x, err) 
    prev = x;
    while true 
        curr_grad = g(prev);
        dir = -1* Q\curr_grad;
        if norm(curr_grad, 2) < err
            break
        end
        a = els(curr_grad, Q, dir);
        curr = prev + (a.*dir);
        if norm(curr - prev, 2) < err
            break
        end
        prev = curr;
    end
end