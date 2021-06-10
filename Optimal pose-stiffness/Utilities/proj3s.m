function q_projected=proj3s(q,goal,epsilon,maxiteration)
q_projected=0; %if it returns 0 it didn't converged to the nullspace manifold
for i=0:maxiteration
    
Dx=constraint3s_error(q');% q has to be [q1c;q1a;q2c;q2a;q3c;q3a]
if norm(Dx)<epsilon
    function_evaluations=i;
    q_projected=q;
    break
else
    if q(1)<0 
        q(1)=0.1;
    end
    end
    if q(3)<0 
        q(3)=0.01;
    end
    if q(5)<0 
        q(5)=0.01;
    end
    
    
    if q(1)>3*pi/2 
        q(1)=3*pi/2;
    end
    if q(3)>3*pi/2  
        q(3)=3*pi/2;
    end
    if q(5)>pi*3/2  
        q(5)=pi*3/2;
    end
    
        
    J=J_evaluator(q');
    q=q-pinv(J)*Dx';
    
    
end
end
