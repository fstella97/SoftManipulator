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
     a = arduino('COM7','Uno','Libraries','Adafruit\MotorShieldV2')
     shield = addon(a,'Adafruit\MotorShieldV2')
     s = serialport("COM8",4800) % speed of transmission 9600 : too high missing data: put it the same of the arduino 
   
     m1 = dcmotor(shield,1);
     m2 = dcmotor(shield,2);
     m3 = dcmotor(shield,3);
     m4 = dcmotor(shield,4);
pause(3);
   start(m1);
   start(m2);
   start(m3);
   start(m4);

   o=50;
    
%% From Francesco - Open loop control to a desired position.
    
%4) From the segments length, find the corresponding Encoder readings.
    Enc=[-2000,-2000,-2000];
    
%5) Define the initial encoder goal position (achieved in a open loop fashion, with no IMU comparison).
    goal_enc=(Enc'+ 500000)'; 
    
%% Mix Francesco Josie scripts - Closed loop control 
pause(2);
    m1.Speed = 0;
    m2.Speed = 0;
    m3.Speed = 0;
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
    ms1= -1;
    ms2= -0.2;
    ms3= -0.05;
%%       
    % Loop to go to each position defined by the rows in d
    i=1;

f1=0;f2=0;f3=0;
        while(1)
            enc = getS(s);
            r=[r;enc];
            if (f3==1 && f2 ==1 && f1 ==1)
                f1=0;f2=0;f3=0;
                goal_enc= input('Position achieved, \nProvide another position as a 3x1 array \n')
                goal_enc=goal_enc + 500000;
                
            end
                
            % Motor A
            diff1 = abs(enc(3)-goal_enc(i,1));
            if(diff1>o && f1 ==0)
                if(enc(3) > goal_enc(i,1)+o)
                    m1.Speed = ms1;
                    if(diff1 < 250); m1.Speed = ms2; end
                    if(diff1 < 100); m1.Speed = ms3; end
                end
                if(enc(3) < goal_enc(i,1)-o)
                    m1.Speed = -ms1;
                    if(diff1 < 250); m1.Speed = -ms2; end
                    if(diff1 < 100); m1.Speed = -ms3; end
                end
            else
                m1.Speed = 0;
                f1 =1;
            end
            
            % Motor B
            diff2 = abs(enc(2)-goal_enc(i,2));
            if(diff2>o && f2 ==0)
                if(enc(2) > goal_enc(i,2)+o)
                    m2.Speed = ms1;
                    if(diff2 < 200); m2.Speed = ms2; end
                    if(diff2 < 100); m2.Speed = ms3; end
                end
                if(enc(2) < goal_enc(i,2)-o)
                    m2.Speed = -ms1;
                    if(diff2 < 200); m2.Speed = -ms2; end
                    if(diff2 < 100); m2.Speed = -ms3; end
                end
            else
                m2.Speed = 0;
                f2 =1;
            end
            
            % Motor C
            diff3 = abs(enc(1)-goal_enc(i,3));
            if(diff3>o && f3 ==0)
                if(enc(1) > goal_enc(i,3)+o)
                    m3.Speed = ms1;
                    if(diff3 < 200); m3.Speed = ms2; end
                    if(diff3 < 100); m3.Speed = ms3; end
                end
                if(enc(1) < goal_enc(i,3)-o)
                    m3.Speed = -ms1;
                    if(diff3 < 200); m3.Speed = -ms2; end
                    if(diff3 < 100); m3.Speed = -ms3; end
                end
            else
                m3.Speed = 0;
                f3 =1;
                
            end
            disp([diff1 diff2 diff3])
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
