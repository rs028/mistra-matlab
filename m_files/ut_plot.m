function ut_plot(xvec,xlab,yvec,ylab,pstyle,ptitle,plegend,scalax)
%% ---------------------------------------------------------------------
%% function to make a 2D plot of a matrix vs a vector.
%%
%% input:
%%       xvec = vector of dependent variable
%%       xlab = name of dependent variable
%%       yvec = vector/matrix of independent variables
%%       ylab = name of independent variables
%%       pstyle = string with style of plot
%%       ptitle = string with title of plot
%%       plegend = string or cell array with legend
%%       scalax = "lin" to plot on linear scale OR
%%                "logx" to plot on logarithmic scale (x-axis) OR
%%                "logy" to plot on logarithmic scale (y-axis) OR
%%                "log" to plot on logarithmic scale (both axis)
%%
%% output:
%%        -> make plot
%%
%% version 1.0, september 2011
%% author: R.S.
%% ---------------------------------------------------------------------

  %% make plot
  switch (scalax)
      %% linear
    case 'lin'
      figure
      plot (xvec,yvec,pstyle)
      %% semilogarithmic
    case 'logy'
      figure
      semilogy (xvec,yvec,pstyle)
      %% semilogarithmic
    case 'logx'
      figure
      semilogx (xvec,yvec,pstyle)
      %% logarithmic
    case 'log'
      figure
      loglog (xvec,yvec,pstyle)
      %% no plot
    otherwise
      fprintf ('\nINVALID INPUT\n');
      return;
  end

  %% display grid
  grid ('on');

  %% set title and axis labels
  title (ptitle);
  xlabel (xlab);
  ylabel (ylab);

  %% set legend
  legend (plegend);
  legend ('boxoff')
  legend ('location','northeast');

end
