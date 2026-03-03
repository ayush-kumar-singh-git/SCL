format long;

maxItr = 100;
err = 1e-16;

%% function, gradient and hessian
%% function in this script is 5x^2 + 2y^2 + 2xy - 6x - 4y
%% Correct minima is (0.5, 0.75)
f = @(x) (5*x(1)^2 + 2*x(2)^2 + 2*x(1)*x(2) - 6*x(1) - 4*x(2));
gradf = @(x) [10*x(1)+2*x(2)-6; 4*x(2)+2*x(1)-4];
hessf = [10 2; 2 4];

itr = 0;

x = [0;0];
curr_grad = gradf(x);

while itr < maxItr
    itr = itr + 1;
    alpha = (curr_grad'*curr_grad)/(curr_grad'*hessf*curr_grad);
    x = x - alpha*curr_grad;
    curr_grad = gradf(x);
    if norm(curr_grad, 2) < err
        break;
    end
end

fprintf('Number of iterations = %d\n', itr);
fprintf('Final solution:\n');
disp(x);
