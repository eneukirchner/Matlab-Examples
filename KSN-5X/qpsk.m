% QPSK Simulation
clear all;
close all;
clc;

N = 16;
data = round(rand(1,N)); % 16 Random bits
data = 2*data - 1; % NRZ signal
data_iq = reshape(data, 2, length(data)/2); % 2 * N/2 - sized Matrix

fs = 1000;
T = 1/fs;

tt = T/99:T/99:T % Vector of time steps

baseband = [];
baseband_all = [];
baseband_iq = [];
baseband_iq_all = [];
qpsksig = [];
qpsksig_all =[];

for(i=1:length(data))
    baseband = repmat(data(i), 1, length(tt)); % repeat value for bit length
    baseband_all = [baseband_all baseband];
end

tt = T/99:T/99:T*length(data);

figure(1);
subplot(4,1,1);
plot(tt, baseband_all, 'linewidth', 3);
grid on;
title('baseband signal');
xlabel('t');
ylabel('u(t))');

tt = T/99:T/99:2*T;

for(i=1:length(data_iq)) % for each bit
    baseband_iq = repmat(data_iq(:,i), 1, length(tt)); % repeat columnwise
    baseband_iq_all = [baseband_iq_all baseband_iq];    
end

for(i=1:length(data_iq)) % for each bit
    qpsksig=data_iq(1,i)*cos(2*pi*fs*tt) + data_iq(2,i)*sin(2*pi*fs*tt); 
    qpsksig_all=[qpsksig_all qpsksig]; %append vector  
end

tt = T/99:T/99:T * 2 * length(data_iq);
subplot(4,1,2);
plot(tt, baseband_iq_all(1,:), 'linewidth', 3);
grid on;
title('baseband signal I component');
xlabel('t');
ylabel('u(t))');

subplot(4,1,3);
plot(tt, baseband_iq_all(2,:), 'linewidth', 3);
grid on;
title('baseband signal Q component');
xlabel('t');
ylabel('u(t))');

subplot(4,1,4);
plot(tt, qpsksig_all, 'linewidth', 3);
grid on;
title('QPSK signal');
xlabel('t');
ylabel('u(t))');

figure(2);
plot(data_iq(1,:), data_iq(2,:),'x','MarkerSize',8,'LineWidth',2);
axis([-1.5 1.5 -1.5 1.5]);
grid on;
title('Constellation');
xlabel('Re');
ylabel('Im');







