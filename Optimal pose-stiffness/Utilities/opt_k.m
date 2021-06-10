function [K_opt,x_quadprog]=opt_k(q,goal_compliance)
global goal

H=A_evaluator(q',goal_compliance);
f=b_evaluator(q',goal_compliance);

%constraints of the compliances
k_min=1;%In reality we can achieve 0.01N/m% base stiffness of the chamber
k_max=1.5;% in reality we can  get to 0.09N/m%k_min*2;% inflated stiffness of the chamber

A=[];
b=[];
Aeq=[1,-1,0,0,0,0;0,0,1,-1,0,0;0,0,0,0,-1,1;];
beq=[0;0;0];
lb=[k_min,k_min,k_min,k_min,k_min,k_min];
ub=[+k_max,k_max,k_max,k_max,k_max,k_max];
%solution of optimal compliance
options = optimoptions(@quadprog,'Display','off');
x_quadprog = quadprog(H,f,A,b,Aeq,beq,lb,ub,[],options);

%plotting ellipses
% K_desired=(inv(diag(goal_compliance)));
J_end=J_evaluator(q');
diag(x_quadprog);
K_opt=J_end*diag(x_quadprog)*J_end';
% figure(1)
% hold on 
% my_ellips(goal',K_opt,1,[0.3010 0.7450 0.9330])
% my_ellips(goal',K_desired,1,[0.4660 0.6740 0.1880])
end
