function cost=Frob_norm(Copt)
global Cgoal
cost=0;
for i=1:length(Cgoal(1,:))
    for j=1:length(Cgoal(:,1))
        if j>=i
        cost= cost+(Copt(i,j)-Cgoal(i,j))^2;
        end
    end
end
  