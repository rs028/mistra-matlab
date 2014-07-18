function [datout] = convertAngle (datin,unin,unout)
%% ---------------------------------------------------------------------
%% function to convert between units of angle.
%% supported units are:
%% -> radian  ("rad")
%% -> degree  ("deg")
%%
%% input:
%%       datin = data in original unit of angle
%%       unin = original unit of angle
%%       unout = final unit of angle
%%
%% output:
%%        datout = data in final unit of angle
%%
%% version 1.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% convert original unit to base unit (radians)
  switch (unin)
    case 'rad'
      datbase = datin;
    case 'deg'
      datbase = datin.*(pi/180);
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% convert base unit (radians) to final unit
  switch (unout)
    case 'rad'
      datout = datbase;
    case 'deg'
      datout = datbase./(pi/180);
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

end
