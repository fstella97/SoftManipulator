function cost=Frob_norm(Kopt,Kgoal)
cost=0;
for i=1:length(Kgoal(1,:))
    for j=1:length(Kgoal(:,1))
        if j>=i
        cost= cost+sqrt((Kopt(i,j)-Kgoal(i,j))^2);
        diff(i,j)=sqrt((Kopt(i,j)-Kgoal(i,j))^2);
        end
    end
end
  %disp(diff)
  