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
## @deftypefn {Function File} {@var{retval} =} meshselection (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: markel.p <markel.p@DIT0244ES>
## Created: 2020-02-11

function [retval] = meshselection (meshdigit, dimension, node_count)

# printf("Mesh Selection\n")

if meshdigit == 0       # [0, n]
  # do not sanity check, it should have been done in interpolation.m
  retval = linspace(0, dimension, node_count);
elseif meshdigit == 1   # [0, 1]
  retval = linspace(0, 1, node_count);
elseif meshdigit == 2   # [-1, 1] Chevishev
  retval = linspace(-1, 1, node_count);
  for j = 1 : 1 : node_count
    # t(i) = -cos( (i-1)*PI / (k-1))
    retval(j) = -cos( (j - 1) * pi / (node_count-1));
  endfor
else
  error("\"meshdigit\" should be in a range [0, 2]")
endif

endfunction
