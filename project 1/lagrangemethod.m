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
## @deftypefn {Function File} {@var{retval} =} lagrangemethod (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: markel.p <markel.p@DIT0244ES>
## Created: 2020-02-11

function lagrangemethod (file)

printf("Lagrange Method\n")
eval(file)          # get input params

# keep track of function's execution time
TIME_TO_EXECUTE = time();


# degree
n = length(PX);

# create nodes and t values at P
Pt = meshselection(meshdigit, n-1, n);
Pt_nodes = meshselection(meshdigit, n-1, outputnodes);

# compute values at t foreach axis with lagrange polynomials
x = lagrange(Pt_nodes, Pt, PX);
y = lagrange(Pt_nodes, Pt, PY);

if Dimension == 3
  # compute lagrange points for Z axis
  z = lagrange(Pt_nodes, Pt, PZ);
endif
# keep track of function's execution time
TIME_TO_EXECUTE = time() - TIME_TO_EXECUTE;
printf("Lagrange Time: %d\n", TIME_TO_EXECUTE);

  if verbose == 1
    Pt
    x
    y
    if Dimension == 3
      z
    endif
  endif
# draw graph
title("Lagrange")   # add title to the graph

if Dimension == 2
  # plot polynomial in 2D  
  printf("Ploting 2D Lagrange")
  plot(x, y, 'g')  
elseif Dimension == 3
# plot polynomial in 3D
  printf("Ploting 3D Lagrange")
  plot3(x, y, z, 'g')

endif

endfunction

# @brief  compute lagrange values at t for axis P0 values
# @param   Pt t nodes
# @param    P0 input points of size n
# @return  P values at P0 axis, for each value at Pt
function [P] = lagrange(p_nodes, Pt, P0)
  n = length(P0);
  
  for t = 1 : 1 : length(p_nodes)
    P(t) = 0;   # set value to 0 at t
    for i = 1: 1 : n
      p = 1;    # init polynomial p(i, j)
      for j = 1 : 1 : n
        if i == j # avoid division by 0
          continue;
        endif
        p *= (p_nodes(t) - Pt(j)) / (Pt(i) - Pt(j));  # multiply p(i, j)
      endfor
     P(t) += P0(i) * p; # accumulate
    endfor
  endfor  
  
endfunction