function ee=plot_DxDy(Dx,Dy,L,R)
figure(1)
clf
subplot(1,2,1)
axis equal
            xlim([-0.3,0.3]);
            ylim([-0.3,0.3]);
            zlim([-0,0.3]);

view(-20,30)

hold on 
D=sqrt(Dx^2+Dy^2);
            idx=linspace(0,1,20);
            for u=1:length(idx)
            C1=cos(idx(u)*D)-1;
            S1=sin(idx(u)*D);    
            t_IMU(u,:)=L/(D^2)*[Dx*C1;...
                                Dy*C1;...
                                D*S1];
            end

            plot3(t_IMU(:,1),t_IMU(:,2),t_IMU(:,3),'r','linewidth',2)
        
            ee=[t_IMU(20,1),t_IMU(20,2),t_IMU(20,3)];
            x_MC=arrow3(ee,ee+R(:,1)'./10,'k',1,1);
            y_MC=arrow3(ee,ee+R(:,2)'./10,'k',1,1);
            z_MC=arrow3(ee,ee+R(:,3)'./10,'m',1,1);
            set(gca,'FontSize',22);

set(gca,'zdir','reverse')
            
subplot(1,2,2) 
hold on 
            plot3(t_IMU(:,1),t_IMU(:,2),t_IMU(:,3),'r','linewidth',2)
        x_MC=arrow3(ee,ee+R(:,1)'./10,'k',1,1);
        y_MC=arrow3(ee,ee+R(:,2)'./10,'k',1,1);
        z_MC=arrow3(ee,ee+R(:,3)'./10,'m',1,1);

            xlim([-0.3,0.3]);
            ylim([-0.3,0.3]);
            zlim([-0,0.3]);
        
            view(0,90)
            
            
end
                  