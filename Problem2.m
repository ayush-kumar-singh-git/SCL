% Name : AYUSH KUMAR SINGH
% ID : 2024ADPS0644H

format long;
clc;

% Given Data
time = [0, 0.04, 0.09, 0.15, 0.22, 0.35, 0.50, 0.65];
funVal = [1.2, 1.5, 1.7, 5.5, 1.8,2.0, 2.1,2.2];


% Original data plot
figure;
plot(time, funVal);
title('Original Data');

Integral_Trapezoidal = 0;

% Trapezoidal Rule
for i = 2 : length(time)
    Integral_Trapezoidal =  Integral_Trapezoidal + (((time(i) - time(i-1))/2)*(funVal(i)+funVal(i-1)));
end

Integral_Trapezoidal;

Integral_Simpsons = 0;
% For simpsons rule we also need mid points, we may assume linear interpolation for it
for i = 2 : length(time) 
    h = (time(i) - time(i-1));
    fa = funVal(i-1);
    fb = funVal(i);
    fm = (funVal(i)+funVal(i-1))/2;
    Integral_Simpsons = Integral_Simpsons + (h*(fa+(4*fm)+fb))/3;
end

Integral_Simpsons

% Limitations of Simpsons :
% We have to rely on Interpolation to get mid point approximation
% Due to spikes the integral value might be too deviated 


% The spike at 5.5 Clearly affects the integral value by a large amount. It increase the area under the curve significantly


% zscore 
Z = zscore(funVal);
spike = max(Z);
spike_idx = find(Z == spike);
spike_idx % gives the index of spike
spike_val = funVal(spike_idx) % give the value of spike

% Now since we have spike idx we can replace its corresponding linear interpolation
nF = funVal;
nt = time;
nF(spike_idx) = (nF(spike_idx-1) + nF(spike_idx+1))/2;

% disp(nF)
% disp(nt)

% Filtered data plot
figure;
plot(nt, nF);
title('Filtered Data');


% Recomputing both the integrals

Integral_Trapezoidal2 = 0;

% Trapezoidal Rule
for i = 2 : length(time)
    Integral_Trapezoidal2 =  Integral_Trapezoidal2 + (((nt(i) - nt(i-1))/2)*(nF(i)+nF(i-1)));
end

Integral_Trapezoidal2

Integral_Simpsons2 = 0;
% For simpsons rule we also need mid points, we may assume linear interpolation for it
for i = 2 : length(nt) 
    h = (nt(i) - nt(i-1));
    fa = nF(i-1);
    fb = nF(i);
    fm = (nF(i)+nF(i-1))/2;
    Integral_Simpsons2 = Integral_Simpsons2 + (h*(fa+(4*fm)+fb))/3;
end

Integral_Simpsons2

% Refining the data based on slopes

rt = [];
rF = [];

limit = 0; % we can set any value but here I use median of slopes as threshold 
slopes = zeros(1, length(nt)-1);

for i = 2:length(nt)
    h = nt(i) - nt(i-1);
    slopes(i-1) = abs((nF(i) - nF(i-1)) / h);
end

limit = median(slopes);

for i = 2:length(nt)

    h = nt(i) - nt(i-1);
    slope = abs((nF(i) - nF(i-1)) / h);

    % always include the left point of interval
    if i == 2
        rt = [rt, nt(i-1)];
        rF = [rF, nF(i-1)];
    end

    if slope > limit
        % refine interval by adding midpoint
        mid_t = (nt(i) + nt(i-1)) / 2;
        mid_f = (nF(i) + nF(i-1)) / 2;

        rt = [rt, mid_t, nt(i)];
        rF = [rF, mid_f, nF(i)];

    else
        % coarse
        rt = [rt, nt(i)];
        rF = [rF, nF(i)];
    end
end

% disp(rt);
% disp(rF);

% Adpative data plot
figure;
plot(rt, rF);
title('Adpative Data');


% Recomputing integrals for adaptive

Integral_Trapezoidal3 = 0;

for i = 2 : length(rt)
    Integral_Trapezoidal3 = Integral_Trapezoidal3 + (((rt(i) - rt(i-1))/2)*(rF(i)+rF(i-1)));
end

Integral_Trapezoidal3;

Integral_Simpsons3 = 0;

for i = 2 : length(rt)
    h = (rt(i) - rt(i-1));
    fa = rF(i-1);
    fb = rF(i);
    fm = (rF(i)+rF(i-1))/2;
    Integral_Simpsons3 = Integral_Simpsons3 + (h*(fa+(4*fm)+fb))/3;
end

Integral_Simpsons3;

% Energy Computations

% since CV is a constant the previous integrals directly provide the value for energy 
CV = 44 * 1e6;
Energy_raw_trapezoid = CV * Integral_Trapezoidal;
Energy_raw_simpsons = CV * Integral_Simpsons;
Energy_filtered_trapezoidal = CV * Integral_Trapezoidal2;
Energy_filtered_simpsons = CV * Integral_Simpsons2;
Energy_adaptive_trapezoidal = CV * Integral_Trapezoidal3;
Energy_adaptive_simpsons = CV * Integral_Simpsons3;


Energy_raw_trapezoid
Energy_raw_simpsons
Energy_filtered_trapezoidal
Energy_filtered_simpsons
Energy_adaptive_trapezoidal


% Impact of Numerical Error:
% Numerical integration is highly sensitive to outliers and abrupt spikes.
% The spike at funVal = 5.5 introduces a large artificial increase in area,
% leading to overestimation of the integral in both methods.
% Simpson's rule assumes smooth curvature and hence performs poorly
% when such discontinuities exist.
% After filtering the spike, the integral values become more stable and
% representative of the true trend.
% Adaptive Quadrature provides more stable results