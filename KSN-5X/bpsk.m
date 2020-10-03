% BPSK Simulation
clear all;
close all;
clc;

N = 16;
data = round(rand(1,N)); % 16 Random bits
data = 2*data - 1; % NRZ signal

fs = 1000;
T = 1/fs;

tt = T/99:T/99:T % Vector of time steps

baseband = [];
baseband_all = [];
bpsksig = [];
bpsksig_all =[];
for(i=1:length(data)) % for each bit
    baseband = repmat(data(i), 1, length(tt));
    baseband_all = [baseband_all baseband];
    bpsksig=data(i)*cos(2*pi*fs*tt); 
    bpsksig_all=[bpsksig_all bpsksig]; %append vector  
end

tt = T/99:T/99:T*length(data);
figure(1);
subplot(2,1,1);
plot(tt, baseband_all, 'linewidth', 3);
grid on;
title('baseband signal');
xlabel('t');
ylabel('u(t))');

subplot(2,1,2);
plot(tt, bpsksig_all, 'linewidth', 3);
grid on;
title('BPSK signal');
xlabel('t');
ylabel('u(t))');

figure(2);
plot(real(data),imag(data),'x','MarkerSize',8,'LineWidth',2);
axis([-1.5 1.5 -1.5 1.5]);
grid on;
title('Constellation');
xlabel('Re');
ylabel('Im');







