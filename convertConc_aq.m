function [datout] = convertConc_aq (datin,unin,unout,MW)
%% ---------------------------------------------------------------------
%% function to convert between units of concentration (aqueous-phase).
%% supported units are:
%% -> ug m-3    ("uGM")
%% -> ng m-3    ("nGM")
%% -> mole m-3  ("MD")
%%
%% input:
%%       datin = data in original unit of concentration
%%       unin = original unit of concentration
%%       unout = final unit of concentration
%%       MW = molecular weight (g/mole)
%%
%% output:
%%        datout = data in final unit of concentration
%%
%% version 1.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% convert original unit to base unit (ug m-3)
  switch (unin)
    case 'uGM'
      datbase = datin;
    case 'nGM'
      datbase = datin./1.0e+03;
    case 'MD'
      datbase = datin.*(MW/1.0e-06);
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% convert base unit (ug m-3) to final unit
  switch (unout)
    case 'uGM'
      datout = datbase;
    case 'nGM'
      datout = datbase.*1.0e+03;
    case 'MD'
      datout = datbase./(MW/1.0e-06);
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

end
