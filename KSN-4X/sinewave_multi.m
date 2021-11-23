% Multiplication of two sine waves ("Mischer / Mixer")

fs = 10e3; % sample rate 10 kHz
Ts = 1/fs;  % time step
t = 0:Ts:1-Ts; % time vector start / step / end

% generate waves:
% wave 1
fb1 = 1000; % Hz
ub1 = cos(2 * pi * fb1 * t);

% wave 2
fb2 = 50; % Hz
ub2 = cos(2 * pi * fb2 * t);

% Vektorielle Multiplication ub1 * ub2
ub = ub1 .* ub2; 

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub, t, ub2), grid on; % ub(t)
axis([0.0 0.1 -2.2 2.2]);
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
axis([0 10e3 0 1.2])
xlabel('frequency');
ylabel('voltage');
