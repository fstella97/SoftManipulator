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
     shield1 = addon(a,'Adafruit\MotorShieldV2','I2CAddress', '0x62') %all righ I2c
     m1 = dcmotor(shield1,1);
     m2 = dcmotor(shield1,2);
     m3 = dcmotor(shield1,3);
     m4 = dcmotor(shield1,4);
pause(3);
   start(m1);
   start(m2);
   start(m3);
   start(m4);

 %%   
    pause(0.5);
    m1.Speed = 0
    m2.Speed = 0
    m3.Speed = 0
    m4.Speed = 0
    
  %%
      pause(0.5);
    m1.Speed = -1
    m2.Speed = -1 
    m3.Speed = -1
    m4.Speed = -1
    
    
  
    
