% Phase Shift Keying

fs = 1000e3; % sample rate 1000 kHz
Ts = 1/fs;  % time step
t = 0:Ts:1-Ts; % time vector start / step / end

% generate waves:
% wave 1 -> carrier / Traeger
fb1 = 20000; % Hz
ub1 = cos(2 * pi * fb1 * t);

% Baseband 1010101
fb2 = 1000; % 2000 Bits/s
ub2 = square(2 * pi * fb2 * t);


% Vektorielle Multiplication ub1 * ub2

ub = ub1 .* ub2; % Mit DC-Anteil: 0 <= (1 + ub2) <= 2 

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub, t, ub2), grid on; % ub(t)
axis([0.0 0.002 -2.2 2.2]);
title('time domain');
xlabel('time');
ylabel('voltage');
legend('AM signal', 'baseband');

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
