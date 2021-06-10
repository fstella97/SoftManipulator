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

     a = arduino('COM7','Uno','Libraries','Adafruit\MotorShieldV2')
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
%      
pause(3);
   start(m1);
   start(m2);
   start(m3);
   start(m4);
   start(m5);
   start(m6);
   start(m7);
   start(m8);
   start(m9);

 %%   
    pause(0.5);
    m1.Speed = 0
    m2.Speed = 0
    m3.Speed = 0
    m4.Speed = 0
    m5.Speed = 0
    m6.Speed = 0 
    m7.Speed = 0
    m8.Speed = 0
    m9.Speed = 0
    
  %%
      pause(0.5);
    m1.Speed = -1
    m2.Speed = -1 
    m3.Speed = -1
    m4.Speed = -1
    m5.Speed = -1
    m6.Speed = -1
    m7.Speed = -1
    m8.Speed = -1
    m9.Speed = -1
    %%
      pause(0.5);
    m1.Speed = 1
    m2.Speed = 1 
    m3.Speed = 1
    m4.Speed = 1
    m5.Speed = 1
    m6.Speed = 1
    m7.Speed = 1
    m8.Speed = 1
    m9.Speed = 1
    
    
  
    
