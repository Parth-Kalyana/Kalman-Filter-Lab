clc;
clear;
close all;
%True value
true_value = 10;

% Number of measurements
N = 100;


% Generate noisy sensor data

rng(1);                
noise = randn(1, N);
sensor = true_value + noise;


%Different alpha values
alpha_values = [0.1 0.2 0.5 0.8];

%Create figure
figure;

for i = 1:length(alpha_values)

    alpha = alpha_values(i);

    filtered = zeros(1, N);

    filtered(1) = sensor(1);

    % Recursive filter
    for k = 2:N
        filtered(k) = (1-alpha)*filtered(k-1) ...
                      + alpha*sensor(k);
    end

    
    % Plot
    subplot(2,2,i);

    plot(sensor, 'LineWidth', 1);
    hold on;

    plot(filtered, 'LineWidth', 2);

    yline(true_value, '--');

    grid on;

    xlabel('Measurement number');
    ylabel('Value');

    title(['\alpha = ', num2str(alpha)]);

    legend('Sensor', 'Filtered estimate', 'True value');
end

sgtitle('Effect of Alpha on Recursive Filter');