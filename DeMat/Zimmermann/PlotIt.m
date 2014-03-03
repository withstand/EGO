%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:         PlotIt(FVr_temp,iter,S_struct)
% Author:           Rainer Storn
% Description:      PlotIt can be used for special purpose plots
%                   used in deopt.m.
% Parameters:       FVr_temp     (I)    Paramter vector
%                   iter         (I)    counter for optimization iterations
%                   S_Struct     (I)    Contains a variety of parameters.
%                                       For details see Rundeopt.m
% Return value:     -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotIt(FVr_temp,iter,S_struct)
  %----Convergence plot--------------------------------------------
  S_MSE = objfun(S_struct.FVr_bestmem,S_struct);
  plot(iter,S_MSE.FVr_oa(1),'ro');
  title(sprintf('Best cost: %f',S_MSE.FVr_oa(1)));
  axis([1 S_struct.I_itermax S_struct.F_VTR 2]);
  grid on;
  hold on;
  
  
drawnow;
pause(1); %wait for one second to allow convenient viewing
return
