function ee1=plot_3DxDy(Dx1,Dy1,L1,Dx2,Dy2,L2,Dx3,Dy3,L3,R01,R12,R23)

% R12 and R23 are the relative rotations between the nearby segments

% R2 is the real rotation respect to the general frame
R2=R01*R12;
R3=R2*R23;
figure(1)
clf
subplot(1,2,1)
axis equal


view(-20,30)

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
                     
            t_IMU2(u,:)=[[t_IMU1(20,1);t_IMU1(20,2);t_IMU1(20,3)]+R01*t_IMU2(u,:)']';                
            end    
            
D3=sqrt(Dx3^2+Dy3^2);
            for u=1:length(idx)
            C3=cos(idx(u)*D3)-1;
            S3=sin(idx(u)*D3);    
            t_IMU3(u,:)=L3/(D3^2)*[Dx3*C3;...
                                Dy3*C3;...
                                D3*S3];
                     
            t_IMU3(u,:)=[[t_IMU2(20,1);t_IMU2(20,2);t_IMU2(20,3)]+R01*R12*t_IMU3(u,:)']';                
            end              
            
            
            

            plot3(t_IMU1(:,1),t_IMU1(:,2),t_IMU1(:,3),'r','linewidth',2)
            ee1=[t_IMU1(20,1),t_IMU1(20,2),t_IMU1(20,3)];
            
            plot3(t_IMU2(:,1),t_IMU2(:,2),t_IMU2(:,3),'color',[0.8500, 0.3250, 0.0980],'linewidth',2)
            ee2=[t_IMU2(20,1),t_IMU2(20,2),t_IMU2(20,3)];
            
            plot3(t_IMU3(:,1),t_IMU3(:,2),t_IMU3(:,3),'color',[0.9290, 0.6940, 0.1250],'linewidth',2)
            ee3=[t_IMU3(20,1),t_IMU3(20,2),t_IMU3(20,3)];
            
            
            x_MC=arrow3(ee1,ee1+R01(:,1)'./10,'k',1,1);
            y_MC=arrow3(ee1,ee1+R01(:,2)'./10,'k',1,1);
            z_MC=arrow3(ee1,ee1+R01(:,3)'./10,'m',1,1);
            x_2=arrow3(ee2,ee2+R2(:,1)'./10,'k',1,1); % is R2 the general 
            y_2=arrow3(ee2,ee2+R2(:,2)'./10,'k',1,1);
            z_2=arrow3(ee2,ee2+R2(:,3)'./10,'m',1,1);
            
            x_3=arrow3(ee3,ee3+R3(:,1)'./10,'k',1,1);
            y_3=arrow3(ee3,ee3+R3(:,2)'./10,'k',1,1);
            z_3=arrow3(ee3,ee3+R3(:,3)'./10,'m',1,1);
            set(gca,'FontSize',22);

            xlim([-0.7,0.7]);
            ylim([-0.7,0.7]);
            zlim([-0,0.9]);  
            
set(gca,'zdir','reverse')
subplot(1,2,2) 
hold on 
plot3(t_IMU2(:,1),t_IMU2(:,2),t_IMU2(:,3),'color',[0.8500, 0.3250, 0.0980],'linewidth',2)
plot3(t_IMU1(:,1),t_IMU1(:,2),t_IMU1(:,3),'r','linewidth',2)
        x_MC=arrow3(ee1,ee1+R01(:,1)'./10,'k',1,1);
        y_MC=arrow3(ee1,ee1+R01(:,2)'./10,'k',1,1);
        z_MC=arrow3(ee1,ee1+R01(:,3)'./10,'m',1,1);
        x_2=arrow3(ee2,ee2+R2(:,1)'./10,'k',1,1);
        y_2=arrow3(ee2,ee2+R2(:,2)'./10,'k',1,1);
        z_2=arrow3(ee2,ee2+R2(:,3)'./10,'m',1,1);
        x_3=arrow3(ee3,ee3+R3(:,1)'./10,'k',1,1);
        y_3=arrow3(ee3,ee3+R3(:,2)'./10,'k',1,1);
        z_3=arrow3(ee3,ee3+R3(:,3)'./10,'m',1,1);

            xlim([-0.7,0.7]);
            ylim([-0.7,0.7]);
            zlim([-0,0.9]);
        
            view(0,90)
            
            
end
                  