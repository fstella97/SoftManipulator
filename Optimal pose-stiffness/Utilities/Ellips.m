function Ellips(K,figureidx,colorRGB)
global goal; 
r=1;
theta=linspace(-pi/2,pi/2,30);
phi=linspace(-pi,pi,30);
for i=1:length(theta)
    for u=1:length(phi)
        x(i,u)=r*cos(theta(i)).*cos(phi(u));
        y(i,u)=r*cos(theta(i)).*sin(phi(u));
        z(i,u)=r*sin(theta(i));
        
        a=[K*[x(i,u);y(i,u);z(i,u)]]'./5;%./3 to make it fit in the picture 
        x(i,u)=goal(1)+a(1);y(i,u)=goal(2)+a(2);z(i,u)=goal(3)+a(3);
    end
end

figure(figureidx)
hold on 
hSurface=surf(x,y,z);
set(hSurface,'FaceColor',colorRGB, 'EdgeAlpha',0.3,...
      'FaceAlpha',0.3,'FaceLighting','gouraud')
daspect([1 1 1])
view(20,20)
