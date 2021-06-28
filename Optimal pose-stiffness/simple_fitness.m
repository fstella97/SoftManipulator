function ellips_Froib = simple_fitness(q)
global goal Cgoal Kgoal error
global pressure q_opt K_opt
  q_onmanifold=proj3s(q',goal,0.01,2000);
  K_optimized=opt_k_L(q_onmanifold,Cgoal);
  ellips_Froib = Frob_norm(K_optimized,Kgoal);
  if ellips_Froib<error
      error=ellips_Froib
      q_opt=q_onmanifold;
      K_opt=K_optimized;
  end
  
  % given the position q and the goal, proj3s returns the position on the
  % manifold. Hence opt_k_L finds the optimal stiffness for that
  % configuration. Finally, given the optimal stiffness the Frobenius difference
  % to Kgoal is computed with Frob_diff 