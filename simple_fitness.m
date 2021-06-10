function ellips_Froib = simple_fitness(q)
global goal
global Cgoal pressure
  ellips_Froib = Frob_norm(opt_k_L(proj3s(q',goal,0.005,1800),Cgoal));
  % given the position q and the goal, proj3s returns the position on the
  % manifold. Hence opt_k_L finds the optimal stiffness for that
  % configuration. Finally, given the optimal stiffness the Frobenius difference
  %to Kgoal is computed with Frob_diff 