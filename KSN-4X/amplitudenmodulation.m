% Amplitude Modulation (AM)

fs = 200e3; % sample rate 10 kHz
Ts = 1/fs;  % time step
t = 0:Ts:1-Ts; % time vector start / step / end

% generate waves:
% wave 1 -> carrier / Traeger
fb1 = 30000; % Hz
ub1 = cos(2 * pi * fb1 * t);

% wave 2 -> baseband / Audiosignal
fb2 = 2000; % Hz
m2 = 0.2;
ub2 = m2 * cos(2 * pi * fb2 * t);

% wave 3 -> baseband / Audiosignal
fb3 = 3000; % Hz
m3 = 0.7;
ub3 = m3 * cos(2 * pi * fb3 * t);

% Vektorielle Multiplication ub1 * ub2
m = 0.2; % Modulationsgrad ("modulation index")
ub = ub1 .* (1 + ub2 + ub3); % Mit DC-Anteil: 0 <= (1 + ub2) <= 2 

% Sample File speichern:
save('am_samples_200k', 'ub');

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub, t, ub2), grid on; % ub(t)
axis([0.0 0.005 -2.2 2.2]);
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
