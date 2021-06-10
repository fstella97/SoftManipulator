function F=plot_cylinder_bend(q,pressure,figureidx)
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(gcf, 'Position',[113   293   700   420])   %[x y width height]
n=15; %number of points for each circle

fullfig(figureidx)
hold on 
set(gca,'FontSize',22);
set(gca, 'TickLabelInterpreter', 'latex')
box on

title('Stiffness - Pose Optimization','Interpreter','latex')
q1c=q(1);
q1a=q(2);
q1l=0.21;
q2c=q(3);
q2a=q(4);
q2l=0.21;
q3c=q(5);
q3a=q(6);
q3l=0.21;
c=[];
d=0.05; %Diameter of the base [m]
r=d/2;
span_circle=-pi:0.1:(pi+pi/20);
x_circ=r*cos(span_circle);
y_circ=r*sin(span_circle);
z_circ=zeros(1,numel(x_circ));
%%% Robot Kinematic %%%
R1   =[cos(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*cos(q1a)*(cos(q1c)-1),cos(q1a)*sin(q1c);...
       sin(q1a)*cos(q1a)*(cos(q1c)-1),sin(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*sin(q1c);...
       -cos(q1a)*sin(q1c),-sin(q1a)*sin(q1c),cos(q1c)];
   
R2   =[cos(q2a)^2*(cos(q2c)-1)+1,sin(q2a)*cos(q2a)*(cos(q2c)-1),cos(q2a)*sin(q2c);...
       sin(q2a)*cos(q2a)*(cos(q2c)-1),sin(q2a)^2*(cos(q2c)-1)+1,sin(q2a)*sin(q2c);...
       -cos(q2a)*sin(q2c),-sin(q2a)*sin(q2c),cos(q2c)];
R2=R1*R2;   
R3   =[cos(q3a)^2*(cos(q3c)-1)+1,sin(q3a)*cos(q3a)*(cos(q3c)-1),cos(q3a)*sin(q3c);...
       sin(q3a)*cos(q3a)*(cos(q3c)-1),sin(q3a)^2*(cos(q3c)-1)+1,sin(q3a)*sin(q3c);...
       -cos(q3a)*sin(q3c),-sin(q3a)*sin(q3c),cos(q3c)];
R3=R2*R3;      

idx=linspace(0,1,20);
for m=1:length(idx)
C1=1-cos(idx(m)*q1c);
S1=sin(idx(m)*q1c);    
body1(m,:)=q1l/(q1c)*[cos(q1a)*C1;
                      sin(q1a)*C1;...
                         S1];
c=[c;ones(1,n+1)*pressure(1)];                     
% rack1(m,:)=[d/2;0;0]+(q1l-q1c*d/2*cos(q1a))/(q1c)*[cos(q1a)*C1;
%                                               sin(q1a)*C1;...
%                                               S1];  
% 
% rack20= [d/2*cos(2/3*pi);d/2*sin(2/3*pi);0];                                         
% rack2(m,:)=rack20+(q1l-q1c*rack20(1)*cos(q1a)-q1c*rack20(2)*sin(q1a))/(q1c)*[cos(q1a)*C1;
%                                                                              sin(q1a)*C1;...
%                                                                              S1]; 
% rack30= [d/2*cos(4/3*pi);d/2*sin(4/3*pi);0];                                         
% rack3(m,:)=rack30+(q1l-q1c*rack30(1)*cos(q1a)-q1c*rack30(2)*sin(q1a))/(q1c)*[cos(q1a)*C1;
%                                                                              sin(q1a)*C1;...
%                                                                              S1]; 
                                                                     
end

for m=1:length(idx)
C2=1-cos(idx(m)*q2c);
S2=sin(idx(m)*q2c);    
body2(m,:)=q2l/(q2c)*[cos(q2a)*C2;
                      sin(q2a)*C2;...
                         S2];
% rack1_2(m,:)=[d/2;0;0]+(q2l-q2c*d/2*cos(q2a))/(q2c)*[cos(q2a)*C2;
%                                               sin(q2a)*C2;...
%                                               S2];  
%                                         
% rack2_2(m,:)=rack20+(q2l-q2c*rack20(1)*cos(q2a)-q2c*rack20(2)*sin(q2a))/(q2c)*[cos(q2a)*C2;
%                                                                                sin(q2a)*C2;...
%                                                                                S2]; 
%                                      
% rack3_2(m,:)=rack30+(q2l-q2c*rack30(1)*cos(q2a)-q2c*rack30(2)*sin(q2a))/(q2c)*[cos(q2a)*C2;
%                                                                              sin(q2a)*C2;...
%                                                                              S2]; 
c=[c;pressure(4)*ones(1,n+1)];    
body2(m,:)=  [body1(end,:)'+R1* body2(m,:)']'  ;    
% rack1_2(m,:)=[body1(end,:)'+R1* rack1_2(m,:)']';  
% rack2_2(m,:)=[body1(end,:)'+R1* rack2_2(m,:)']';  
% rack3_2(m,:)=[body1(end,:)'+R1* rack3_2(m,:)']';  
end

for m=1:length(idx)
C3=1-cos(idx(m)*q3c);
S3=sin(idx(m)*q3c);    
body3(m,:)=q3l/(q3c)*[cos(q3a)*C3;
                      sin(q3a)*C3;...
                         S3];
% rack1_3(m,:)=[d/2;0;0]+(q3l-q3c*d/2*cos(q3a))/(q3c)*[cos(q3a)*C3;
%                                               sin(q3a)*C3;...
%                                               S3];  
%                                         
% rack2_3(m,:)=rack20+(q3l-q3c*rack20(1)*cos(q3a)-q3c*rack20(2)*sin(q3a))/(q3c)*[cos(q3a)*C3;
%                                                                                sin(q3a)*C3;...
%                                                                                S3]; 
%                                      
% rack3_3(m,:)=rack30+(q3l-q3c*rack30(1)*cos(q3a)-q3c*rack30(2)*sin(q3a))/(q3c)*[cos(q3a)*C3;
%                                                                              sin(q3a)*C3;...
%                                                                              S3]; 
%
c=[c;pressure(6)*ones(1,n+1)];    
body3(m,:)=  [body2(end,:)'+R2* body3(m,:)']'  ;    
% rack1_3(m,:)=[body2(end,:)'+R2* rack1_3(m,:)']';  
% rack2_3(m,:)=[body2(end,:)'+R2* rack2_3(m,:)']';  
% rack3_3(m,:)=[body2(end,:)'+R2* rack3_3(m,:)']';  
end


circle1=[0;0;0];
circle2=[0;0;0];
%Circle on top of 1
for l=1:length(x_circ)
circle1(:,l)=body1(end,:)'+R1*[x_circ(l);y_circ(l),;z_circ(l)];
circle2(:,l)=body2(end,:)'+R2*[x_circ(l);y_circ(l),;z_circ(l)];
circle3(:,l)=body3(end,:)'+R3*[x_circ(l);y_circ(l),;z_circ(l)];
end

fullbody=[body1;body2;body3]';

figure(figureidx)
hold on 
% grid on 
% grid minor 
tubeplot(fullbody,0.03,c',n,0.0001);
% 
% b3=plot3(rack1(:,1),rack1(:,2),rack1(:,3),'color',color1,'linewidth',2); % Rack1_1
% b4=plot3(rack2(:,1),rack2(:,2),rack2(:,3),'color',color1,'linewidth',2); % Rack1_2
% b5=plot3(rack3(:,1),rack3(:,2),rack3(:,3),'color',color1,'linewidth',2); % Rack1_3
% b6=plot3(rack1_2(:,1),rack1_2(:,2),rack1_2(:,3),'color',color2,'linewidth',2); % Rack1_1
% b7=plot3(rack2_2(:,1),rack2_2(:,2),rack2_2(:,3),'color',color2,'linewidth',2); % Rack1_2
% b8=plot3(rack3_2(:,1),rack3_2(:,2),rack3_2(:,3),'color',color2,'linewidth',2); % Rack1_3
% b9=plot3(rack1_3(:,1),rack1_3(:,2),rack1_3(:,3),'color',color3,'linewidth',2); % Rack1_1
% b10=plot3(rack2_3(:,1),rack2_3(:,2),rack2_3(:,3),'color',color3,'linewidth',2); % Rack1_2
% b11=plot3(rack3_3(:,1),rack3_3(:,2),rack3_3(:,3),'color',color3,'linewidth',2); % Rack1_3
% 
% %b2=plot3(x_desired(1,u),x_desired(2,u),x_desired(3,u),'xr');  % Goal
% 
% plot3(body3(20,1),body3(20,2),body3(20,3),'.','color',[0.8500, 0.3250, 0.0980]); %end-effector trajectory
% %plot3(x_desired(1,u),x_desired(2,u),x_desired(3,u),'.','color',[0.4660, 0.6740, 0.1880]); %goal trajectory
circle0=plot3(x_circ,y_circ,z_circ,'color','k','linewidth',1.5);
 circle1=plot3(circle1(1,:),circle1(2,:),circle1(3,:),'color','k','linewidth',1.5); %top 1 circle
 circle2=plot3(circle2(1,:),circle2(2,:),circle2(3,:),'color','k','linewidth',1.5); %top 1 circle
 circle3=plot3(circle3(1,:),circle3(2,:),circle3(3,:),'color','k','linewidth',1.5);
xlim([-0.7,0.7])
ylim([-0.7,0.7])
zlim([-0.01,1])

% 
% xlim([-4,4])
% ylim([-4,4])
% zlim([-1,7])

view(20,20)%20,20
%set(gcf, 'Position', [50   50   900   600])   %[x y width height]
set(gca,'FontSize',22);
set(gca, 'TickLabelInterpreter', 'latex')
xlabel('x [m]','Interpreter','latex')
ylabel('y [m]','Interpreter','latex')
zlabel('z [m]','Interpreter','latex')

set(gca, 'Zdir', 'reverse')
pbaspect([1 1 1/0.7])
end


