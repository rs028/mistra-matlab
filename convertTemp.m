function [datout] = convertTemp (datin,unin,unout)
%% ---------------------------------------------------------------------
%% function to convert between units of temperature.
%% supported units are:
%% -> Kelvin     ("K")
%% -> Celsius    ("C")
%% -> Fahreneit  ("F")
%%
%% input:
%%       datin = data in original unit of temperature
%%       unin = original unit of temperature
%%       unout = final unit of temperature
%%
%% output:
%%        datout = data in final unit of temperature
%%
%% version 1.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% convert original unit to base unit (Kelvin)
  switch (unin)
    case 'K'
      datbase = datin;
    case 'C'
      datbase = datin + 273.15;
    case 'F'
      datbase = (datin + 459.67).*5/9;
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% convert base unit (Kelvin) to final unit
  switch (unout)
    case 'K'
      datout = datbase;
    case 'C'
      datout = datbase - 273.15;
    case 'F'
      datout = (datbase.*9/5) - 459.67;
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

end
