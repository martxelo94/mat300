## Copyright (C) 2020 markel.p
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} newtonmethod (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: markel.p <markel.p@DIT0244ES>
## Created: 2020-02-11

function newtonmethod (file)

printf("Newton Method\n")
title("Newton")     # add title to the graph
eval(file)          # get input params

# keep track of function's execution time
TIME_TO_EXECUTE = time();

# degree
n = length(PX);

# create nodes and t values at P
Pt_nodes = meshselection(meshdigit, n-1, outputnodes);
Pt = meshselection(meshdigit, n-1, n); 

# compute point with Newton Basis
x = newton_divided_differences(Pt_nodes, Pt, PX);
y = newton_divided_differences(Pt_nodes, Pt, PY);

if Dimension == 3
  z = newton_divided_differences(Pt_nodes, Pt, PZ);
endif

# keep track of function's execution time
TIME_TO_EXECUTE = time() - TIME_TO_EXECUTE;
printf("Newton Time: %d\n", TIME_TO_EXECUTE);

# draw

  if Dimension == 2
    # plot polynomial in 2D  
    printf("Ploting 2D Newton")
    plot(x, y, 'b')  
  elseif Dimension == 3
# plot polynomial in 3D
    printf("Ploting 3D Newton")
    plot3(x, y, z, 'b')
  
  endif
endfunction



function [P] = newton_divided_differences(Pt_nodes, Pt, P0)
  # using dynamic programing approach instead of recursion
  n = length(P0); # Point count
  
  # use triangle structure for divided differences
  dd_count = n;                         # start total count of nodes
  dd_level_idx = linspace(1, 0, n - 1); # starting idx of each level
  dd_level_idx(1) = 1;      
  # compute number of elements per DD level
  for i = 1 : 1 : n - 1
    dd_count += n - i;              # accumulate element count
    dd_level_idx(i + 1) = dd_level_idx(i) + n - i + 1; # stating idx of level i
  endfor
    
  DD = linspace(0, 0, dd_count);  # create array of divided differences
  DD_triangle_base_min = linspace(0, 0, dd_count); # first index t0
  DD_triangle_base_max = linspace(0, 0, dd_count); # last index t1
  # fill first level with point values
  for i = 1 : 1 : n
    DD(i) = P0(i);                    # level 0 is point
    DD_triangle_base_max(i) = DD_triangle_base_min(i) = Pt(i);  # range 1
  endfor
  # compute every other level by accesing previously stored levels
  dd_idx = n;  # keep track of current idx in array
  for i = 1 : 1 : n - 1   # i is the current level
    for j = 1 : 1 : n - i # j is the current element of that level
      ++dd_idx;
      # set Tmax and Tmin
      t0 = dd_level_idx(i) + j - 1;
      t1 = dd_level_idx(i) + j - 0;
      # get lvl 0 p
      DD_triangle_base_min(dd_idx) = DD_triangle_base_min(t0);
      DD_triangle_base_max(dd_idx) = DD_triangle_base_max(t1);
      # compute f[1] - f[0]
      f0 = DD(t0);
      f1 = DD(t1);
      DD(dd_idx) = f1 - f0;
      # divide by t1 - t0 
      DD(dd_idx) /= DD_triangle_base_max(dd_idx) - DD_triangle_base_min(dd_idx);
    endfor
  endfor
  # sanity check (triangle traversed ok...)
  if dd_idx != dd_count
    error("dd_idx must equal dd_count at the final of the triangles struct traverse")
  endif
  
  # divided differences are computed!
  # now must compute newton basis (foreach point in the node)
  
  for p = 1 : 1 : length(Pt_nodes)
  
    # sum j=0...n
    sum_result = 0;
    for j = 1 : 1 : n
      # get divided differences
      f_ti = DD(dd_level_idx(j));
      # compute Newton Basis
      N_basis = 1;
      for i = 1 : 1 : j - 1
        N_basis *= (Pt_nodes(p) - Pt(i));
      endfor
      # add to result
      sum_result += f_ti * N_basis;
    endfor
    # set final value to node p
    P(p) = sum_result;
  
  endfor
  

endfunction
