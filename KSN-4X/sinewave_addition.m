% Generate and plot sine wave

fs = 22100; % sample rate
Ts = 1/fs;  % time step
t = 0:Ts:10-Ts; % time vector start / step / end

% generate waves:
% wave 1
fb1 = 1000; % Hz
A1 = 0.5; % Amplitude in V
ub1 = A1 * cos(2 * pi * fb1 * t);

% wave 2
fb2 = 1100; % Hz
A2 = 0.5; % Amplitude in V
ub2 = A2 * cos(2 * pi * fb2 * t);

% Add: ub1 + ub2
A = 2; % amplification
ub = A * (ub1 + ub2);

% Write wav - File
% fname = 'add.wav';
% audiowrite(fname, ub, fs);

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub, t, ub2), grid on; % ub(t)
axis([0.01 0.05 -2.2 2.2]);
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
axis([0 22100 0 1.2])
xlabel('frequency');
ylabel('voltage');
