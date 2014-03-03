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
%----First of four subplots.---------------------------------------
  subplot(2,2,1);
  %----Define the mesh of samples----------------------------------
  mesh(S_struct.FM_meshd);
  
  %---Either plot the contour lines and population-----------------
  FVr_conts = exp(1:0.5:10);
  contour(S_struct.FVc_xx,S_struct.FVc_yy,S_struct.FM_meshd,FVr_conts);
  title('Rosenbrock saddle');
  hold on;%keep the contour lines
  plot(S_struct.FM_pop(:,1),S_struct.FM_pop(:,2),'ro');
  hold off;

  %---Or plot rosenbrock saddle and population in 3D---------------
  subplot(2,2,2);
  surf(S_struct.FVc_xx,S_struct.FVc_yy,(S_struct.FM_meshd));
  axis([-3 3 -3 3 0 550]);
  view(-15,80);
  title('Rosenbrock saddle');
  hold on;
  plot3(S_struct.FM_pop(:,1),S_struct.FM_pop(:,2),...
     (100.*(S_struct.FM_pop(:,2)-S_struct.FM_pop(:,1).*S_struct.FM_pop(:,1)).^2+...
     (1-S_struct.FM_pop(:,1)).^2),'r.');
  hold off;
  
  %----Convergence plot--------------------------------------------
  subplot(2,2,3);
  S_MSE = objfun(S_struct.FVr_bestmem,S_struct);
  semilogy(iter,S_MSE.FVr_oa(1),'ro');
  title(sprintf('Best cost: %f',S_MSE.FVr_oa(1)));
  axis([1 S_struct.I_itermax S_struct.F_VTR 1]);
  grid on;
  hold on;
  
  %----Difference vector distribution plot-------------------------
  subplot(2,2,4)
  hold off;
  FM3D = ones(S_struct.I_NP,S_struct.I_NP,2);
  for i=1:S_struct.I_NP
     for j=1:S_struct.I_NP
        FM3D(i,j,:) = S_struct.FM_pop(i,:);
        for k=1:2
           FM3D(i,j,k) = FM3D(i,j,k) - S_struct.FM_pop(j,k);
        end
        plot(FM3D(i,j,1),FM3D(i,j,2),'r.');
        axis([-5,5,-5,5]);
        hold on;
     end     
     title('Difference vector distribution');
     grid on;
     zoom on;
  end
  
  drawnow;
  pause(1); %wait for one second to allow convenient viewing
  return
