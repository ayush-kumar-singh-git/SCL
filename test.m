format long;

f = @(x) x.^2+1;

X = linspace(-1,1,1000);
Y = f(X);

plot(X,Y);
