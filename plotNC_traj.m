function [trajtim,trajmat,mapmat] = plotNC_traj (fname,fcoast,mp,pl)
%% ---------------------------------------------------------------------
%% function to retrieve and plot trajectories and related information.
%% the trajectories are calculated by ECMWF for five days backwards
%% (http://badc.nerc.ac.uk/data/ecmwf-trj/) at a certain time interval
%% (typically 6 hours). the trajectory files are in netCDF format and
%% include pressure, temperature and potential temperature.
%%
%% the trajectories are plotted using the map data from the
%% NOAA/National Geophysical Data Center World Coastlines and Lakes
%% 1:5,000,000 dataset (http://www.ngdc.noaa.gov/mgg_coastline/index.jsp
%%
%% NB: by default the map data are in the WCL.DAT file.
%%     other maps can be used if data are in the format:
%%     [longitude latitude] matrix in Matlab ASCII formatted file
%%
%% input:
%%       fname =  name of netCDF file
%%       fcoast =  name of file with map data ("WCL.dat")
%%       mp = load map file ("yes" OR "no")
%%       pl = plot is required ("map" OR "all" OR "no")
%%
%% output:
%%        trajtim = date vector with starting time + time interval (in
%%                  hours) of back-trajectory:
%%                    [yyyy mm dd HH MM SS h]
%%        trajmat = matrix with trajectory data (time in days,
%%                  latitude and longitude in degrees, pressure in hPa,
%%                  temperature and potential temperature in Kelvin)
%%        mapmat = matrix with map data (latitude and longitude
%%                 in degrees)
%%        -> make plot (if required)
%%
%% version 1.6, march 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% open netCDF file
  fin = netcdf(fname,'r');

  %% read content of the netCDF file
  time_t = fin{'time'}(:);
  lat_t = fin{'lat'}(:);
  long_t = fin{'lon'}(:);
  press_t = fin{'lev'}(:);
  temp_t = fin{'temp'}(:);
  theta_t = fin{'theta'}(:);

  %% read starting time and interval of trajectory
  time_str = fin.TrajectoryBaseTime();
  interval_str = fin.SourceTimeInterval();
  interval_str = strtrim(interval_str);

  %% convert starting time into a date vector
  %% add trajectory interval to the date vector
  year_str = time_str(1:4);
  month_str = time_str(5:6);
  day_str = time_str(7:8);
  hour_str = time_str(9:10);
  trajtim = datevec(time_str,'yyyymmddHH');
  if (size(ver('Octave'),1))
    int_str = strsplit(interval_str,' ',true);   % Octave command
  else
    int_str = regexp(interval_str,' ','split');  % Matlab command
  end
  int_hour = str2num(int_str{1});
  trajtim(7) = int_hour;

  %% convert time to days and pressure to hPa (mbar)
  time_t = time_t/86400;
  press_t = press_t/100;

  %% matrix with trajectory data
  trajmat = [time_t,lat_t,long_t,press_t,temp_t,theta_t];

  %% load map data
  if (strcmp(mp,'yes') == 1)
    if (strcmp(fcoast,'') == 1)
      coastline = load('WCL.dat');
    else
      coastline = load(fcoast);
    end
    long_c = coastline(:,1);
    lat_c = coastline(:,2);
    long1 = min(long_c);
    long2 = max(long_c);
    lat1 = min(lat_c);
    lat2 = max(lat_c);

    %% matrix with map data
    mapmat = [lat_c,long_c];
  else
    mapmat = [];
  end

  %% make plot
  tit_str = [day_str,'-',month_str,'-',year_str,' at ',hour_str,':00'];

  %% plot only map and trajectory
  if (strcmp(pl,'map') == 1)
    figure
    plot(long_c,lat_c,'k',long_t,lat_t,'b')
     axis([long1 long2 lat1 lat2]), grid('on')
     xlabel('latitude'), ylabel('longitude')
     title(tit_str)
  end

  %% plot map and trajectory + all other information
  if (strcmp(pl,'all') == 1)
    figure
    subplot(2,2,1)
    plot(long_c,lat_c,'k',long_t,lat_t,'b')
     axis([long1 long2 lat1 lat2]), grid('on')
     xlabel('latitude'), ylabel('longitude')
     subplot(2,2,2)
    plot(time_t,press_t,'b')
     set(gca,'XDir','reverse'), set(gca,'YDir','reverse'), grid('on')
     xlabel('days'), ylabel('pressure (hPa)')
     title(tit_str)
    subplot(2,2,3)
     plot(time_t,temp_t,'b')
     set(gca,'XDir','reverse'), grid('on')
     xlabel('days'), ylabel('temperature (K)')
    subplot(2,2,4)
     plot(time_t,theta_t,'b')
     set(gca,'XDir','reverse'), grid('on')
     xlabel('days'), ylabel('potential temperature (K)')
  end

end
