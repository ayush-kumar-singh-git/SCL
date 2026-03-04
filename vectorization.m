%{
% Task A
x = [-3 2 -1 4 0];
n = length(x);
y = zeros(1,n);
for i = 1 : n
    if x(i) >= 0
        y(i) = x(i)^2;
    else
        y(i) = abs(x(i));
    end
end
y

y = x;
y(y>0) = y(y>0).^2;
y(y<0) = abs(y(y<0));
y

% Task B
A = [1 6 3; 8 2 5; 7 4 9];

B = A;
[m, n] = size(A);
for i = 1 : m
    for j = 1 : n
        if A(i,j) > 5
            B(i, j) = 2*B(i, j);
        else
            B(i, j) = B(i, j)+1;
        end
    end
end
B

B = A;
B(B>5) = B(B>5)*2;
B(B<=5) = B(B<=5)+1;
B


% Tack C
n = length(x);
A = zeros(n,n);
for i = 1 : n
    for j = 1 : n
        A(i, j) = x(i) - x(j);
    end
end
A

x = [1, 3, 5];
A = x' - x;
A

% Task D
x = [1, 3, 5];
A = x' - x;
A = A.^2;
A

% Task E
A = [1 2 3; 4 5 6; 7 8 9];
[m, n] = size(A);
x = zeros(1,m);
x = sum(A.^2, 2);
x


% Task F
x = [1 4 6];
A = abs(x'-x);
A

% Task G

x = [1 2 3];
y = [2 5 8];
answer = sum(x.*y);
disp(answer)

% Task H

x = [1 2 3 4];
n = length(x);
xbar = sum(x)/n;
var = sum((x-xbar).^2)/n;
disp(var)

A = [1 2 3; 4 5 6; 7 8 9];

[L, U] = lu(A);
% R = chol(A);
[Q, R] = qr(A);
disp(L)
disp(U)
disp(L*U)
disp(Q)
disp(R)
disp(Q*R)

%}
[x,y] = meshgrid(-2:0.1:2 , -2:0.1:2);

z = x.^2 + y.^2;

surf(x,y,z)
hold on;
contour(x,y,z)
