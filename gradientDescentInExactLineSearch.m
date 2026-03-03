format long;

maxItr = 100;
err = 1e-16;

% Function and gradient
f = @(x) (5*x(1)^2 + 2*x(2)^2 + 2*x(1)*x(2) - 6*x(1) - 4*x(2));
gradf = @(x) [10*x(1)+2*x(2)-6; 4*x(2)+2*x(1)-4];

% Armijo parameters
c = 1e-4;      % sufficient decrease constant
tau = 0.5;     % backtracking shrink factor

itr = 0;
x = [0;0];

while itr < maxItr
    
    itr = itr + 1;
    
    g = gradf(x);
    
    if norm(g,2) < err
        break;
    end
    
    p = -g;        % descent direction
    alpha = 1;     % initial step size
    
    % ---- Armijo Backtracking ----
    while f(x + alpha*p) > f(x) + c*alpha*(g'*p)
        alpha = tau * alpha;
    end
    
    x = x + alpha*p;
    
end

fprintf('Number of iterations = %d\n', itr);
fprintf('Final solution:\n');
disp(x);
