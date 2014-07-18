function [datout] = convertConc_gas (datin,unin,unout,T,P)
%% ---------------------------------------------------------------------
%% function to convert between units of concentration (gas-phase).
%% supported units are:
%% -> molecule cm-3  ("ND")
%% -> ppth           ("ppth")
%% -> ppm            ("ppm")
%% -> ppb            ("ppb")
%% -> ppt            ("ppt")
%% -> mole m-3       ("MD")
%%
%% input:
%%       datin = data in original unit of concentration
%%       unin = original unit of concentration
%%       unout = final unit of concentration
%%       T = temperature (Kelvin)
%%       P = pressure (Pascal)
%%
%% output:
%%        datout = data in final unit of concentration
%%
%% version 2.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% Avogadro number
  Na = physConst ('Na');

  %% air concentration
  M = airND (T,P);    % air molecule cm-3

  %% convert original unit to base unit (molecule cm-3)
  switch (unin)
    case 'ND'
      datbase = datin;
    case 'ppth'
      datbase = datin.*(M*1.0e-03);
    case 'ppm'
      datbase = datin.*(M*1.0e-06);
    case 'ppb'
      datbase = datin.*(M*1.0e-09);
    case 'ppt'
      datbase = datin.*(M*1.0e-12);
    case 'MD'
      datbase = datin.*(Na*1.0e-06);
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% convert base unit (molecule cm-3) to final unit
  switch (unout)
    case 'ND'
      datout = datbase;
    case 'ppth'
      datout = datbase./(M*1.0e-03);
    case 'ppm'
      datout = datbase./(M*1.0e-06);
    case 'ppb'
      datout = datbase./(M*1.0e-09);
    case 'ppt'
      datout = datbase./(M*1.0e-12);
    case 'MD'
      datout = datbase./(Na*1.0e-06);
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

end
