%% Read Encoders and plots them 
close all 
clear all 
clc

DlgH = figure;
H = uicontrol('Style', 'PushButton', ...
              'String', 'Break', ...
              'Callback', 'delete(gcbf)');
s = serialport("COM8",9600) % speed of transmission 9600 : too high missing data: put it the same of the arduino 
a = arduino('COM7','Uno','Libraries','Adafruit\MotorShieldV2')
 

shield1 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x61') %bottom shield
 m1 = dcmotor(shield1,1);
     m2 = dcmotor(shield1,2);
     m3 = dcmotor(shield1,3);
 start(m1);
   start(m2);
   start(m3);


    disp('Flushing Encoders')
    s.flush();
    for i=1:25%250
        tests = readline(s);
        
    end
    disp('Finish Flush Encoders')
    input('Wait for key press')

    global rr;
        while (ishandle(H))
    s.flush();
    
   m1.Speed=-1;
      m2.Speed=-1; 
      m3.Speed=-1; 
    data = readline(s);
    data= readline(s);
        
    e=str2num(data)-500000;
    e=e(2:end);
    rr=[rr; e];
    
    
        end
        %%
m1.Speed=0  
m2.Speed=0  
m3.Speed=0  
figure(1)
hold on 
grid on 
box on 
plot(rr(:,:))
legend('motor1','motor2','motor3','motor4','motor5','motor6','motor7','motor8','motor9')

% 
% plot(rr(:,2),'b')
% 
% 
% plot(rr(:,2),'g')
