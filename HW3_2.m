% Fall 2018
% Name: Terry-Ann Sneed
% HMW3 Part2: ONLINE Method

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

% error
error=1; 

% learning rate
rate=1;

% plots
fig1=subplot(2,1,1);
fig2=subplot(2,1,2);

while(error>0.01)
    for z=1:4
        % weight updates
        y(z)=1/(1+exp(-(w_1*x_1(z)+w_2*x_2(z)+w_3)));
        dw1=-2*x_1(z)*y(z)*(1-y(z))*(y(z)-out(z));
        dw2=-2*x_2(z)*y(z)*(1-y(z))*(y(z)-out(z));
        dw3=-2*y(z)*(1-y(z))*(y(z)-out(z));
        
        w_1=w_1+dw1;
        w_2=w_2+dw2;
        w_3=w_3+dw3;
    end
    error=0;
     
    %error calculation
    for z=1:4
        y(z)=1/(1+exp(-(w_1*x_1(z)+w_2*x_2(z)+w_3)));
        error=error+(y(z)-out(z))^2;
    end
   
    clc
    data(rate,1)=rate;
    data(rate,2)=error;
    data(rate,3)=w_1;
    data(rate,4)=w_2;
    data(rate,5)=w_3;
    plot(fig1,data(:,1),data(:,2));
    plot(fig2,data(:,1),data(:,3),data(:,1),data(:,4),'-.b',data(:,1),data(:,5),'-ro');
    legend(fig1,'error','Location','northoutside','Orientation','horizontal')
    legend(fig2,'w1','w2','w3','Location','northoutside','Orientation','horizontal')
    rate=rate+1;
end
