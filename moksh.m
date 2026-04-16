t = [0, 0.05, 0.11, 0.18, 0.30, 0.45, 0.60]';
Q_org = [2.0, 2.4, 2.9, 3.1, 3.8, 4.2, 4.5]';
n = length(t);

eps = 0.05*randn(n, 1);
Q = Q_org + eps;

%PART A: FINITE DIFFERENCE INSTABILITY

%FORWARD DIFFERENCE%
dq_forward = zeros(n-1, 1);
for i = 1: n-1
    dt = t(i + 1) - t(i);
    dq_forward(i) = (Q(i + 1) - Q(i))/dt;
end

%CENTRAL DIFFERENCE%
dq_central = zeros(n - 2, 1);
for i = 2: n-1
    dt_total = t(i + 1) - t(i - 1);
    dq_central(i - 1) = (Q(i + 1) - Q(i - 1))/dt_total;
end

fprintf('Forward Difference\n');
disp(dq_forward);
fprintf("Central Difference\n");
disp(dq_central);

%High sensitivity to noise because small dt in the denominator amplifies the random noise in Q
%Non uniform dt causes inconsistent sensitivity to noise across the signal.

%PART B: FILTERING

q_fitted = zeros(n, 1);
dq_filtered = zeros(n, 1);

for i = 2: n-1
    t_window = t(i-1: i+1);
    q_window = Q(i-1: i+1);

    X = [t_window(1)^2, t_window(1), 1;
        t_window(2)^2, t_window(2), 1;
        t_window(3)^2, t_window(3), 1];

    coeff = X \ q_window;

    a = coeff(1);
    b = coeff(2);

    dq_filtered(i) = 2*a*t(i) + b;
    q_fitted(i) = coeff(1)*t(i)^2 + coeff(2)*t(i) + coeff(3);
end

fprintf('Fitted polynomial values\n');
disp(q_fitted);
fprintf('Derivatives using moveing window\n');
disp(dq_filtered);

%THE MOVING WINDOW POLYNOMIAL FIT INCREASES SMOOTHENESS BY AVERAGING OUT
%RANDOM NOISE ACROSS MULTIPLE POINTS, CREATING A MORE STABLE DERIVATIVE.
%BUT THE ACCURACY DECREAES%

%PART C: REGULARIZED DIFFERENTIATION

A = eye(n);

L = zeros(n-2, n);
for i = 1: n-2
    L(i, i) = 1;
    L(i, i+1) = -2;
    L(i, i+2) = 1;
end

lambda = 0.5;

D_smooth = (A'*A + lambda*(L'*L)) \ (A'*Q);

dq_reg = zeros(n - 1, 1);

for i = 1:n-1
    dq_reg(i) = (D_smooth(i+1) - D_smooth(i)) / (t(i + 1) - t(i));
end

fprintf('Smooth Signal\n');
disp(D_smooth);
fprintf('dQ/dt\n');
disp(dq_reg);

%The parameter lambda balances noise against smoothness. A small lambda is
%highly accurate but rough, whereas high lambda means smooth but low
%accuradcy

%TASK D: TRANSIENT RESPONSE
Q_step = Q;
for i = 4:n
    Q_step(i) = Q_step(i) + 2;
end

dq_step_fd = zeros(n - 1, 1);
for i = 1: n-1
    dq_step_fd(i) = (Q_step(i + 1) - Q_step(i))/ (t(i + 1) - t(i));
end

d_step_smooth = (A'*A + lambda*(L'*L)) \ (A' * Q_step);

dq_step_reg = zeros(n-1,1);
for i = 1:n-1
    dq_step_reg(i) = (d_step_smooth(i+1) - d_step_smooth(i))/ (t(i+1) - t(i));
end

fprintf("Finite Difference Step Response\n");
disp(dq_step_fd);
fprintf("Regularised Step Response\n");
disp(dq_step_reg);

%Forward difference captures transient behaviour best becasue it responds
%instantly to sudden changes without blurring the timing. It is more
%sensitive but preserves the function more accurately. 