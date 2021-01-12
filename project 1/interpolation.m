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
## @deftypefn {Function File} {@var{retval} =} interpolation (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: markel.p <markel.p@DIT0244ES>
## Created: 2020-02-11

function interpolation(file)

eval(file)        # get input params

# sanity check: lenghts of PX, PY, PZ are equal
if Dimension == 2
  if length(PX) != length(PY)
    error("PX and PY lenghts must be equal!")
    #changing Dimension by checking PZ existance
  endif
elseif Dimension == 3
  # sanity check: if Dimension = 3, PZ exists
  if exist("PZ", "var") == true
    # check if array lenght is OK
    if length(PX) != length(PZ)
      error("PX and PY lenghts must be equal!") 
    endif
  else
    error("PZ must exist if Dimension is 3!")
  endif
else
  error("Non valid Dimension selected. Valid dimensions = [2, 3]")
endif
# just tell the working space
printf("Working on %dD space.\n", Dimension)

#hold off; # reset the graph
clf

# select the method to use and call the corresponding function
if methoddigit == 0
  gaussjordanmethod(file)
elseif methoddigit == 1
  lagrangemethod(file)
elseif methoddigit == 2
  newtonmethod(file)
elseif methoddigit == -1  # all methods at one, overlap graphs
  gaussjordanmethod(file)
  lagrangemethod(file)
  newtonmethod(file)
  title("All 3 Methods Overlaped");
else
  error("methoddigit does not correspond with any function!")
endif  

hold on

# plot input points
if Dimension == 2
  plot(PX, PY, 'o');
elseif Dimension == 3
  plot3(PX, PY, PZ, 'o');
  %zlim([min(PZ) max(PZ)]);
  zlabel("Z")
endif

 # DONE!
 
endfunction
