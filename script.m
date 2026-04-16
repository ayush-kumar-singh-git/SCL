clc; clear;

f = @(x) x.^(1/2);   % Example function
a = 0;
b = 2;
tol = 1e-3;

intervals = adaptive_linear_interp(f, a, b, tol);

% Display intervals
disp('Intervals [a b l m]:');
disp(intervals);

% Plot
x = linspace(a, b, 1000);
y_true = f(x);
y_interp = eval_piecewise(intervals, x);

figure;
plot(x, y_true, 'b', 'LineWidth', 2); hold on;
plot(x, y_interp, 'r--', 'LineWidth', 2);
legend('True Function', 'Adaptive Linear Interpolation');
title('Adaptive Piecewise Linear Interpolation');

% Mark breakpoints
for i = 1:size(intervals,1)
    plot([intervals(i,1) intervals(i,2)], ...
         [f(intervals(i,1)) f(intervals(i,2))], 'ko');
end

grid on;

% Error plot
figure;
plot(x, abs(y_true - y_interp), 'k', 'LineWidth', 1.5);
title('Error Plot');
xlabel('x');
ylabel('Absolute Error');
grid on;