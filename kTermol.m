function [kt] = kTermol (kparL,kparH,param,T,P)
%% ---------------------------------------------------------------------
%% function to calculate the rate coefficient of a termolecular reaction
%% using the Lindemann-Hinshelwood expression:
%%
%%    k = F (kzero kinf)/(kzero+kinf)
%%
%% F is the broadening factor calculated from Fc in the IUPAC
%% parameterization OR set to 0.6 in the JPL parameterization kzero and
%% kinf are the low-pressure limit and high-pressure limit rate
%% coefficients calculated as bimolecular processes
%%
%% ==> see documentation of kBimol.m <==
%%
%% input:
%%       kparL = row/column vector of kinetic parameters (low-P limit)
%%       kparH = row/column vector of kinetic parameters (high-P limit)
%%       param = string with Fc value (in IUPAC parameterization) OR
%%               "jpl" (in JPL parameterization)
%%       T = temperature (Kelvin)
%%       P = pressure (Pascal)
%%
%% output:
%%        kt = rate coefficient (cm3 molecule-1 s-1)
%%
%% version 2.2, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% air concentration
  M = airND (T,P);    % air molecule cm-3

  %% rate coefficients at low-P limit and high-P limit
  kzero = kBimol (kparL,T);
  kinf = kBimol (kparH,T);
  kr = (kzero.*M)./kinf;

  %% set Fc and N values
  if (ischar(param) == 1)
    %% JPL parameterization
    if (strcmp(param,'jpl') == 1)
      Fc = 0.6;
      N = 1;
     %% IUPAC parameterization
    else
      Fc = str2num(param);
      N = 0.75 - 1.27*log10(Fc);
    end
    %% exit if input not valid
  else
    kt = [];
    fprintf ('\nINVALID INPUT\n');
    return;
  end

  %% calculate broadening factor
  ff = (log10(kr)./N).^2;
  F = 10.^(log10(Fc)./(1+ff));

  %% calculate termolecular rate coefficient
  kt = F.*kinf.*(kr./(1+kr));

end
