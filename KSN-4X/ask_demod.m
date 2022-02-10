% Amplitude Shift Keying

fs = 1000e3; % sample rate 1000 kHz

% generate waves:
% wave 1 -> carrier / Traeger
fc = 20000; % Hz

t = 0:1/fs:1/fb-1/fs;


text = 'hallo liebe leute tralala jajaja';
data = dec2bin(text) == 1;

tt = 0:1/fs:length(data)/fb -1/fs;

asksig = [];
asksig_all =[];
uc = [];
uc_all = [];

for i=1:length(data) % for each bit
    asksig=data(i)*cos(2*pi*fc*t); 
    asksig_all=[asksig_all asksig]; %append vector 
    uc_p = cos(2 * pi * fc * t);
    uc = [uc uc_p];
end

umod = asksig_all;

umodi = real(hilbert(umod));
umodq = imag(hilbert(umod));
uci = real(hilbert(uc));
ucq = imag(hilbert(uc));

udemod = umodi .* uci + umodq .* ucq;
ubits = udemod(fs/fb/4: fs/fb/2 : end) > 0.5;

%  Plot Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(tt, umod, tt, udemod), grid on; % ub(t)
axis([0.0 0.01 -2.2 2.2]);
title('time domain');
xlabel('time');
ylabel('voltage');
legend('AM signal', 'baseband');

% Calculate Frequency Spectrum 
% with Fast Fourier Transformation (FFT)
F = fft(udemod); % fourier coefficient (= amplitude) at each frequency 
n = length(udemod); % number of samples
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


