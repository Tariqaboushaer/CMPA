%ELEC 4700
%Tariq Aboushaer
%101064544
%PA 8

set(0, 'DefaultFigureWindowStyle', 'docked')
clc; 
close all; 
clear all;


%%
%Part 1
Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

Voltage = linspace(-1.95,0.7,200);

I1 = Is*(exp((1.2*Voltage)/0.025)-1) + Gp*Voltage - Ib*(exp((-1.2*(Voltage+Vb))/0.025)-1);

variation = linspace(-0.2,0.2,41);

I2 = I1;

for i = 1:length(I2)
    error = variation(randi(length(variation)));
    I2(i) = I2(i)*(1+error);
end

fig1 = figure(1);
plot(Voltage,I1,'b','DisplayName','Calculated Diode Current')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(fig1,'northwest')

fig2 = figure(2);
plot(Voltage,I2,'b','DisplayName','Calculated Diode Current')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(fig2,'northeast')

fig5 = figure(5);
semilogy(Voltage,abs(I1),'b','DisplayName','Calculated Diode Current')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(fig5,'northwest')

fig6 = figure(6);
semilogy(Voltage,abs(I2),'b','DisplayName','Calculated Diode Current')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(fig6,'northeast')

%%
%Part 2
FourthOrder1 = polyfit(Voltage,I1,4);
FourthOrder2 = polyfit(Voltage,I2,4);
EigthOrder1 = polyfit(Voltage,I1,8);
EigthOrder2 = polyfit(Voltage,I2,8);

FourthI1 = polyval(FourthOrder1,Voltage);
FourthI2 = polyval(FourthOrder2,Voltage);
EigthI1 = polyval(EigthOrder1,Voltage);
EigthI2 = polyval(EigthOrder2,Voltage);

figure(1)
hold on
plot(Voltage,FourthI1,'g','DisplayName','Fitted Fourth Order No Variation')
plot(Voltage,EigthI1,'m','DisplayName','Fitted Eigth Order No Variation')
legend('Location','northwest')
movegui(fig1,'northwest')
hold off

figure(2)
hold on
plot(Voltage,FourthI2,'g','DisplayName','Fitted Fourth Order with Variation')
plot(Voltage,EigthI2,'m','DisplayName','Fitted Eigth Order with Variation')
legend('Location','northwest')
movegui(fig2,'northeast')
hold off

figure(5)
hold on
semilogy(Voltage,abs(FourthI1),'g','DisplayName','Fitted Fourth Order No Variation')
semilogy(Voltage,abs(EigthI1),'m','DisplayName','Fitted Eigth Order No Variation')
legend('Location','northwest')
movegui(fig5,'northwest')
hold off

figure(6)
hold on
semilogy(Voltage,abs(FourthI2),'g','DisplayName','Fitted Fourth Order with Variation')
semilogy(Voltage,abs(EigthI2),'m','DisplayName','Fitted Eigth Order with Variation')
legend('Location','northwest')
movegui(fig6,'northeast')
hold off

%%
%Part 3
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');

Voltage = transpose(Voltage);
I1 = transpose(I1);
I2 = transpose(I2);

NLfitI1 = fit(Voltage,I1,fo);
NLfitI2 = fit(Voltage,I2,fo);

NlI1 = NLfitI1(Voltage);
NlI2 = NLfitI2(Voltage);

fa = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
NLfitI1A = fit(Voltage,I1,fa);
NLfitI2A = fit(Voltage,I2,fa);

nlI1A = NLfitI1A(Voltage);
nlI2A = NLfitI2A(Voltage);

f3 = figure(3);
plot(Voltage,I1,'b','DisplayName','Calculated Diode Current')
hold on
plot(Voltage,nlI1A,'m','DisplayName','2-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f3,'southwest')

f4 = figure(4);
plot(Voltage,I2,'b','DisplayName','Calculated Diode Current')
hold on
plot(Voltage,nlI2A,'m','DisplayName','2-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f4,'southeast')

f7 = figure(7);
semilogy(Voltage,abs(I1),'b','DisplayName','Calculated Diode Current')
hold on
semilogy(Voltage,abs(nlI1A),'m','DisplayName','2-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f7,'southwest')

f8 = figure(8);
semilogy(Voltage,abs(I2),'b','DisplayName','Calculated Diode Current')
hold on
semilogy(Voltage,abs(nlI2A),'m','DisplayName','2-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f8,'southeast')

fb = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
NLfitI1B = fit(Voltage,I1,fb);
NLfitI2B = fit(Voltage,I2,fb);

nlI1B = NLfitI1B(Voltage);
nlI2B = NLfitI2B(Voltage);

figure(3)
hold on
plot(Voltage,nlI1B,'c','DisplayName','3-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f3,'southwest')

figure(4)
hold on
plot(Voltage,nlI2B,'c','DisplayName','3-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f4,'southeast')

figure(7)
hold on
semilogy(Voltage,abs(nlI1B),'c','DisplayName','3-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f7,'southwest')

figure(8)
hold on
semilogy(Voltage,abs(nlI2B),'c','DisplayName','3-Parameter Non-Linear Fit')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f8,'southeast')

%%
%Part 4

Net1 = cascadeforwardnet([10,8,6,4,2]);
Net2 = Net1;
inputs = transpose(Voltage);
outputs1 = transpose(I1);
outputs2 = transpose(I2);

Net1 = train(Net1,inputs,outputs1);
Net2 = train(Net2,inputs,outputs2);

NetI1 = Net1(inputs);
NetI2 = Net2(inputs);

figure(3)
hold on
plot(inputs,NetI1,'r','DisplayName','Neural Net Model')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f3,'southwest')

figure(4)
hold on
plot(inputs,NetI2,'r','DisplayName','Neural Net Model')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f4,'southeast')

figure(7)
hold on
semilogy(inputs,abs(NetI1),'r','DisplayName','Neural Net Model')
legend('Location','northwest')
title('Diode Current without Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f7,'southwest')

figure(8)
hold on
semilogy(inputs,abs(NetI2),'r','DisplayName','Neural Net Model')
legend('Location','northwest')
title('Diode Current with Error (TA 101064544)')
xlabel('Voltage (V)')
ylabel('Current (A)')
movegui(f8,'southeast')