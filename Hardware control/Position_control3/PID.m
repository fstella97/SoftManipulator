
function PID(goal_enc)
%%
%1Enc=0.001 mm

%% Control scheme %%

DlgH = figure;
H = uicontrol('Style', 'PushButton', ...
              'String', 'Break', ...
              'Callback', 'delete(gcbf)');

%% From Josie  - Matlab Arduino serial connection setup
%%% SETUP Connections to Arduinos %%%
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
    % COM7 top left,COM3,COM5,COM9
    a = arduino('COM7','Uno','Libraries','Adafruit\MotorShieldV2')
    s = serialport("COM8",115200) % speed of transmission 9600 : too high missing data: put it the same of the arduino 
  
     shield1 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x61') %bottom shield
     shield2 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x60') %middle shield
     shield3 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x62') %top shield
     
     m1 = dcmotor(shield1,1);
     m2 = dcmotor(shield1,2);
     m3 = dcmotor(shield1,3);
     
     m4 = dcmotor(shield2,1);
     m5 = dcmotor(shield2,2);
     m6 = dcmotor(shield2,3);
     
     m7 = dcmotor(shield3,1);
     m8 = dcmotor(shield3,2);
     m9 = dcmotor(shield3,3);


pause(1);
   start(m1);
   start(m2);
   start(m3);
   start(m4);
   start(m5);
   start(m6);
   start(m7);
   start(m8);
   start(m9);
   
    
%% From Francesco - Open loop control to a desired position.
    
%4) From the segments length, find the corresponding Encoder readings.

%goal_enc=[0,-8000,0,0,0,0,0,0,0];

%% Mix Francesco Josie scripts - Closed loop control 
pause(2);
    m1.Speed = 0;
    m2.Speed = 0;
    m3.Speed = 0;
    m4.Speed = 0;
    m5.Speed = 0;
    m6.Speed = 0;
    m7.Speed = 0;
    m8.Speed = 0;
    m9.Speed = 0;
    
    r=[];
    
    global rr
    rr=[];
    
    % Setup/flus Serial for reading IMU/Encoder values
    disp('Flushing Encoders')
    s.flush();
    for i=1:25%250
        tests = readline(s);
    end
    disp('Finish Flush Encoders')
    disp('3...')
    pause(1)
    disp('2...')
    pause(1)
    disp('1...')
    pause(1)
    disp('GO!')
    

%%       
    % Loop to go to each position defined by the rows in d
    i=1;

f1=0;f2=0;f3=0;f4=0;f5=0;f6=0;f7=0;f8=0;f9=0;
tic
u=1;
error=null(26,1)
r = rateControl(300);

thr=70;
            Gp=1/70;%2000
            Gi=0%1/30000;
reset(r)
        while (ishandle(H))
            reset(r)

	time = r.TotalElapsedTime;


            
            enc = getS(s);
            %r=[r;enc];
            if ( f1 ==1 && f2==1 && f3==1 && f4==1 && f5==1 && f6==1 && f7==1 && f8==1 && f9==1)
                break
                f1=0;f2=0;f3=0;f4=0;f5=0;f6=0;f7=0;f8=0;f9=0;
                goal_enc= input('Position achieved, \nProvide another position as a 9x1 array \n')               
            end
            
            
%             % Motor A1
if f1==0
            Ep=(enc(1)-goal_enc(i,1));
            error(u,1)=Ep;
            Ei=(sum(error(:,1))/length(error(:,1)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
                f1=1;
                sp=0;
            end
            m1.Speed=sp;
end
%             
%             
            % Motor A2
            if f2==0
            Ep=(enc(2)-goal_enc(i,2));
            error(u,2)=Ep;
            Ei=(sum(error(:,2))/length(error(:,2)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
                sp=0;
                f2=1;
            end
            
            m2.Speed=sp;
            end
%             
                        % Motor A3
            if f3==0
            Ep=(enc(3)-goal_enc(i,3));
            error(u,3)=Ep;
            Ei=(sum(error(:,3))/length(error(:,3)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
                sp=0;
                f3=1;
            end
            
            m3.Speed=sp;
            end
            
%             
    % Motor B1
    if f4==0
            Ep=(enc(4)-goal_enc(i,4));
            error(u,4)=Ep;
            Ei=(sum(error(:,4))/length(error(:,4)));

            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
              sp=0;
              f4=1;
            end
            m4.Speed=sp;
    end
            
             % Motor B2
             if f5==0
            Ep=(enc(5)-goal_enc(i,5));
            error(u,5)=Ep;
            Ei=(sum(error(:,5))/length(error(:,5)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
                f5=1
              sp=0;
            end
            m5.Speed=sp;
             end
            
                        % Motor B3
                        if f6==0
            Ep=(enc(6)-goal_enc(i,6));
            error(u,6)=Ep;
            Ei=(sum(error(:,6))/length(error(:,6)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
              sp=0;
              f6=1;
            end
            m6.Speed=sp;
                        end
%             
%              % Motor C1
if f7==0
            Ep=(enc(7)-goal_enc(i,7));
            error(u,7)=Ep;
            Ei=(sum(error(:,7))/length(error(:,7)));

            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
              sp=0;
              f7=1
            end
            m7.Speed=sp;
end
            
             % Motor B2
             if f8==0
            Ep=(enc(8)-goal_enc(i,8));
            error(u,8)=Ep;
            Ei=(sum(error(:,8))/length(error(:,8)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
              sp=0;
              f8=1
            end
            m8.Speed=sp;
             end
            
                        % Motor B3
                        if f9==0
            Ep=(enc(9)-goal_enc(i,9));
            error(u,9)=Ep;
            Ei=(sum(error(:,9))/length(error(:,9)));
            sp=Gi*Ei+Gp*Ep;
            if sp>1
            sp=1;
            end
            if sp<-1
            sp=-1;
            end
            if and(Ep<thr,Ep>-thr)
              sp=0;
              f9=1;
            end
            m9.Speed=sp;
                        end
             
            disp(error(end,1:9))  

            u=u+1;
            fprintf('Iteration: %d - Time Elapsed: %f\n',u,time)
            
	        waitfor(r);
                        end
        
        timetot=toc
        timestep=timetot/length(rr(:,1));
        T = zeros(length(rr(:,1)),1);
for i=1:length(rr(:,1))
    T(i)=timestep*i;
end
        
%%
    stopAll(m1,m2,m3,m4,m5,m6,m7,m8,m9)
% figure(3)
% hold on 
% grid on 
% box on 
% subplot(3,3,1)
% plot(T,rr(:,1))
% yline(goal_enc(1),'--r','Motor 1')
% subplot(3,3,2)
% plot(T,rr(:,2))
% yline(goal_enc(2),'--r','Motor 2')
% subplot(3,3,3)
% plot(T,rr(:,2))
% yline(goal_enc(3),'--r','Motor 3')
% subplot(3,3,4)
% plot(T,rr(:,4))
% yline(goal_enc(4),'--r','Motor 4')
% subplot(3,3,5)
% plot(T,rr(:,5))
% yline(goal_enc(5),'--r','Motor 5')
% subplot(3,3,6)
% plot(T,rr(:,6))
% yline(goal_enc(6),'--r','Motor 6')
% subplot(3,3,7)
% plot(T,rr(:,7))
% yline(goal_enc(7),'--r','Motor 7')
% subplot(3,3,8)
% plot(T,rr(:,8))
% yline(goal_enc(8),'--r','Motor 8')
% subplot(3,3,9)
% plot(T,rr(:,9))
% yline(goal_enc(9),'--r','Motor 9')
% 
% xlim([0,timetot])
% 
% legend('Encoder position','Goal')
% 
% l0=200; %[mm]
% wires=l0+rr*0.011; % wires length in mm
% goal_wir=l0+goal_enc*0.011;
% figure(2)
% hold on 
% grid on 
% box on 
% 
% plot(T,wires(:,1),'r','linewidth',2)
% yline(goal_wir(1),'--r','Motor 1')
% plot(T,wires(:,2),'m','linewidth',2)
% yline(goal_wir(2),'--m','Motor 2')
% plot(T,wires(:,3),'b','linewidth',2)
% yline(goal_wir(3),'--b','Motor 3')
% plot(T,wires(:,4),'k','linewidth',2)
% yline(goal_wir(4),'--k','Motor 4')
% plot(T,wires(:,5),'g','linewidth',2)
% yline(goal_wir(5),'--g','Motor 5')
% plot(T,wires(:,6),'c','linewidth',2)
% yline(goal_wir(6),'--c','Motor 6')
%  plot(T,wires(:,7),'color',[0, 0.4470, 0.7410],'linewidth',2)
%  yline(goal_wir(7),'--','Motor 7','color',[0, 0.4470, 0.7410])
%  plot(T,wires(:,8),'color',[0.8500, 0.3250, 0.0980]	,'linewidth',2)
%  yline(goal_wir(8),'--','Motor 8','color',[0.8500, 0.3250, 0.0980]	)
%  plot(T,wires(:,9),'color',[0.4660, 0.6740, 0.1880],'linewidth',2)
%  yline(goal_wir(9),'--','Motor 9','color',[0.4660, 0.6740, 0.1880])
% xlim([0,timetot])
% xlabel('time [s]','Interpreter','Latex')
% ylabel('wires [mm]','Interpreter','Latex')
    function stopAll(m1,m2,m3,m4,m5,m6,m7,m8,m9)
    m1.Speed=0;
    m2.Speed=0;
    m3.Speed=0;
    m4.Speed=0;
    m5.Speed=0;
    m6.Speed=0;
    m7.Speed=0;
    m8.Speed=0;
    m9.Speed=0;
    end
    
    function e = getS(s,rr)
    global rr;
    s.flush();
    
    data = readline(s);
    data= readline(s);
        
    e=str2num(data)-500000;
    e=e(2:end);
    rr=[rr; e];
    end
end
