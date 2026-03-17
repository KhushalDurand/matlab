 clc;
 clear;
t= linspace(0,50,1000);
c= 50*(1-exp(-0.05.*t))+10*exp(-0.05.*t);

f = @(T,C) 0.05*(50-C);
[T,C] = ode113(f,[0 50],10);

figure
hold on
grid on
title("concentration");
plot(t,c,'-r',"DisplayName",'Analytical',LineWidth=2);
plot(T,C,'*-g',"DisplayName",'ode45',LineWidth=0.5);
legend;



------------------------------
% system of ODEs

function dcdt = funct(t,c)
  dc1dt = -0.12*c(1)+0.02*c(3)+1;
  dc2dt = 0.15*c(1)-0.15*c(2);
  dc3dt=0.025*c(2)-0.255*c(3)+4;
  dc4dt=0.1*c(3)-0.1375*c(4)+0.025*c(5);
  dc5dt = 0.03*c(1)+0.01*c(2)-0.04*c(5);

 dcdt=[dc1dt; dc2dt; dc3dt ;dc4dt ;dc5dt];

end

clc;
clear;

c0 = [0;0;0;0;0];

[t,c] = ode45(@funct,[0 50],c0);

figure
hold on
grid on
title("c V/S t")
plot(t,c(:,1),'-r',DisplayName='C1');
plot(t,c(:,2),'-g',DisplayName='C2');
plot(t,c(:,3),'-b',DisplayName='C3');
plot(t,c(:,4),'-w',DisplayName='C4');
plot(t,c(:,5),'-m',DisplayName='C5');
legend;

