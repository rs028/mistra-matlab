function [Xvalue] = physConst (Xsymb)
%% ---------------------------------------------------------------------
%% function to output the values of physical/chemical constants.
%% the values of the constants are from the NIST Standard Reference
%% Database:
%%          http://physics.nist.gov/cuu/Constants/index.html
%%
%% input:
%%       Xsymb = symbol of constant
%%
%% output:
%%        Xvalue = value of constant
%%
%% version 1.3, march 2013
%% author: R.S.
%% ---------------------------------------------------------------------

  switch (Xsymb)

    case 'R'   %% molar gas constant (J K-1 mol-1)
      Xvalue = 8.314472;

    case 'Na'  %% Avogadro number (mol-1)
      Xvalue = 6.022142e+23;

    case 'kB'  %% Boltzmann constant (J K-1)
      Xvalue = 1.380650e-23;

    case 'h'   %% Planck constant (J s)
      Xvalue = 6.626068e-34;

    case 'SB'  %% Stefan-Boltzmann constant (W m-2 K-4)
      Xvalue = 5.670400e-08;

    case 'Wb'  %% Wien wavelength displacement constant (m K)
      Xvalue = 2897.7685;

    otherwise
      fprintf ('\nSYMBOL NOT FOUND\n');
  end

end
