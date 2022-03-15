function [timeout] = ut_readtime (timein,fmtin,fmtout,startd,refd)
%% ---------------------------------------------------------------------
%% function to convert a vector of time between different time formats.
%% supported time formats are:
%% -> "sec0" : seconds since start date
%% -> "sec1" : seconds since start date
%% -> "day0" : fractional days since start date (1st day = 0)
%% -> "day1" : fractional days since start date (1st day = 1)
%% -> "jday" : fractional days since 1 January of start date year
%%
%% input:
%%       timein = vector of time in original format
%%       fmtin = original format of time
%%       fmtout = final format of time
%%       startd = start date in vector format: [Y, M, D]
%%       refd = reference date in vector format: [Y, M, D]
%%
%% output:
%%        timeout = vector of time in final format
%%
%% version 0.9, november 2012
%% author: R.S.
%% ---------------------------------------------------------------------

  %% set start date, reference date and 1 January of start date year
  stdate = datenum(startd);
  refdate = datenum(refd);
  styear = datenum([startd(1),1,1]);

  %% convert to fractional days since 1 January of start date year
  switch (fmtin)
      %% seconds since reference date (1st day = 0)
    case 'sec0'
      timebase = timein./86400 - (styear - refdate) + 1;
      %% seconds since reference date (1st day = 1)
    case 'sec1'
      timebase = timein./86400 - (styear - refdate);
      %% fractional days since reference date (1st day = 0)
    case 'day0'
      timebase = timein - (styear - refdate) + 1;
      %% fractional days since reference date (1st day = 1)
    case 'day1'
      timebase = timein - (styear - refdate);
      %% fractional days since 1 January of the start date year
    case 'jday'
      timebase = timein;
  end

  %% time in final format
  timeout = timebase;

end
