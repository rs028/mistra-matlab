function [kb] = kBimol (kpar,T)
%% ---------------------------------------------------------------------
%% function to calculate the rate coefficient of a bimolecular reaction
%% using one of the alternative forms:
%%  -> no T-dependence    :  A
%%  -> standard Arrhenius :  A exp(-Ea/RT)
%%  -> non-Arrhenius      :  A (T/T0)^n
%%  -> expanded Arrhenius :  A (T/T0)^n exp(-Ea/RT)
%%
%% the kinetic parameters are:
%%   A  = pre-exponential factor (cm3 molecule-1 s-1) OR
%%        rate coefficient with no T-dependence
%%   Tz = reference temperature (Kelvin)
%%   n  = exponent for non-Arrhenius and expanded Arrhenius forms
%%   B  = -Ea/R (Ea in J mol-1; R in J K-1 mol-1)
%%
%% input:
%%       kpar = row/column vector of kinetic parameters
%%       T = temperature (Kelvin)
%%
%% output:
%%        kb = rate coefficient (cm3 molecule-1 s-1)
%%
%% version 2.2, november 2012
%% author: R.S.
%% ---------------------------------------------------------------------

  %% size of kinetic parameters vector
  krow = size(kpar,1);
  kcol = size(kpar,2);
  if (krow > kcol)
    klen = krow;
  else
    klen = kcol;
  end

  %% kinetic parameters vector must be one-dimensional
  if (krow == 1 || kcol == 1)

    %% calculate bimolecular rate coefficient
    switch (klen)
        %% no T-dependence
      case 1
        A  = kpar(1);
        kb = A;
        %% standard Arrhenius
      case 2
        A  = kpar(1);
        B  = kpar(2);
        kb = A.*exp(B./T);
        %% non-Arrhenius
      case 3
        A  = kpar(1);
        Tz = kpar(2);
        n  = kpar(3);
        kb = A.*((T./Tz).^n);
        %% expanded Arrhenius
      case 4
        A  = kpar(1);
        Tz = kpar(2);
        n  = kpar(3);
        B  = kpar(4);
        kb = A.*((T./Tz).^n).*exp(B./T);
      otherwise
        fprintf ('\nINVALID INPUT\n');
    end

  else
    fprintf ('\nINVALID INPUT\n');
  end

end
