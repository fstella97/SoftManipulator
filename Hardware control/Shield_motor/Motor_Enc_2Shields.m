%% Control scheme %%
clc
clear  
close all 

%% From Josie  - Matlab Arduino serial connection setup
%%% SETUP Connections to Arduinos %%%
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
    % COM7 top left,COM3,COM5,COM9
     s = serialport("COM8",9600) % speed of transmission 9600 : too high missing data: put it the same of the arduino 
     a = arduino('COM7','Uno','Libraries','Adafruit\MotorShieldV2')
     shield1 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x60') %all right 12c
     shield2 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x61') %all right 12c

     
     m1 = dcmotor(shield1,1);
     m2 = dcmotor(shield1,2);
     m3 = dcmotor(shield1,3);
  
     m4 = dcmotor(shield2,1);
     m5 = dcmotor(shield2,2);
     m6 = dcmotor(shield2,3);


pause(3);
   start(m1);
   start(m2);
   start(m3);
   start(m4);
   start(m5);
   start(m6);
   

   o=50;
    
%% From Francesco - Open loop control to a desired position.
    
%4) From the segments length, find the corresponding Encoder readings.
    Enc=[-2000,-2000,-2000,-2000,-2000,-2000];
    
%5) Define the initial encoder goal position (achieved in a open loop fashion, with no IMU comparison).
    goal_enc=(Enc'+ 500000)'; 
    
%% Mix Francesco Josie scripts - Closed loop control 
pause(2);
    m1.Speed = 0;
    m2.Speed = 0;
    m3.Speed = 0;
    m4.Speed = 0;
    m5.Speed = 0;
    m6.Speed = 0;
    
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
    input('Wait for key press')
    
    % Set base speeds for the motors
    ms1= 0.8;
    ms2= 0.1;
    ms3= 0.05;
%%       
    % Loop to go to each position defined by the rows in d
    i=1;

f1=0;f2=0;f3=0;f4=0;f5=0;f6=0;
        while(1)
            enc = getS(s);
            r=[r;enc];
            if (f3==1 && f2 ==1 && f1 ==1 && f4 ==1 && f5 ==1 && f6 ==1)
                f1=0;f2=0;f3=0;
                goal_enc= input('Position achieved, \nProvide another position as a 6x1 array \n')
                goal_enc=goal_enc + 500000;
                
            end
                
            % Motor A
            diff1 = abs(enc(1)-goal_enc(i,1));
            if(diff1>o && f1 ==0)
                if(enc(1) > goal_enc(i,1)+o)
                    m1.Speed = ms1;
                    if(diff1 < 250); m1.Speed = ms2; end
                    if(diff1 < 100); m1.Speed = ms3; end
                end
                if(enc(1) < goal_enc(i,1)-o)
                    m1.Speed = -ms1;
                    if(diff1 < 250); m1.Speed = -ms2; end
                    if(diff1 < 100); m1.Speed = -ms3; end
                end
            else
                m1.Speed = 0;
                f1 =1;
            end
            
            % Motor B
            diff2 = abs(enc(3)-goal_enc(i,2));
            if(diff2>o && f2 ==0)
                if(enc(3) > goal_enc(i,2)+o)
                    m2.Speed = ms1;
                    if(diff2 < 200); m2.Speed = ms2; end
                    if(diff2 < 100); m2.Speed = ms3; end
                end
                if(enc(3) < goal_enc(i,2)-o)
                    m2.Speed = -ms1;
                    if(diff2 < 200); m2.Speed = -ms2; end
                    if(diff2 < 100); m2.Speed = -ms3; end
                end
            else
                m2.Speed = 0;
                f2 =1;
            end
            
            % Motor C
            diff3 = abs(enc(2)-goal_enc(i,3));
            if(diff3>o && f3 ==0)
                if(enc(2) > goal_enc(i,3)+o)
                    m3.Speed = ms1;
                    if(diff3 < 200); m3.Speed = ms2; end
                    if(diff3 < 100); m3.Speed = ms3; end
                end
                if(enc(3) < goal_enc(i,3)-o)
                    m3.Speed = -ms1;
                    if(diff3 < 200); m3.Speed = -ms2; end
                    if(diff3 < 100); m3.Speed = -ms3; end
                end
            else
                m3.Speed = 0;
                f3 =1;
                
            end
            
            diff4 = abs(enc(4)-goal_enc(i,4));
            if(diff4>o && f4 ==0)
                if(enc(4) > goal_enc(i,4)+o)
                    m4.Speed = ms1;
                    if(diff4 < 200); m4.Speed = ms2; end
                    if(diff4 < 100); m4.Speed = ms3; end
                end
                if(enc(4) < goal_enc(i,4)-o)
                    m4.Speed = -ms1;
                    if(diff4 < 200); m4.Speed = -ms2; end
                    if(diff4 < 100); m4.Speed = -ms3; end
                end
            else
                m4.Speed = 0;
                f4 =1;
                
            end
            
            diff5 = abs(enc(5)-goal_enc(i,5));
            if(diff5>o && f5 ==0)
                if(enc(5) > goal_enc(i,5)+o)
                    m5.Speed = ms1;
                    if(diff5 < 200); m5.Speed = ms2; end
                    if(diff5 < 100); m5.Speed = ms3; end
                end
                if(enc(5) < goal_enc(i,5)-o)
                    m5.Speed = -ms1;
                    if(diff5 < 200); m5.Speed = -ms2; end
                    if(diff5 < 100); m5.Speed = -ms3; end
                end
            else
                m5.Speed = 0;
                f5 =1;
                
            end
            
            diff6 = abs(enc(6)-goal_enc(i,6));
            if(diff6>o && f6 ==0)
                if(enc(6)> goal_enc(i,6)+o)
                    m6.Speed = ms1;
                    if(diff6 < 200); m6.Speed = ms2; end
                    if(diff6 < 100); m6.Speed = ms3; end
                end
                if(enc(6) < goal_enc(i,6)-o)
                    m6.Speed = -ms1;
                    if(diff6 < 200); m6.Speed = -ms2; end
                    if(diff6< 100); m6.Speed = -ms3; end
                end
            else
                m6.Speed = 0;
                f6 =1;
                
            end
            
            disp([diff1 diff2 diff3 diff4 diff5 diff6   ])
        end

    stop(m1);
    stop(m2);
    stop(m3);



    function i = stopAll
    stop(m1);
    stop(m2);
    stop(m3);
    end
    
    function e = getS(s,rr)
    global rr;
    s.flush();
    
    data = readline(s);
    data= readline(s);
    rr=[rr; data];
    e=str2num(data);
    end
