function [datout] = convertTime (datin,unin,unout)
%% ---------------------------------------------------------------------
%% function to convert between units of time.
%% supported units are:
%% -> second  ("sec")
%% -> minute  ("min")
%% -> hour    ("hour")
%% -> day     ("day")
%%
%% input:
%%       datin = data in original unit of time
%%       unin = original unit of time
%%       unout = final unit of time
%%
%% output:
%%        datout = data in final unit of time
%%
%% version 1.1, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% convert original unit to base unit (seconds)
  switch (unin)
    case 'sec'
      datbase = datin;
    case 'min'
      datbase = datin.*60;
    case 'hour'
      datbase = datin.*3600;
    case 'day'
      datbase = datin.*86400;
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% convert base unit (seconds) to final unit
  switch (unout)
    case 'sec'
      datout = datbase;
    case 'min'
      datout = datbase./60;
    case 'hour'
      datout = datbase./3600;
    case 'day'
      datout = datbase./86400;
    otherwise
      datout = [];
      fprintf ('\nINVALID INPUT\n');
      return;
  end

end
