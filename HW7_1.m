% Fall 2018
% Name: Terry-Ann Sneed
% HMW #7 Part I

% Kohonen Network PART I (1-D)
% WARNING!!!!! I was not able to fit the data points in a doughnut shape,
% but only in a square.

clc
clear all
close all

% neightborhood size
NS=3; 
% time
T=1000; 
t=1; 
% inputs
P=1000;
% weights
M=100; 
% learning rate
LR=0.1; 

% random weights 0.2 - 0.3
w_1=0.2+(0.3-0.2)*rand(M,1);
w_2=0.2+(0.3-0.2)*rand(M,1);

% random vectors 
V_1=rand(3000,1);
V_2=rand(3000,1);

% input random vectors
x_1=[];
x_2=[];

r = 5;
i=1;

% generate vectors
while length(x_1)<P
    if V_1(i) + V_2(i) - r <= 0
        x_1=[x_1, V_1(i)];
        x_2=[x_2, V_2(i)];
    end
    i=i+1;
end

figure
plot(x_1,x_2,'.b', w_1,w_2,'or', w_1,w_2,'k','linewidth',2)
legend('Input vectors','Weights','Connections','Location','northeast');
title('Initial Input vectors and Weights');
xlabel('x1');
ylabel('x2');


while (t<T)
    
    % learning rate change
    NUM=LR*(1-t/T);
    % size of neighborhood change
    size=round(NS*(1-t/T)); 
    
    % loop to find winning neuron and update weights
    for i=1:length(x_1)
        
        BEST=sqrt((x_1(i)-w_1).^2+(x_2(i)-w_2).^2);
        BEST_POS=1;
        min=BEST(BEST_POS);
        for j=1:M
            if BEST(j)<min
                min=BEST(j);
                BEST_POS=j;
            end
        end
        
        % update winning neuron
        w_1(BEST_POS)=w_1(BEST_POS)+NUM*(x_1(i)- w_1(BEST_POS));
        w_2(BEST_POS)=w_2(BEST_POS)+NUM*(x_2(i)- w_2(BEST_POS));
        
        %update neighbour neurons
        for DISTANCE=1:size
            BOUNDARY=BEST_POS-DISTANCE;
            if (BOUNDARY>=1)
                w_1(BOUNDARY)=w_1(BOUNDARY)+NUM*(x_1(i)-w_1(BOUNDARY));
                w_2(BOUNDARY)=w_2(BOUNDARY)+NUM*(x_2(i)-w_2(BOUNDARY));
            end
            BOUNDARY=BEST_POS+DISTANCE;
            if (BOUNDARY<=M)
                w_1(BOUNDARY)=w_1(BOUNDARY)+NUM*(x_1(i)-w_1(BOUNDARY));
                w_2(BOUNDARY)=w_2(BOUNDARY)+NUM*(x_2(i)-w_2(BOUNDARY));
            end
        end
    end
    t=t+1;
    
    figure(2)
    plot(x_1,x_2,'.b', w_1,w_2,'xr', w_1,w_2,'k','linewidth',2)
    title(['Input vectors and Weights - time=' num2str(t)]);
    xlabel('x1');
    ylabel('x2');
    drawnow
end

        
