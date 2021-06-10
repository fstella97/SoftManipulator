%% Control scheme %%
clc
clear  all
close all 

global rr
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
    
     s1 = serialport("COM1",115200) % Arduino Due (only IMU)
     s2 = serialport("COM2",115200) %Arduino MEGA (Only 1 IMU)
   
    % Setup/flus Serial for reading IMU/Encoder values
    disp('Flushing IMU readings')
    s1.flush();
   for i=1:20
       readline(s1);
       readline(s2);
       i=i+1;
   end
    input('Click Enter to start reading the IMU')
    u=1;
    i=1;
    while(1)
        flush(s1)
        flush(s2)
        bb=str2num(readline(s1));
        bb2=str2num(readline(s2));
        quat1=str2num(readline(s1));
        quat2=str2num(readline(s2));
        save1(:,u)=quat1;
        save2(:,u)=quat2;
        %disp(quat)
        R_raw1=quat2rotm(quat1);
        R_raw2=quat2rotm(quat2);
        R_rel2=inv(R_raw1)*R_raw2;
        
        R_fix1=inv([R_raw1(1,1:2),0;R_raw1(2,1:2),0;0,0,1])*R_raw1;%%!!!! Very important, assumes that there will be no rotation around the z axis and compensate for the drift.
         %This compensatory rotation can be done with inv or transpose (now trans), but the orthogonality is not preserved (det != 1) %
        R_fix2=inv([R_raw2(1,1:2),0;R_raw2(2,1:2),0;0,0,1])*R_raw2;
         
         i=i+1;
        R1=R_raw1;
        R2=R_rel2;
        
        det(R_fix1)
        % from IMU rotation to PCC position based on z axis
        
        %R1   =[cos(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*cos(q1a)*(cos(q1c)-1),cos(q1a)*sin(q1c);...
        %       sin(q1a)*cos(q1a)*(cos(q1c)-1),sin(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*sin(q1c);...
        %       -cos(q1a)*sin(q1c),-sin(q1a)*sin(q1c)                   ,cos(q1c)];

        
        if i==3
            L=0.2;
            % Pose riconstruction from Dx Dy 
            Dx1=1/2*(R1(3,1)-R1(1,3))*acos(R1(3,3))/sin(acos(R1(3,3)));
            Dy1=1/2*(R1(3,2)-R1(2,3))*acos(R1(3,3))/sin(acos(R1(3,3)));
            Dx2=1/2*(R2(3,1)-R2(1,3))*acos(R2(3,3))/sin(acos(R2(3,3)));
            Dy2=1/2*(R2(3,2)-R2(2,3))*acos(R2(3,3))/sin(acos(R2(3,3)));
            %F(u)=plot_2DxDy(Dx1,Dy1,L,Dx2,Dy2,L,R1,R2);
             
%             D=sqrt(Dx1^2+Dy1^2);
%             q1c=D;
%             q1a=acos(-Dx1/D);
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
        u=u+1;
        i=1;
        end
   
        
    end
    
    
    function e = getS(s,rr)
    global rr;
    s.flush();
    
    data = readline(s);
    data= readline(s);
    rr=[rr; data];
    e=str2num(data);
    end