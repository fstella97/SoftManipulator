clc
clear all 
close all 

addpath('./Utilities')
global goal Cgoal Cgoal_matr Kgoal Kgoal_diag K_opt
global q_opt pressure Kopt error
error=10000;
result=[];
axis1= linspace(0.2,0.45,11)
axis2= linspace(0.2,0.45,11)
%for i=1:length(axis1)
 %   for j=1:length(axis2)
   
goal=[0,0.2,0.3]
Cgoal=[1.7,0.6,1.7]*2;
Cgoal_matr=diag(Cgoal);
Kgoal=diag(1./Cgoal);
Kgoal_diag=1./Cgoal;
FitnessFunction = @simple_fitness;
numberOfVariables = 6;
lb = [0.001,-Inf,0.001,-Inf,0.001,-Inf];
ub = [2*pi,Inf,2*pi,Inf,2*pi,Inf];
options = optimoptions('ga','PlotFcn','gaplotbestf');
%%
[x,fval] = ga(FitnessFunction,numberOfVariables,[],[],[],[],lb,ub,[],options);

%result(i,j)=fval
    
    
%    end
%end
%%
% figure(3)
% surf(spacey(length(spacey)/2:end),spacez(length(spacez)/2:end),result(length(spacey)/2:end,length(spacez)/2:end))
% figure(4)
% plot_heatmap(2,result,Kgoal)
% q_opt
% pressure
%%
close all 
figure(1)
hold on 
plot_cylinder_bend(q_opt,pressure,1)
scatter3(goal(1),goal(2),goal(3),'filled','g')
Ellips(K_opt,1,[0.3010 0.7450 0.9330])
Ellips(Kgoal,1,[0.4660 0.6740 0.1880])