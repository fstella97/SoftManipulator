function b=b_u(q_m,q_u,Psi)
global goal
% q_m
% q_u
b=[constraint3s_error(q_m')';Psi'*(q_m-q_u)];
end
    

