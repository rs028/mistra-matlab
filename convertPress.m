function [datout] = convertPress (datin,unin,unout)
%% ---------------------------------------------------------------------
%% function to convert between units of pressure.
%% supported units are:
%% -> pascal       ("Pa")
%% -> hectopascal  ("hPa")
%% -> kilopascal   ("kPa")
%% -> atmosphere   ("atm")
%% -> torr = mmHg  ("torr")
%% -> bar          ("bar")
%% -> millibar     ("mbar")
%%
%% input:
%%       datin = data in original unit of pressure
%%       unin = original unit of pressure
%%       unout = final unit of pressure
%%
%% output:
%%        datout = data in final unit of pressure
%%
%% version 1.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% convert original unit to base unit (pascal)
  switch (unin)
    case 'Pa'
      datbase = datin;
    case 'hPa'
      datbase = datin.*1.0e+02;
    case 'kPa'
      datbase = datin.*1.0e+03;
    case 'atm'
      datbase = datin.*1.01325e+05;
    case 'torr'
      datbase = datin.*133.322;
    case 'bar'
      datbase = datin.*1.0e+05;
    case 'mbar'
      datbase = datin.*1.0e+02;
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% convert base unit (pascal) to final unit
  switch (unout)
    case 'Pa'
      datout = datbase;
    case 'hPa'
      datout = datbase./1.0e+02;
    case 'kPa'
      datout = datbase./1.0e+03;
    case 'atm'
      datout = datbase./1.01325e+05;
    case 'torr'
      datout = datbase./133.322;
    case 'bar'
      datout = datbase./1.0e+05;
    case 'mbar'
      datout = datbase./1.0e+02;
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

end
