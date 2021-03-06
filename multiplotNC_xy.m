function [datamat] = multiplotNC_xy (fname,vlist,wlist,vbin,vph,prof,sect,vin,vout,ptmat,pl)
%% ---------------------------------------------------------------------
%% function to retrieve the vertical or horizontal profiles of multiple
%% variables from a netCDF file; to plot the variables versus time or
%% versus altitude. the variables can be converted to a selected
%% measurement unit. the function is written for the netCDF files
%% generated by the MISTRA model (gas.nc, aq.nc, jrate.nc, meteo.nc). it
%% will work for other netCDF files with similar format.
%%
%% ==> see documentation of plotNC_xy.m <==
%% ==> see documentation of convertConc_gas.m <==
%% ==> see documentation of convertConc_aq.m <==
%%
%% input:
%%       fname = name of the netCDF file
%%       vlist = cell array with names of variables
%%       wlist = array with molecular weights of variables OR
%%               [] if variables not chemical species
%%       vbin = aerosol bin of variables ("1" if not in aerosol)
%%       vph = "gas" (if variables in gas-phase) OR
%%             "aq" (if variables in aqueous-phase)
%%       prof = "horizontal" or "vertical" profile
%%       sect = level number (if prof="horizontal") OR
%%              timestep (if prof="vertical")
%%       vin = original unit of concentration
%%       vout = final unit of concentration
%%       ptmat = [pressure, temperature] matrix with the same
%%               vertical/horizontal profile of variables
%%       pl = plot is required ("yes" OR "no")
%%
%% output:
%%        datamat = matrix of retrieved (and converted) variables
%%        -> make plot (if required)
%%
%% version 2.2, november 2012
%% author: R.S.
%% ---------------------------------------------------------------------

  %% set horizontal/vertical profile
  switch (prof)
    case 'horizontal'
      ivar = 'time';
      tet = ['level number ',sect];
    case 'vertical'
      ivar = 'altitude';
      tet = ['timestep ',sect];
  end
  datamat = [];

  %% make cell array with list of variables to retrieve
  if (size(vlist,1) ~= 1 && size(vlist,2) == 1)
    vlist = vlist';
  end
  if (size(wlist,1) ~= 1 && size(wlist,2) == 1)
    wlist = wlist';
  end
  ivec = size(vlist,2);

  %% retrieve profiles of all variables
  for a = 1:1:ivec
    vvar = vlist{a};
    if (size(vlist,2) == size(wlist,2))
      vmw = wlist(a);
    else
      vmw = [];
    end

    %% vertical/horizontal profile of selected variable
    rmat = plotNC_xy (fname,vvar,vbin,ivar,'1',prof,sect,'no');

    switch (prof)
        %% horizontal profile
      case 'horizontal'
        r = size(rmat,2);
        if (a == 1)
          datamat = rmat(1,:);
        end
        rdat = rmat(2,:);
        if (strcmp(vin,vout) == 0)
          cdat = call_convert (vph,prof,rdat,vin,vout,ptmat,vmw);
          cdat = [rdat(1,1),cdat(1,2:r)];
        else
          cdat = [rdat(1,1),rdat(1,2:r)];
        end
        datamat = [datamat;cdat];

        %% vertical profile
      case 'vertical'
        r = size(rmat,1);
        if (a == 1)
          datamat = rmat(:,1);
        end
        rdat = rmat(:,2);
        if (strcmp(vin,vout) == 0)
          cdat = call_convert (vph,prof,rdat,vin,vout,ptmat,vmw);
          cdat = [rdat(1,1);cdat(2:r,1)];
        else
          cdat = [rdat(1,1);rdat(2:r,1)];
        end
        datamat = [datamat,cdat];
    end
  end

  %% make plot
  if (strcmp(pl,'yes') == 1)
    tstr = [vph,'-phase (bin ',vbin,') at ',tet];
    switch (prof)
      case 'horizontal'
        xx = datamat(1,2:end);
        yy = datamat(2:end,2:end);
        ut_plot (xx,ivar, yy,vout, '-',tstr,vlist, 'logy')
      case 'vertical'
        xx = datamat(2:end,2:end);
        yy = datamat(2:end,1);
        ut_plot (xx,vout, yy,ivar, '-',tstr,vlist, 'logx')
    end
    %% no plot
  else
    fprintf ( ['>>>>> profiles of ', strs2list(vlist), ' retrieved\n'] );
  end

end


%% ------------------------------------------------------------------ %%


function [datout] = call_convert(dph,dprof,datin,unin,unout,PT,MW)
  %% convert measurement unit of selected variable

  switch (dprof)
    case 'horizontal'
      P = PT(1,:);
      T = PT(2,:);
    case 'vertical'
      P = PT(:,1);
      T = PT(:,2);
  end

  switch (dph)
    case 'gas'  % gas-phase
      datout = convertConc_gas (datin,unin,unout,T,P);
    case 'aq'   % aqueous-phase
      datout = convertConc_aq (datin,unin,unout,MW);
  end

end
