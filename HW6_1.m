% Fall 2018
% Name: Terry-Ann Sneed
% HWM #6 Part I

% Asynchronous

clc
clear all
close all

% all 3 vector initialization
v_1=[1;-1;-1;1; 
     1;-1;-1;1; 
     1;-1;-1;1; 
     1;1;1;1]; 
     
v_2=[1;-1;-1;-1; 
     1;-1;-1;-1; 
     1;-1;-1;-1; 
     1;1;1;1];
     
v_3=[-1;1;1;-1; 
     -1;1;1;-1; 
     -1;1;1;-1; 
     -1;1;1;-1;]; 

% weight matrix initialization
w=v_1*v_1'+v_2*v_2'+v_3*v_3';    

index_1=1;
index_2=1;

% set diagonal of weight matrix to 0         
for x=1:16
    w(x,x)=0;                  
end

for x=1:10000
  
    in_value=de2bi(x,16,'left-msb');
    
    in_value(in_value==0)=-1;
    
    match_value=0;
    
    vop2(1:16,1)=in_value';
    
    iteration=0;
    
    unstable_state=0;
    
    while (~match_value)
      
        iteration=iteration+1;
        
        vop3=vop2;
        
        for j=1:16
          
            vop1(j,1)=w(j,:)*vop3;
            
            if vop1(j,1)>0
              
                vop1(j,1)=1;
                
            end
            
            if vop1(j,1)<0
              
                vop1(j,1)=-1;
                
            end
            
            if vop1(j,1)==0
              
                vop1(j,1)=vop3(j,1);
                
            end
            
            vop3(j,1)=vop1(j,1);
            
        end
        
        match_value=1;
        
        for j=1:16
          
            if vop1(j,1)~=vop2(j,1)
              
                match_value=0;
                
            end
        end
        
        zz(1:16,iteration)=vop1;
        
        m=0;
        
        for u=1:1:iteration-2
          
            m=1;
            
            for j=1:16
              
                if vop1(j,1)~=zz(j,u)
                  
                    m=0;
                    
                end
            end
            
            if m==1
              
                break;
            end
        end
        
        if m==1
          
            unstable_state=1;
            
            match_value=1;
            
        end
        
        vop2=vop1;
        
    end
    
    if ~unstable_state
      
        v_in(index_1)=x;
        
        vop2(vop2==-1)=0;
        
        v_op(index_1)=bi2de(vop2','left-msb');
        
        index_1=index_1+1;
        
    else
        v_in_un(index_2)=x;
        
        n_it(index_2)=iteration;
        
        index_2=index_2+1;
    end
end

plot(v_in,v_op,'.k')
axis([0 65536 0 65536])
grid
title('Stable states')
xlabel('Initial state')
ylabel('Final state')

if index_2>1
  figure
  plot(v_in_un,n_it,'.k')
  grid
  title('Unstable states')
  xlabel('Initial state')
  ylabel('Steps Number')

else
    disp('There is no unstable state');
end
