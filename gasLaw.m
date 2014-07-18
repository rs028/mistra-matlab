function [X] = gasLaw (n,V,T,P)
%% ---------------------------------------------------------------------
%% function to solve the equation of state of a gas using the ideal gas
%% law:
%%     PV = nRT
%%
%% input ("?" for unknown variable):
%%       n = number of moles (mol = n. molecule/Na)
%%       V = volume (m3 = 1000 L)
%%       T = temperature (Kelvin)
%%       P = pressure (Pascal)
%%
%% output:
%%        X = unknown variable
%%
%% version 1.2, november 2010
%% author: R.S.
%% ---------------------------------------------------------------------

  %% physical constants
  R = physConst('R');  % ideal gas constant (J K-1 mol-1)

  %% calculate the missing variable
  if (strcmp(n,'?') == 1)      % n. moles (mol)
    X = P.*V./(R*T);
  elseif (strcmp(V,'?') == 1)  % volume (m3)
    X = n.*(R*T)./P;
  elseif (strcmp(T,'?') == 1)  % temperature (K)
    X = P.*V./(n*R);
  elseif (strcmp(P,'?') == 1)  % pressure (P)
    X = n.*(R*T)./V;
  end

end
