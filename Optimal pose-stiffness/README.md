## Code structure
In order to obtain the result, run the [ga_main.m](https://github.com/fstella97/SoftManipulator/blob/main/Optimal%20pose-stiffness/ga_main.m).

The structure of the code is organized as: 
* in [ga_main.m](https://github.com/fstella97/SoftManipulator/blob/main/Optimal%20pose-stiffness/ga_main.m).
 the goal position and stiffness are defined and the genetic algorithm is called.
* in [simple_fitness.m](https://github.com/fstella97/SoftManipulator/blob/main/Optimal%20pose-stiffness/simple_fitness.m) the function to optimize is defined. This is composed of multiple subfunctions (e.g. manifold projection), stored in the Utilities folder.
