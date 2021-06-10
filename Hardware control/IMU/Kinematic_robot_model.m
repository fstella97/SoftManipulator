
function ee= Kinematic_robot_model(q,figureidx,color1)

q1c=q(1);
q1a=q(2);
q1l=q(3);


d=0.1; %Diameter of the base [m]
r=d/2;
span_circle=-pi:0.1:(pi+pi/20);
x_circ=r*cos(span_circle);
y_circ=r*sin(span_circle);
z_circ=zeros(1,numel(x_circ));
%%% Robot Kinematic %%%
R1   =[cos(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*cos(q1a)*(cos(q1c)-1),cos(q1a)*sin(q1c);...
       sin(q1a)*cos(q1a)*(cos(q1c)-1),sin(q1a)^2*(cos(q1c)-1)+1,sin(q1a)*sin(q1c);...
       -cos(q1a)*sin(q1c),-sin(q1a)*sin(q1c),cos(q1c)];
 
idx=linspace(0,1,20);
for m=1:length(idx)
C1=1-cos(idx(m)*q1c);
S1=sin(idx(m)*q1c);    
body1(m,:)=q1l/(q1c)*[cos(q1a)*C1;
                      sin(q1a)*C1;...
                         S1];
rack1(m,:)=[d/2;0;0]+(q1l-q1c*d/2*cos(q1a))/(q1c)*[cos(q1a)*C1;
                                              sin(q1a)*C1;...
                                              S1];  

rack20= [d/2*cos(2/3*pi);d/2*sin(2/3*pi);0];                                         
rack2(m,:)=rack20+(q1l-q1c*rack20(1)*cos(q1a)-q1c*rack20(2)*sin(q1a))/(q1c)*[cos(q1a)*C1;
                                                                             sin(q1a)*C1;...
                                                                             S1]; 
rack30= [d/2*cos(4/3*pi);d/2*sin(4/3*pi);0];                                         
rack3(m,:)=rack30+(q1l-q1c*rack30(1)*cos(q1a)-q1c*rack30(2)*sin(q1a))/(q1c)*[cos(q1a)*C1;
                                                                             sin(q1a)*C1;...
                                                                             S1]; 
                                                                     
end

circle1=[0;0;0];
circle2=[0;0;0];
%Circle on top of 1
for l=1:length(x_circ)
circle1(:,l)=body1(end,:)'+R1*[x_circ(l);y_circ(l),;z_circ(l)];
end

%b1=plot3(body1(:,1),body1(:,2),body1(:,3),'k','linewidth',2); % Central line


figure(figureidx)
hold on 



b3=plot3(rack1(:,1),rack1(:,2),rack1(:,3),'color',color1,'linewidth',2); % Rack1_1
b4=plot3(rack2(:,1),rack2(:,2),rack2(:,3),'color',color1,'linewidth',2); % Rack1_2
b5=plot3(rack3(:,1),rack3(:,2),rack3(:,3),'color',color1,'linewidth',2); % Rack1_3
circle0=plot3(x_circ,y_circ,z_circ,'color',color1,'linewidth',2);
circle1=plot3(circle1(1,:),circle1(2,:),circle1(3,:),'color',color1,'linewidth',2); %top 1 circle
% xlim([-0.3,0.3])
% ylim([-0.3,0.3])
% zlim([-0.01,0.5])
% 
% view(20,20)
% % set(gcf, 'Position', [50   50   900   600])   %[x y width height]
% set(gca,'FontSize',22);
% set(gca, 'TickLabelInterpreter', 'latex')
% grid on, box on
% 
% xlabel('x [m]','Interpreter','latex')
% ylabel('y [m]','Interpreter','latex')
% zlabel('z [m]','Interpreter','latex')
% ee=[body1(end,1),body1(end,2),body1(end,3)];
end









