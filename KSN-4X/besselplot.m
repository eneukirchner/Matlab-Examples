%% Plot Bessel Functions of First Kind
% Define the domain.

eta = 0:0.1:20;
%% 
% Calculate the first five Bessel functions of the first kind.

J = zeros(5,201);
for i = 0:4
    J(i+1, : ) = besselj(i,eta);
end
%% 
% Plot the results.

plot(eta,J,'LineWidth',1.5)
axis([0 20 -.5 1])
grid on
legend('J_0','J_1','J_2','J_3','J_4','Location','Best')
title('Bessel Functions of the First Kind for v = 0,1,2,3,4')
xlabel('eta')
ylabel('Amplitude')

