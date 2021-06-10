%% Control scheme %%
clc
clear  
close all 

global rr
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
    
     s = serialport("COM2",115200) % speed of transmission 9600 : too high missing data: put it the same of the arduino 
   
   
    % Setup/flus Serial for reading IMU/Encoder values
    disp('Flushing IMU readings')
    s.flush();
   for i=1:20
       readline(s);
       i=i+1;
   end
    input('Click Enter to start reading the IMU')
    i=1;
    while(1)
        flush(s)
        quat=str2num(readline(s))
        quat=str2num(readline(s));
        %disp(quat)
        R_raw=quat2rotm(quat);
        
        R_fix=inv([R_raw(1,1:2),0;R_raw(2,1:2),0;0,0,1])*R_raw;%%!!!! Very important, assumes that there will be no rotation around the z axis and compensate for the drift.
         %This compensatory rotation can be done with inv or transpose (now trans), but the orthogonality is not preserved (det != 1) %
        i=i+1;
        R=R_fix;
        det(R_fix)
        % from IMU rotation to PCC position based on z axis
        
        %R1   =[cos(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*cos(q1a)*(cos(q1c)-1),cos(q1a)*sin(q1c);...
        %       sin(q1a)*cos(q1a)*(cos(q1c)-1),sin(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*sin(q1c);...
        %       -cos(q1a)*sin(q1c),-sin(q1a)*sin(q1c)                   ,cos(q1c)];

        
        if i==10
            L=0.2;
            % Pose riconstruction from Dx Dy 
            Dx=1/2*(R(3,1)-R(1,3))*acos(R(3,3))/sin(acos(R(3,3)));
            Dy=1/2*(R(3,2)-R(2,3))*acos(R(3,3))/sin(acos(R(3,3)));
            ee=plot_DxDy(Dx,Dy,L,R);
             
            D=sqrt(Dx^2+Dy^2);
            q1c=D;
            q1a=acos(-Dx/D);
            %Kinematic_robot_model([q1c,q1a,L],1,'b');

        % Plot the position
%         figure(1)
%         clf
%         q1c=acos(R(3,3));
% %         sin(q1c)
% %         q1a_1=asin(R(2,3)/sin(q1c));
% %         q1a_2=acos(R(1,3)/sin(q1c));
% %         q1a=(q1a_1+q1a_2)/2;
%         q1a=(R(1,3)-R(3,1))/(2*sin(q1c))
%         
%         
%         q1l=0.2;
%         % Single segment plot
%         ee=Kinematic_robot_model([q1c,q1a,q1l],1,'r');
%         
%         
%          hold on 
%         x_MC=arrow3(ee,ee+R(:,1)'./10,'k',1,1);
%         y_MC=arrow3(ee,ee+R(:,2)'./10,'k',1,1);
%         z_MC=arrow3(ee,ee+R(:,3)'./10,'m',1,1);
%         view(20+90,30);

        
%         figure(2)
%         clf
%          hold on 
%         x_MC=arrow3([0,0,0],R(:,1)'./10,'k',1,1);
%         y_MC=arrow3([0,0,0],R(:,2)'./10,'k',1,1);
%         z_MC=arrow3([0,0,0],R(:,3)'./10,'m',1,1);
%         view(20+90+180,30);
%         xlim([-0.3,0.3])
%          ylim([-0.3,0.3])
%          zlim([-0.3,0.3])
        
        i=1;
        end
   
        
    end
    
    z
    function e = getS(s,rr)
    global rr;
    s.flush();
    
    data = readline(s);
    data= readline(s);
    rr=[rr; data];
    e=str2num(data);
    end