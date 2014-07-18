function [timemat,altmat,ptmat] = mistraGrid_1d (dname,fname,prof,sect)
%% ---------------------------------------------------------------------
%% function to retrieve time and altitude information of a model run and
%% a selected profile (horizontal or vertical) of pressure and
%% temperature. the function is written for the netCDF files generated
%% by the MISTRA model.
%% by default the model results are in the METEO.NC file.
%%
%% ==> see documentation of plotNC_xy.m <==
%%
%% input:
%%       dname = directory with netCDF file ("./" if it is in the
%%               current directory)
%%       fname = name of the netCDF file ("meteo.nc")
%%       prof = "horizontal" OR "vertical" profile of pressure and
%%              temperature
%%       sect = level number (if prof="horizontal") OR
%%              timestep (if prof="vertical") of pressure and
%%              temperature profile
%%
%% output:
%%        timemat = [timestep, day, hour, minute, fractional day]
%%        altmat = [level number, altitude]
%%        ptmat = [pressure, temperature] of selected profile
%%
%% version 1.4, february 2011
%% author: R.S.
%% ---------------------------------------------------------------------

  %% default file of model results: meteo.nc
  if (strcmp(fname,'') == 1)
    fname = 'meteo.nc';
  end

  %% get model results file
  if (strcmp(dname(1,end),'/') == 0)
    ncname = [dname,'/',fname];
  else
    ncname = [dname,fname];
  end

  %% get time information
  d_mat = plotNC_xy (ncname,'lday','1','time','1','horizontal','1','no');
  h_mat = plotNC_xy (ncname,'lst','1','time','1','horizontal','1','no');
  m_mat = plotNC_xy (ncname,'lmin','1','time','1','horizontal','1','no');

  %% calculate fractional day and assemble time matrix
  f_mat = d_mat(2,:) + h_mat(2,:)./24 + m_mat(2,:)./1440;
  timemat = [d_mat; h_mat(2,:); m_mat(2,:); f_mat];
  timemat(:,1) = nan;

  %% get altitude information
  altmat = plotNC_xy (ncname,'eta','1','altitude','1','vertical','2','no');
  altmat(1,:) = nan;

  %%  get pressure and temperature
  ptmat = plotNC_xy (ncname,'temp','1','p','1',prof,sect,'no');

end
