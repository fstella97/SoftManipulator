clear all 
close all 
clc 

set(0,'defaulttextInterpreter','latex') 

global rr thr
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
    

%% Parameters for the mean
M=90; %number of samples over which the mean is done
thr=45; %thresold
%%
    s1 = serialport("COM2",9600); %Arduino MEGA (put only Pressure Sensors)
    pause(0.5)
    s1.flush();
    global g r 
   %%
     figure(1)
     hold on 
     figure('units','normalized','outerposition',[0 0 1 1])
%     red(1)
%     red(2)
%     red(3)
    i=1;
    
    
%     while (1)
%          mbar=str2num(readline(s1))*1000;
%         rr=[rr;mbar];
%         if length(rr(:,1))>M+4
%             check(1)=mbar(1)-rr(length(rr(:,1))-20,1);
%             check(2)=mbar(2)-rr(length(rr(:,1))-20,2);
%             check(3)=mbar(3)-rr(length(rr(:,1))-20,3);
%             check
%             if mbar(1)-rr(length(rr(:,1))-20,1)>thr
%                 green(1)
%             else
%                 red(1)
%             end
%             
%             if mbar(2)-rr(length(rr(:,1))-20,2)>thr
%                 green(2)
%             else
%                 red(2)
%             end
%             
%             if mbar(3)-rr(length(rr(:,1))-20,3)>thr
%                 green(3)
%             else
%                 red(3)
%             end
%         end  
%     i=i+1;
%     end
red(1)
red(2)
red(3)

r = rateControl(80);
while(1)
    reset(r)
    s1.flush();
    str2num(readline(s1));
    mbar=str2num(readline(s1))*1000
        rr=[rr;mbar];
        if length(rr(:,1))>100
            plot_bar
            if and(mbar(1)>thr,g(1)==0)
                green(1)
            else 
                if and(g(1)==1,mbar(1)<thr)
                    red(1)
                end
            end
            
            if and(mbar(2)>thr,g(2)==0)
                green(2)
                 else 
                if and(g(2)==1,mbar(2)<thr)
                    red(2)
                end
            
            end
            
            if and(mbar(3)>thr,g(3)==0)
                green(3)
                
            else
                if  and(g(3)==1,mbar(3)<thr)
                    red(3)
                end
            
            end
            
        end
        waitfor(r);
end
        
        
    while(1)
        
        mbar=str2num(readline(s1))*1000;
        rr=[rr;mbar];
        if length(rr(:,1))>100
            mean_bar(1)=sum(rr(length(rr(:,1))-M-1:length(rr(:,1)),1))/M;
            mean_bar(2)=sum(rr(length(rr(:,2))-M-1:length(rr(:,2)),2))/M;
            mean_bar(3)=sum(rr(length(rr(:,3))-M-1:length(rr(:,3)),3))/M;
            mean_bar
            check(1)=mbar(1)-mean_bar(1);
            check(2)=mbar(2)-mean_bar(2);
            check(3)=mbar(3)-mean_bar(3);
            
            check
            if mbar(1)-mean_bar(1)>thr
                green(1)
            
            end
            
            if mbar(2)-mean_bar(2)>thr
                green(2)
            
            end
            
            if mbar(3)-mean_bar(3)>thr
                green(3)
            
            end
        end  
    i=i+1;
        
        end
    
        function green(i)
        global g
        figure(1)
        subplot(3,3,i)
        patch([0,1,1,0],[0,0,1,1],'g')
        set(gca,'XTick',[],'YTick',[])
        if i==1
        title('First segment')
        end
        if i==2
            title('Second segment')
        end
        if i==3
            title('Third segment')
        end
        drawnow
        
        g(i)=1;
  
        end
        
         function red(i)
         global g r 
         figure(1)
        subplot(3,3,i)
        patch([0,1,1,0],[0,0,1,1],'r')
        set(gca,'XTick',[],'YTick',[])
        if i==1
        title('First segment')
        end
        if i==2
            title('Second segment')
        end
        if i==3
            title('Third segment')
        end
        drawnow
        g(i)=0;
         end
        
         function plot_bar
         global rr thr
         M=90;
    
         figure(1)
         cla(subplot(3,3,[4,5,6,7,8,9]))
         subplot(3,3,[4,5,6,7,8,9])
        
         hold on
         grid on 
         box on 
         x=linspace(0,92,92);
         plot(x,rr(length(rr(:,3))-M-1:length(rr(:,3)),1),'linewidth',2);
         plot(x,rr(length(rr(:,3))-M-1:length(rr(:,3)),2),'linewidth',2);
         plot(x,rr(length(rr(:,3))-M-1:length(rr(:,3)),3),'linewidth',2);
         ylim([-20,200]);
         yline(thr,'--r');
         set(gca,'xtick',[])
         ylabel('mBar')
         xlabel('Time')
         legend('Chamber 1','Chamber 2','Chamber 3');
         
         end
         
        
