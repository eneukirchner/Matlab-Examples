% Frequency Modulation (AM)

fs = 500e3; % sample rate 500 kHz
Ts = 1/fs;  % time step
t = 0:Ts:1-Ts; % time vector start / step / end

% generate waves:
% wave 1 -> carrier / Traeger
fc = 20000; % Hz
uc = cos(2 * pi * fc * t);

% wave 2 -> baseband / Audiosignal
fb = 2000; % Hz
ub = cos(2 * pi * fb * t);

%%%%%%% Modulation 
% delta_f = 4800; % Frequenzhub
eta = 3; % Modulationsindex: eta < 1 -> Schmalband-FM (NBFM)
delta_f = eta * fb;
int_ub = 1/fs * cumsum(ub);
ufm = cos(2 * pi * fc * t + 2 * pi * delta_f * int_ub);


%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub, t, ufm), grid on; % ub(t)
axis([0.0 0.001 -2.2 2.2]);
title('time domain');
xlabel('time');
ylabel('voltage');
legend('FM signal', 'baseband');

% Calculate Frequency Spectrum 
% with Fast Fourier Transformation (FFT)
F = fft(ufm); % fourier coefficient (= amplitude) at each frequency 
n = length(ufm); % number of samples
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
