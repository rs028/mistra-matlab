function [pntn] = ut_findpnt (dvec,val,pnta,leg)
%% ---------------------------------------------------------------------
%% function to find the index of a vector whose value is greater/equal
%% or lower/equal than a given value. the function assumes that the
%% vector is sorted (e.g., time vector) and parses the vector in
%% increasing order starting from a given index. the function returns -1
%% if the index is outside the vector size.
%%
%% based upon the  FindFirstGE and FindRightMostLE functions for
%% start-stop averaging, by D. Sueper (NOAA).
%%
%% input:
%%       dvec = vector to parse (must be sorted in ascending order)
%%       val = value to be found
%%       pnta = starting index
%%       leg = greater/equal ('GE') OR lower/equal ('LE') than given
%%             value (val)
%%
%% output:
%%        pntn = index of dvec where the value is greater/equal OR
%%               lower/equal than given value
%%
%% version 1.4, february 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  %% get number of points in vector
  if (size(dvec,1) > size(dvec,2))
    lvec = size(dvec,1);
  else
    lvec = size(dvec,2);
  end

  %% starting index is greater than number of points
  if (pnta >= lvec)
    pntn = lvec;

    %% starting index is zero/negative
  elseif (pnta < 1)
    pntn = -1;

    %% starting index is 1 or less/equal than number of points of vector
  else
    switch (leg)

        %% find vector index where value is GREATER/EQUAL than given value
      case 'GE'
        %% value at starting point is greater/equal
        if (dvec(pnta) >= val)
          pntn = pnta;
        %% value at starting point is lower
        else
          n = pnta;
          while (dvec(n) < val && n < lvec)
            n = n + 1;
          end
          if (dvec(n) >= val && dvec(n-1) < val)
            pntn = n;
          else
            pntn = lvec;
          end
        end

        %% find vector index where value is LOWER/EQUAL than given value
      case 'LE'
        %% value at starting point is greater
        if (dvec(pnta) > val)
          pntn = pnta;
        %% last point is lower/equal than value
        elseif (dvec(lvec) <= val)
          pntn = lvec;
        else
          n = pnta;
          while (n < lvec && dvec(n) <= val && dvec(n+1) <= val)
	    if (dvec(n+1) <= val)
	      n = n + 1;
	    end
          end
          pntn = n;
        end

        %% argument given in wrong format
      otherwise
        pntn = [];
        fprintf ('\nINVALID INPUT\n');
        return;
    end
  end

end
