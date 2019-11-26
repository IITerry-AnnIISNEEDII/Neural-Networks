% Fall 2018
% Name: Terry-Ann Sneed
% HMW #4: XOR GATE 

% ONLINE

clc
clear all
close all

% input values
x_1=[0.1 0.1 0.9 0.9]; 
x_2=[0.1 0.9 0.1 0.9]; 

% desired output
out=[0.1 0.9 0.9 0.9];

% initial random weight values
w_1=rand;
w_2=rand;
w_3=rand; 
w_4=rand;
w_5=rand;
w_6=rand; 
w_7=rand;
w_8=rand;
w_9=rand; 

% error
error=1; 

% learning rate
rate=1;

while(error>0.01)
    for z=1:4
        
        % weight updates
        new_alpha1=w_1*x_1(z)+w_3*x_2(z)+w_5;
        new_alpha2=w_2*x_1(z)+w_4*x_2(z)+w_6;
        
        z1(z)=1/(1+exp(-new_alpha1));
        z2(z)=1/(1+exp(-new_alpha2));
        
        alpha=w_8*z1(z)+w_9*z2(z)+w_7;
        
        y(z)=1/(1+exp(-alpha));
        
        dw_1=x_1(z)*z1(z)*(1-z1(z))*w_8*y(z)*(1-y(z))*(y(z)-out(z));
        dw_2=x_1(z)*z2(z)*(1-z2(z))*w_9*y(z)*(1-y(z))*(y(z)-out(z));
        dw_3=x_2(z)*z1(z)*(1-z1(z))*w_8*y(z)*(1-y(z))*(y(z)-out(z));
        dw_4=x_2(z)*z2(z)*(1-z2(z))*w_9*y(z)*(1-y(z))*(y(z)-out(z));
        dw_5=z1(z)*(1-z1(z))*w_8*y(z)*(1-y(z))*(y(z)-out(z));
        dw_6=z2(z)*(1-z2(z))*w_9*y(z)*(1-y(z))*(y(z)-out(z));
        dw_8=z1(z)*y(z)*(1-y(z))*(y(z)-out(z));
        dw_9=z2(z)*y(z)*(1-y(z))*(y(z)-out(z));
        dw_7=y(z)*(1-y(z))*(y(z)-out(z));
        
        w_1=w_1-2*dw_1;
        w_2=w_2-2*dw_2;
        w_3=w_3-2*dw_3;
        w_4=w_4-2*dw_4;
        w_5=w_5-2*dw_5;
        w_6=w_6-2*dw_6;
        w_7=w_7-2*dw_7;
        w_8=w_8-2*dw_8;
        w_9=w_9-2*dw_9;
    end
    
    error=0;
    
    for z=1:4
        
        %error calculation
        new_alpha1=w_1*x_1(z)+w_3*x_2(z)+w_5;
        new_alpha2=w_2*x_1(z)+w_4*x_2(z)+w_6;
        
        z1(z)=1/(1+exp(-new_alpha1));
        z2(z)=1/(1+exp(-new_alpha2));
        
        alpha=w_8*z1(z)+w_9*z2(z)+w_7;
        
        y(z)=1/(1+exp(-alpha));
        
        error=error+(y(z)-out(z))^2;
    end
    data(rate,1)=rate;
    data(rate,2)=error;
    data(rate,3)=w_1;
    data(rate,4)=w_2;
    data(rate,5)=w_3;
    data(rate,6)=w_4;
    data(rate,7)=w_5;
    data(rate,8)=w_6;
    data(rate,9)=w_7;
    data(rate,10)=w_8;
    data(rate,11)=w_9;
    rate=rate+1;
end
figure(1);
plot(data(:,1),data(:,2));
legend('Error','Location','northoutside','Orientation','horizontal');
figure(2);
plot(data(:,1),data(:,3), ...
    data(:,1),data(:,4), ...
    data(:,1),data(:,5), ...
    data(:,1),data(:,6), ...
    data(:,1),data(:,7), ...
    data(:,1),data(:,8), ...
    data(:,1),data(:,9), ...
    data(:,1),data(:,10), ...
    data(:,1),data(:,11));
legend('w_1','W2','W3','W4','W5','W6','W7','W8','W9','Location','northoutside','Orientation','horizontal');

