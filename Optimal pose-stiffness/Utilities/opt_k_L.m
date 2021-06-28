function [K_opt,x_quadprog_bend]=opt_k_L(q,goal_compliance)
global goal pressure
q_L=[q(1),q(2),0.21,q(3),q(4),0.21,q(5),q(6),0.21]';

H=A_evaluator_variableL(q_L',goal_compliance);
f=b_evaluator_variableL(q_L',goal_compliance);

%constraints of the compliances
k_min=0;%N/m% base stiffness of the chamber
k_max=Inf;%1.5%0.019;%N/m%k_min*2;% inflated stiffness of the chamber
k_l=1.5;
A=[];
b=[];
Aeq=[0,0,1,0,0,0,0,0,0;0,0,0,0,0,1,0,0,0;0,0,0,0,0,0,0,0,1;1,-1,0,0,0,0,0,0,0;0,0,0,1,-1,0,0,0,0;0,0,0,0,0,0,1,-1,0];
beq=[k_l;k_l;k_l;0;0;0];
lb=[k_min,k_min,0,k_min,k_min,0,k_min,k_min,0];
ub=[+k_max,k_max,Inf,k_max,k_max,Inf,k_max,k_max,Inf];
%solution of optimal compliance
options = optimoptions(@quadprog,'Display','off');
x_quadprog = quadprog(H,f,A,b,Aeq,beq,lb,ub,[],options);

%plotting ellipses
% K_desired=(inv(diag(goal_compliance)));
J_end=J_evaluator_variableL(q_L');
K_opt=J_end*diag(x_quadprog)*J_end';
x_quadprog_bend=[x_quadprog(1),x_quadprog(2),x_quadprog(4),x_quadprog(5),x_quadprog(7),x_quadprog(8)]';
pressure=x_quadprog_bend;
% figure(1)
% hold on 
% my_ellips(goal',K_opt,1,[0.3010 0.7450 0.9330])
% my_ellips(goal',K_desired,1,[0.4660 0.6740 0.1880])
end
