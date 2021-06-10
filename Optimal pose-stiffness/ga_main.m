clc
clear all 
close all 

addpath('./Utilities')
global goal
global Cgoal pressure
goal=[-0.1,0.1,0.55];
Cgoal=[7,7,0.7];
Kgoal=diag(1./Cgoal);
FitnessFunction = @simple_fitness;
numberOfVariables = 6;
lb = [0.001,-Inf,0.001,-Inf,0.001,-Inf];
ub = [pi,Inf,pi,Inf,pi,Inf];
options = optimoptions('ga','PlotFcn','gaplotbestf');
[q_opt,fval] = ga(FitnessFunction,numberOfVariables,[],[],[],[],lb,ub,[],options);

 q_opt=proj3s(q_opt',goal,0.005,1800)
%%
close all 
figure(1)
hold on 
plot_cylinder_bend(q_opt,pressure,1)
scatter3(goal(1),goal(2),goal(3),'filled','g')
Ellips(opt_k_L(q_opt,Cgoal),1,[0.3010 0.7450 0.9330])
Ellips(Kgoal,1,[0.4660 0.6740 0.1880])