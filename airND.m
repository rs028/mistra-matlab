function [M] = airND (T,P)
%% ---------------------------------------------------------------------
%% function to calculate the number density of air at given temperature
%% and pressure.
%%
%% input:
%%       T = temperature (Kelvin)
%%       P = pressure (Pascal)
%%
%% output:
%%        M = air number density (molecule cm-3)
%%
%% version 1.1, november 2010
%% author: R.S.
%% ---------------------------------------------------------------------

  %% physical constants
  R = physConst('R');    % ideal gas constant (J K-1 mol-1)
  Na = physConst('Na');  % Avogadro number

  %% calculate M
  M = 1e-6*(Na*P)./(R*T);

end
