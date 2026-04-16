format long;
h = 1e-5;

f = @(x) atan(x);
df = @(x) (f(x+h) - f(x-h))./(2*h);

x = linspace(-10,10,10000);
y = f(x);
dy = df(x);
g = @(x) 1./(1+x.^2);
actual = g(x);
plot(x, dy, 'r', x, actual, 'b--', 'LineWidth', 1.5);
legend('Numerical', 'Exact');
grid on;