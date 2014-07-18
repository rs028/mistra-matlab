function [datamat] = plotNC_2d (fname,dvar,dbin,pl)
%% ---------------------------------------------------------------------
%% function to retrieve and plot the 2-dimensional field of a variable
%% from a netCDF file. the function is written for the netCDF files
%% generated by the MISTRA model (gas.nc, aq.nc, jrate.nc, meteo.nc). it
%% will work for other netCDF files with similar format.
%%
%% NB: time and altitude are expressed as timesteps and level numbers.
%% NB: the first timestep and level number are dropped.
%%
%% format of the netCDF file:
%%       variable(rec, n, y, x)
%%                rec = timesteps
%%                n = model level number (altitude)
%%                y = 1
%%                x = aerosol bin (= 1 for other variables)
%%
%% input:
%%       fname = name of the netCDF file
%%       dvar = dependent variable
%%       dbin = aerosol bin of dvar ("1" if dvar not in aerosol)
%%       pl = plot is required ("yes" OR "no")
%%
%% output:
%%        datamat = matrix of retrieved variable
%%                  (altitude in rows, time in cols)
%%        -> make plot (if required)
%%
%% version 1.2, march 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% convert input strings to integers
  dbin = str2num(dbin);

  %% open netCDF file
  fin = netcdf(fname,'r');

  %% set the X-axis and the Y-axis (drop first timestep/level number)
  n_rec = fin('rec');
  n_n = fin('n');
  xn = n_rec(:);
  yn = n_n(:);
  xax = [2:1:xn];
  yax = [2:1:yn]';

  %% set the Z-axis
  zax = fin{dvar}(2:xn,2:yn,1,dbin)';

  %% create a matrix with the 2D field of the retrieved variable
  datamat = [xax;zax];
  yyax = [nan;yax];
  datamat = [yyax,datamat];

  %% make plot
  if (strcmp(pl,'yes') == 1)
    figure
    contourf(xax,yax,zax), colorbar
    title ([dvar,' (bin ',num2str(dbin),')'])
    xlabel('time'), ylabel('altitude');
    %% no plot
  else
    fprintf ( ['>>>>> field of ', dvar, ' retrieved\n'] );
  end

end
