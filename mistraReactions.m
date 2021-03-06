function [reactxt,prodtxt] = mistraReactions (dname,fname,spec)
%% ---------------------------------------------------------------------
%% function to parse a text file containing all the chemical reactions
%% in a model and to look for the reaction codes of a selected species.
%% the function is written for the legend files (zgg.txt, zga.txt,
%% zgt.txt) generated by the MISTRA model. it will work for other text
%% files with similar format.
%% by default the list of all reactions (gas-phase and aqueous-phase)
%% are in the MECH/ZGT.TXT file.
%%
%% format of the legend file:
%%       "reaction code n." "reactant1+reactant2"  "product1+product2"
%%
%% input:
%%       dname = directory with legend file ("./" if it is in the
%%               current directory OR "mech")
%%       fname = name of the legend file ("zgt.txt")
%%       spec = species of interest
%%
%% output:
%%        reactxt = cell array of reactions where species is reactant
%%        prodtxt = cell array of reactions where species is product
%%
%% version 1.1, november 2012
%% author: R.S.
%% ---------------------------------------------------------------------

  %% default directory and legend file: mech/zgt.txt
  if (strcmp(dname,'') == 1)
    dname = 'mech';
  end
  if (strcmp(fname,'') == 1)
    fname = 'zgt.txt';
  end

  %% get legend file
  if (strcmp(dname(1,end),'/') == 0)
    lname = [dname,'/',fname];
  else
    lname = [dname,fname];
  end

  %% import legend file into cell array
  [coden,reac,prod] = textread(lname,'%s %s %s');

  %% number of reactions in mechanism
  nreac = size(coden,1);

  %% initialize cell arrays for list of reactions where the selected
  %% species is reactant or product
  reactxt = {''}; a = 1;
  prodtxt = {''}; b = 1;

  %% find reactions involving the selected species
  for n = 1:1:nreac

    %% selected species is a reactant
    if regexp (reac{n}, strcat('[\"+\*]', spec, '[\"+]'))
      reactxt{a,1} = coden{n}(2:end-1);
      reactxt{a,2} = reac{n}(2:end-1);
      reactxt{a,3} = prod{n}(2:end-1);
      a = a + 1;
    end

    %% selected species is a product
    if regexp (prod{n}, strcat('[\"+\*]', spec, '[\"+]'))
      prodtxt{b,1} = coden{n}(2:end-1);
      prodtxt{b,2} = reac{n}(2:end-1);
      prodtxt{b,3} = prod{n}(2:end-1);
      b = b + 1;
    end

  end

end
