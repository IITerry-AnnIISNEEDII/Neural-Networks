% Fall 2018
% Name: Terry-Ann Sneed
% HMW #7 Part II

% Kohonen Network PART II (2-D)
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
M=10; 
% learning rate
LR=0.1; 

% random weight vectors between 0.2 - 0.3
for i=1:M
    for j=1:M
        w_1(i,j)=0.2+(0.3-0.2)*rand;
        w_2(i,j)=0.2+(0.3-0.2)*rand;
    end
end

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
plot(x_1,x_2,'.b', w_1,w_2,'xr', w_1,w_2,'k', w_1',w_2','k','linewidth',2)
legend('Input vectors','Weights','Location','northeast');
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
        X_VALUE=1;
        Y_VALUE=1;
        min=BEST(X_VALUE,Y_VALUE);
        for ii=1:M
            for jj=1:M
                if BEST(ii,jj)<min
                    min=BEST(ii,jj);
                    X_VALUE=ii; Y_VALUE=jj;
                end
            end
        end
        
        %update winning neuron
        w_1(X_VALUE,Y_VALUE)=w_1(X_VALUE,Y_VALUE)+NUM*(x_1(i)-w_1(X_VALUE,Y_VALUE));
        w_2(X_VALUE,Y_VALUE)=w_2(X_VALUE,Y_VALUE)+NUM*(x_2(i)-w_2(X_VALUE,Y_VALUE));
        
        % update neighbour neurons
        for DISTANCE=1:size
            BOUNDARY_X=X_VALUE-DISTANCE; 
            if (BOUNDARY_X>=1)
                w_1(BOUNDARY_X,Y_VALUE)=w_1(BOUNDARY_X,Y_VALUE)+NUM*(x_1(i)-w_1(BOUNDARY_X,Y_VALUE));
                w_2(BOUNDARY_X,Y_VALUE)=w_2(BOUNDARY_X,Y_VALUE)+NUM*(x_2(i)-w_2(BOUNDARY_X,Y_VALUE));
            end
            BOUNDARY_X=X_VALUE+DISTANCE;
            if (BOUNDARY_X<=M)
                w_1(BOUNDARY_X,Y_VALUE)=w_1(BOUNDARY_X,Y_VALUE)+NUM*(x_1(i)-w_1(BOUNDARY_X,Y_VALUE));
                w_2(BOUNDARY_X,Y_VALUE)=w_2(BOUNDARY_X,Y_VALUE)+NUM*(x_2(i)-w_2(BOUNDARY_X,Y_VALUE));
            end
            BOUNDARY_Y=Y_VALUE-DISTANCE;
            if (BOUNDARY_Y>=1)
                w_1(X_VALUE,BOUNDARY_Y)=w_1(X_VALUE,BOUNDARY_Y)+NUM*(x_1(i)-w_1(X_VALUE,BOUNDARY_Y));
                w_2(X_VALUE,BOUNDARY_Y)=w_2(X_VALUE,BOUNDARY_Y)+NUM*(x_2(i)-w_2(X_VALUE,BOUNDARY_Y));
            end
            BOUNDARY_Y=Y_VALUE+DISTANCE;
            if (BOUNDARY_Y<=M)
                w_1(X_VALUE,BOUNDARY_Y)=w_1(X_VALUE,BOUNDARY_Y)+NUM*(x_1(i)-w_1(X_VALUE,BOUNDARY_Y));
                w_2(X_VALUE,BOUNDARY_Y)=w_2(X_VALUE,BOUNDARY_Y)+NUM*(x_2(i)-w_2(X_VALUE,BOUNDARY_Y));
            end
        end
    end
    t=t+1;
    
    figure(2)
    plot(x_1,x_2,'.b', w_1,w_2,'xr', w_1,w_2,'k', w_1',w_2','k','linewidth',2)
    title(['Input vectors and Weights - time=' num2str(t)]);
    xlabel('x1');
    ylabel('x2');
    drawnow
end

        
