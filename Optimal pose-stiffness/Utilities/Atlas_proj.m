function q_projected=Atlas_proj(q_u,epsilon,maxiteration,q)
q_projected=q; % in case it goes out it returns the starting point of the graph
q_m=q_u;
Psi=Psi_evaluator(q);% in Kingstop it puts q_u 
b=b_u(q_m,q_u,Psi);
for i=0:maxiteration
if norm(b)<epsilon
    function_evaluations=i;
    q_projected=q_m;
    break
else
    if q_m(1)<0 
        q_m(1)=0.1;
    end
    if q_m(3)<0 
        q_m(3)=0.1;
    end
    if q_m(5)<0 
        q_m(5)=0.1;
    end
    
    if q_m(1)>3*pi/2 
        q_m(1)=3*pi/2;
    end
    if q_m(3)>3*pi/2
        q_m(3)=3*pi/2;
    end
    if q_m(5)>pi*3/2  
        q_m(5)=pi*3/2;
    end
    
    q_m=q_m-inv(A_u(q_m,Psi))*b;
    b=b_u(q_m,q_u,Psi);  
    
    if q_m(3)<4 
        q_m(3)=4;
    end
end
end
end
