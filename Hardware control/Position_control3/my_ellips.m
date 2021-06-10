function [x,y,z]=my_ellips(end_effector_pos,K_end,figureidx,color)
hor=circle([0,0],1);%[x,y]


circle1=[hor;zeros(length(hor(1,:)),1)'];%[x,y,z]
circle2=[hor(1,:);zeros(length(hor(1,:)),1)';hor(2,:)];%[x,y,z]
circle3=[zeros(length(hor(1,:)),1)';hor];
%from circles to ellipses
for i=1:length(hor(1,:))
    ell1(:,i)=end_effector_pos+K_end*circle1(:,i);
    ell2(:,i)=end_effector_pos+K_end*circle2(:,i);%[1,0,0;0,0,-1;0,1,0]*
    ell3(:,i)=end_effector_pos+K_end*circle3(:,i);
end

figure(figureidx)
hold on 
plot3(ell1(1,:),ell1(2,:),ell1(3,:),'Color',color,'linewidth',1.5)
plot3(ell2(1,:),ell2(2,:),ell2(3,:),'Color',color,'linewidth',1.5)
plot3(ell3(1,:),ell3(2,:),ell3(3,:),'Color',color,'linewidth',1.5)
end
