
clear all 
close all 
clc 
load('experiment11.mat')

% set(gca, 'TickLabelInterpreter', 'latex')

figure(2)
hold on 
plot(save1(1,:),'r')
plot(save1(2,:),'r')
plot(save1(3,:),'r')
plot(save1(4,:),'r')

plot(save2(1,:),'b')
plot(save2(2,:),'b')
plot(save2(3,:),'b')
plot(save2(4,:),'b')
%%
for i=1:length(save1(1,:))
    i/length(save1(1,:))
        quat1=save1(:,i)';
        quat2=save2(:,i)';
        %disp(quat)
        cal=+pi/3+pi;
        R_raw1=quat2rotm(quat1);
        R_raw2=quat2rotm(quat2);
        R_rel2=[cos(cal),-sin(cal),0;sin(cal),cos(cal),0;0,0,1]*inv(R_raw1)*R_raw2;
        
        R_fix1=inv([R_raw1(1,1:2),0;R_raw1(2,1:2),0;0,0,1])*R_raw1;%%!!!! Very important, assumes that there will be no rotation around the z axis and compensate for the drift.
         %This compensatory rotation can be done with inv or transpose (now trans), but the orthogonality is not preserved (det != 1) %
        R_fix2=inv([R_raw2(1,1:2),0;R_raw2(2,1:2),0;0,0,1])*R_raw2;
         R_rel_fix=inv(R_fix1)*R_fix2;
        
         
         
%         R1=R_fix1;
%         R2=R_rel_fix;

        R1=R_raw1;
        R2=R_rel2;
        
            L=0.21;
            % Pose riconstruction from Dx Dy 
            Dx1=1/2*(R1(3,1)-R1(1,3))*acos(R1(3,3))/sin(acos(R1(3,3)));
            Dy1=1/2*(R1(3,2)-R1(2,3))*acos(R1(3,3))/sin(acos(R1(3,3)));
            Dx2=1/2*(R2(3,1)-R2(1,3))*acos(R2(3,3))/sin(acos(R2(3,3)));
            Dy2=1/2*(R2(3,2)-R2(2,3))*acos(R2(3,3))/sin(acos(R2(3,3)));
            F(i)=plot_2DxDy(Dx1,Dy1,L,Dx2,Dy2,L,R1,R2);
              i=i+3;
 
end
%%
writerObj=VideoWriter('Data_animation2','MPEG-4');
% set the seconds per image
writerObj.FrameRate=31 ;%124;
writerObj.VideoCompressionMethod

% open the video writer
open(writerObj);
% write the frames to the video
for i=2:length(F)
    % convert the image to a frame
    frame=F(i);    
    writeVideo(writerObj,frame);
end
% close the writer object
close(writerObj);