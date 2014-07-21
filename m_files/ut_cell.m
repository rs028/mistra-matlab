function [pntn] = ut_cell (dcell,dstr)
%% ---------------------------------------------------------------------
%% function to find the index of a string in a cell array of strings.
%% the function starts from the beginning of the cell array.
%%
%% input:
%%       dcell = cell array of strings
%%       dstr = string to search
%%
%% output:
%%        pntn = index of string
%%
%% version 1.0, november 2012
%% author: R.S.
%% ---------------------------------------------------------------------

  %% number of strings in cell array of strings
  if (size(dcell,1) > size(dcell,2))
    ll = size(dcell,1);
  else
    ll = size(dcell,2);
  end

  %% search string in cell array of strings
  for a = 1:1:ll
    scell = dcell{a};
    if (strcmp(scell,dstr) == 1)
      pntn = a;
    end
  end

end
