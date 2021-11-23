% Generate and plot sine wave

fs = 10000; % sample rate
Ts = 1/fs;  % time step
t = 0:Ts:1-Ts; % time vector start / step / end

% generate wave
fb = 500; % Hz
A = 1; % Amplitude in V
ub = A * cos(2 * pi * fb * t);

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub), grid on; % ub(t)
axis([0.01 0.05 -1.2 1.2]);
xlabel('time');
ylabel('voltage');

% Calculate Frequency Spectrum 
% with Fast Fourier Transformation (FFT)
F = fft(ub); % fourier coefficient (= amplitude) at each frequency 
n = length(ub); % number of samples
f = (0 : n-1)*(fs/n); % vector of frequencies
volt = 2/n * abs(F); % absolute value of amplitude

% Plot Frequency Domain (Frequenzbereichsdarstellung)
subplot(2, 1, 2); % 2nd row
plot(f, volt); % volt(f)
grid on;
axis([0 10000 0 1.2])
xlabel('frequency');
ylabel('voltage');
