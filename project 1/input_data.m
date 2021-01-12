%---------------------------------------------------------------------------
% MAT300 Curves and Surfaces
% Markel Pisano Berrojalbiz
% markel.p@digipen.edu
% 2/8/2020
% 
% Script input data project 1
%---------------------------------------------------------------------------

% default input
PX = [1 2 3 1 ];     % x-coordinate interpolation points
PY = [-1 2 6 0];    % y-coordinate interpolation points
PZ = [2 1 1 4];     % z-coordinate interpolation points (un-comment)

% example input
PX = [1 2 0]
PY = [-1 3 4]

Dimension = 2;  % dimension 2 or 3 (consistent with PZ)

meshdigit = 0;  % 0 regular [0, n], 1 regular [0, 1], 2 Chebyshev [-1, 1]

methoddigit = 0;  % 0 Gauss-Jordan (R), 1 Lagrange (G), 2 Newton (B), -1 All

outputnodes = 6;  % number of nodes for the output mesh

verbose = 1;      % extra console input