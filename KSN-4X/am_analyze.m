% Amplitude Modulation (AM)

fs = 200e3; % sample rate 10 kHz
Ts = 1/fs;  % time step
t = 0:Ts:1-Ts; % time vector start / step / end

% Sample File laden:
load('am_samples_200k', 'ub');

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub), grid on; % ub(t)
axis([0.0 0.003 -2.2 2.2]);
title('time domain');
xlabel('time');
ylabel('voltage');
legend('AM signal');

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
axis([0 100e3 0 1.2]);
title('frequency domain');
xlabel('frequency');
ylabel('voltage');
