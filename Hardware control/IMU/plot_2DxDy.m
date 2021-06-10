function F=plot_2DxDy(Dx1,Dy1,L1,Dx2,Dy2,L2,R1,R2)
set(gca, 'TickLabelInterpreter', 'latex')
f=figure(1);
hold on 
cla
f.Position = [0 0 1924 990];
%figure('Renderer', 'painters', 'Position', [10 10 900 600])
%set(gcf, 'PaperSize', [4 2]);
% clf

subplot(1,2,[1,2])
%axis equal
            xlim([-0.3,0.3]);
            ylim([-0.3,0.3]);
            zlim([-0,0.3]);

view(-20-90-165,10+180)

hold on 
D1=sqrt(Dx1^2+Dy1^2);
            idx=linspace(0,1,20);
            for u=1:length(idx)
            C1=cos(idx(u)*D1)-1;
            S1=sin(idx(u)*D1);    
            t_IMU1(u,:)=L1/(D1^2)*[Dx1*C1;...
                                Dy1*C1;...
                                D1*S1];
            end
            
D2=sqrt(Dx2^2+Dy2^2);
            for u=1:length(idx)
            C2=cos(idx(u)*D2)-1;
            S2=sin(idx(u)*D2);    
            t_IMU2(u,:)=L2/(D2^2)*[Dx2*C2;...
                                Dy2*C2;...
                                D2*S2];
                     
            t_IMU2(u,:)=[[t_IMU1(20,1);t_IMU1(20,2);t_IMU1(20,3)]+R1*t_IMU2(u,:)']';                
            end            
            

            plot3(t_IMU1(:,1),t_IMU1(:,2),t_IMU1(:,3),'r','linewidth',5)
            ee1=[t_IMU1(20,1),t_IMU1(20,2),t_IMU1(20,3)];
            
            plot3(t_IMU2(:,1),t_IMU2(:,2),t_IMU2(:,3),'color',[0.8500, 0.3250, 0.0980],'linewidth',5)
            ee2=[t_IMU2(20,1),t_IMU2(20,2),t_IMU2(20,3)];
            
            x_MC=arrow3(ee1,ee1+R1(:,1)'./15,'k',1,1);
            y_MC=arrow3(ee1,ee1+R1(:,2)'./15,'k',1,1);
            z_MC=arrow3(ee1,ee1+R1(:,3)'./15,'k',1,1);
            x_2=arrow3(ee2,ee2+R2(:,1)'./15,'k',1,1);
            y_2=arrow3(ee2,ee2+R2(:,2)'./15,'k',1,1);
            z_2=arrow3(ee2,ee2+R2(:,3)'./15,'k',1,1);
            set(gca,'FontSize',22);

     xlim([-0.5,0.5]);
            ylim([-0.5,0.5]);
            zlim([-0,0.52]);  
            
set(gca,'zdir','reverse')
% subplot(1,2,2) 
% hold on 
% plot3(t_IMU2(:,1),t_IMU2(:,2),t_IMU2(:,3),'color',[0.8500, 0.3250, 0.0980],'linewidth',2)
% 
%             plot3(t_IMU1(:,1),t_IMU1(:,2),t_IMU1(:,3),'r','linewidth',2)
%         x_MC=arrow3(ee1,ee1+R1(:,1)'./10,'k',1,1);
%         y_MC=arrow3(ee1,ee1+R1(:,2)'./10,'k',1,1);
%         z_MC=arrow3(ee1,ee1+R1(:,3)'./10,'m',1,1);
%         x_2=arrow3(ee2,ee2+R2(:,1)'./10,'k',1,1);
%             y_2=arrow3(ee2,ee2+R2(:,2)'./10,'k',1,1);
%             z_2=arrow3(ee2,ee2+R2(:,3)'./10,'m',1,1);
% 
%             xlim([-0.5,0.5]);
%             ylim([-0.5,0.5]);
%             zlim([-0,0.5]);
%         
%             view(0,90)

%grid on 
%set(gcf, 'color', 'none')
xlabel('x [m]','Interpreter','latex')
ylabel('y [m]','Interpreter','latex')
zlabel('z [m]','Interpreter','latex')
 F=getframe(f);           
            
end
                  