function [OH] = ehhaltOH (jNO2,jO3,NO2)
%% ---------------------------------------------------------------------
%% function to calculate the concentration of OH using an empirical
%% parametrization from Ehhalt and Rohrer, JGR, 2000.
%%
%% NB: this parametrization was developed from measurements taken under
%%     rural, relatively unpolluted conditions in North-Eastern Germany.
%%     It may not be reliable under different conditions!
%%
%% input:
%%       jNO2 = NO2 photolysis rate (s-1)
%%       jO3 = O3 photolysis rate (s-1)
%%       NO2 = NO2 concentration (ppb)
%%
%% output:
%%        OH = concentration of OH (molecule cm-3)
%%
%% version 1.0, december 2008
%% author: R.S.
%% ---------------------------------------------------------------------

  %% empirical parameters
  alfa = 0.83;
  beta = 0.19;
  a = 4.1e+09;
  b = 140.0;
  c = 0.41;
  d = 1.7;

  %% calculate OH concentration
  OH = a*(jO3.^alfa).*(jNO2.^beta).*(b*NO2 + 1.0) ./ ...
      (c*NO2.^2 + d*NO2 + 1.0);

end
