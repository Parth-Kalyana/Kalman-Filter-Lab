clc;
clear;
close all;

true_value = 10;
% No. of measurements
N = 100;

%generating Noise value
noise = randn(1, N);
sensor = true_value + noise;

%Recursive filter
alpha = 0.8;
filtered = zeros(1, N);

%first measurement
filtered(1) = sensor(1);

for k = 2:N
    filtered(k) = (1-alpha)*filtered(k-1) + alpha*sensor(k);
end

%Plot
plot(sensor, 'LineWidth', 1);
hold on;

plot(filtered, 'LineWidth', 2);

yline(true_value, '--');

grid on;

xlabel('Measurement number');
ylabel('Value');

legend('Sensor measurement', ...
       'Filtered estimate', ...
       'True value');

title('Recursive Filter');