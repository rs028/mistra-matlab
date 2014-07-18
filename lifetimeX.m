function [tau,half] = lifetimeX (k,X)
%% ---------------------------------------------------------------------
%% function to calculate the chemical lifetime and half-time of a
%% species.
%% -> first-order loss process ("1st")
%% -> second-order loss to typical atmospheric concentrations
%%     OH = 1x10^6 molecule cm-3
%%     NO3 = 10 ppt
%%     O3 = 80 ppb
%% -> second-order loss to a reactant of given concentration
%%
%% input:
%%       k = rate coefficient
%%       reacX = string with reactant name ("OH", "NO3", "O3") OR
%%               "1st" (if first-order process) OR
%%               string with concentration in molecule cm-3
%%
%% output:
%%        tau = chemical lifetime (seconds)
%%        half = chemical half-time (seconds)
%%
%% version 1.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% set concentration of reactant
  if (ischar(X) == 1)
    switch (X)
        %% first-order process
      case '1st'
        Cx = 1;
        %% OH = 1x10^6 molecule cm-3
      case 'OH'
        Cx = 1.00e+06;
        %% NO3 = 10 ppt
      case 'NO3'
        Cx = 2.50e+08;
        %% O3 = 80 ppb
      case 'O3'
        Cx = 1.97e+12;
        %% concentration of reactant (in molecule cm-3)
      otherwise
        Cx = str2num(X);
    end
    %% exit if input not valid
  else
    tau = []; half = [];
    fprintf ('\nINVALID INPUT\n');
    return;
  end

  %% calculate lifetime and half-time (in seconds)
  kp = k.*Cx;
  tau = 1./kp;
  half = tau.*log(2);

end
