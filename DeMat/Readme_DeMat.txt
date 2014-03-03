From 

Price, K., Storn, R., Lampinen, J.,
Differential Evolution - A Practical Approach to Global Optimization
Springer, 2005

The default problem in this directory (main directory) is
the Chebyshev problem. If any of the other problems
shall be treated, go to the appropriate subdirectory
and copy the files objfun.m, PlotIt.m, and Rundeopt.m
to the main directory.

The script file Rundeopt.m (Run DE optimization) is
the main control file in the MATLAB ® environment.
Plotting can be turned off by setting the variable
I_plotting=0 in rundeopt.m. Per default this variable
is set to 1.

Various ways of plotting have been used for the
different examples. Only the two-dimensional
problems allow an animated view how the population
evolves on the objective function surface. Other
problems may simply use a progress plot for the
objective function value. It is best to try the
different examples to see how plotting has been
used to monitor the optimization.