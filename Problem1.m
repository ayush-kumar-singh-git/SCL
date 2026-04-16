% Name : AYUSH KUMAR SINGH
% ID : 2024ADPS0644H

format long;
clc;

% Given Data

t = [0, 0.05, 0.11, 0.18, 0.30, 0.45, 0.60];
n = length(t);
Original_Q= [2, 2.4, 2.9, 3.1, 3.8, 4.2, 4.5];
noise = 0.05*randn(n, 1);
Q = Original_Q + noise;
% Q has error in order of N(0, 0.05^2)
% Task A

fwd = [];
central = [];

for i = 1 : length(t)-1
    fwd(end+1) = (Q(i+1)-Q(i))/(t(i+1)-t(i));
end

for i = 2 : length(t)-1
    central(end+1) = (Q(i+1)-Q(i-1))/(t(i+1)-t(i-1));
end

fwd
central

figure;
plot(t(1:end-1), fwd);
title('dQ/dt using forward difference formulas')
figure;
plot(t(2:end-1), central);
title('dQ/dt using central difference formulas')

% Comment on Sensitivity to noise and non uniform t
% From the plot it is clear that there is a lot of sensitivity to noise and non uniform t
% both formual's results have huge variance

% Task B

q_fit = zeros(n,1);
dq_win = zeros(n,1);

for i = 2:n-1
    
    tw = t(i-1:i+1);
    qw = Q(i-1:i+1); 
    
    X = [tw(1)^2, tw(1), 1;
         tw(2)^2, tw(2), 1;
         tw(3)^2, tw(3), 1];
    
    cfs = X \ qw';
    
    a = cfs(1);
    b = cfs(2);
    c = cfs(3);
    
    dq_win(i) = 2*a*t(i) + b;                  % derivative
    q_fit(i) = a*t(i)^2 + b*t(i) + c;          % fitted value
end

fprintf('Fitted values:\n');
disp(q_fit);

fprintf('Moving Window Derivative:\n');
disp(dq_win);

% Moving window smooths noise but slightly reduces accuracy

% Part C

I = eye(n);              
L = zeros(n-2, n);  

for i = 1:n-2
    L(i,i)   = 1;
    L(i,i+1) = -2;
    L(i,i+2) = 1;
end

lam = 0.5;   

q_smooth = (I'*I + lam*(L'*L)) \ (I'*Q);

dq_reg = zeros(n-1,1);

for i = 1:n-1
    dq_reg(i) = (q_smooth(i+1) - q_smooth(i)) / (t(i+1) - t(i));
end

fprintf('Smoothed signal:\n');
disp(q_smooth);

fprintf('Regularized Derivative :\n');
disp(dq_reg);

% Small lambda → accurate but noisy
% Large lambda → smooth but less accurate

% Task D

q_step = Q;

for i = 4:n
    q_step(i) = q_step(i) + 2; 
end

% Forward difference
dq_fd = zeros(n-1,1);

for i = 1:n-1
    dq_fd(i) = (q_step(i+1) - q_step(i)) / (t(i+1) - t(i));
end

% Regularized smoothing
q_step_sm = (I'*I + lam*(L'*L)) \ (I'*q_step);

dq_reg_step = zeros(n-1,1);

for i = 1:n-1
    dq_reg_step(i) = (q_step_sm(i+1) - q_step_sm(i)) / (t(i+1) - t(i));
end

fprintf('Forward Difference : \n');
disp(dq_fd);

fprintf('Regularized : \n');
disp(dq_reg_step);

% Forward difference captures sudden changes instantly
% Regularization smooths but blurs sharp transitions