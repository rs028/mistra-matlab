function [fO1D] = fractionO1D (H2O,T,P)
%% ---------------------------------------------------------------------
%% function to calculate the fraction of O1D reacting with water vapour
%% to form OH rather than being quenched by collision with O2, N2.
%% kinetic parameters from Ravishankara et al., GRL, 2002.
%%
%% input:
%%       H2O = water vapour (molecule cm-3)
%%       T = temperature (Kelvin)
%%       P = pressure (Pascal)
%%
%% output:
%%        fO1D = fraction of O1D forming OH
%%
%% version 1.1, december 2010
%% author: R.S.
%% ---------------------------------------------------------------------

  %% air concentration and composition
  M = airND (T,P);  % air molecule cm-3
  O2 = 0.21*M;
  N2 = 0.78*M;

  %% calculate rate coefficients
  k1 = 2.20e-10;  % O1D + H2O = OH + OH
  k2a = kBimol ([3.2e-11, 67.0],T).*O2;  % O1D + O2 = O3P + O2
  k2b = kBimol ([2.1e-11,115.0],T).*N2;  % O1D + N2 = O3P + N2
  k2p = k2a + k2b;

  %% calculate fO1D
  fO1D = (k1.*H2O)./(k1.*H2O + k2p);

end
