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
## @deftypefn {Function File} {@var{retval} =} gaussjordanmethod (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: markel.p <markel.p@DIT0244ES>
## Created: 2020-02-11


function gaussjordanmethod (file)

  title("Gauss Jordan")     # add title to the graph
  eval(file)                # get input params
  
  # keep track of function's execution time
  TIME_TO_EXECUTE = time();
  
  # polynomial of degree at most N in the forma
  # A0 + A1X + A2X^2 + ... + AnX^n = y
  # input points are N + 1
  n = length(PX) - 1;      # get degree of polynomial
  
  # get t values
  Pt = meshselection(meshdigit, n, n + 1);
  
  # declare coefficients foreach axis (including Z, even if unused)
  CX = [];
  CY = [];
  CZ = [];
  # construct the polynomial matrix for Pt
  M = get_polynomials(Pt, n);
  
  # Get axis coefficients from matrix rref
  if Dimension == 3
    [CX, CY, CZ] = get_coefficients(M, PX, PY, PZ, n);
  elseif Dimension == 2
    [CX, CY] = get_coefficients(M, PX, PY, n);
  endif
    
  # create curves to plot
  x = meshselection(meshdigit, n, outputnodes);
  y = x;
  z = x;
  
  x = polyval(CX, x);
  y = polyval(CY, y);
  if Dimension == 3
    z = polyval(CZ, z);
  endif
  
  # keep track of function's execution time
  TIME_TO_EXECUTE = time() - TIME_TO_EXECUTE;
  printf("Gauss-Jordan Time: %d\n", TIME_TO_EXECUTE);
  
  if Dimension == 2
    # plot polynomial in 2D  
    printf("Ploting 2D GaussJordan")
    plot(x, y, 'r')  
  elseif Dimension == 3
# plot polynomial in 3D
    printf("Ploting 3D GaussJordan")
    plot3(x, y, z, 'r')
  
  endif
  
  
endfunction

function [M] = get_polynomials(Pt, n)
  M = ones(n + 1, n + 1);  # create ones matrix of nxn
  # fill matrix with rows
  for i = 1 : 1 : (n + 1)
    # row of exponents
    v = linspace(Pt(i), Pt(i), n + 1); # construct a vector of standard basis at t
    powers_of = linspace(0, n, n + 1); 
    v = v .** powers_of;
    
    # check that sizes concide
    if length(v) != (n + 1)
      error("v row must have size of %d, instead has size of %d", n, length(v))
    endif
    # set v of multiplied X values to M row
    M(i, :) = M(i, :) .* v;
    
  endfor
  # check if determinant != 0; if not, polynomial is of degree N; else < N
  if det(M) == 0
    error("System can't be solved!")
  endif
endfunction

function [CX, CY] = get_coefficients(M, PX, PY, n)

  # make the augmented matrix by adding two last rows of XY values
  M = M';
  M(end + 1, :) = PX;
  M(end + 1, :) = PY;
  #transpose M
  M = M';
  # apply RREF to get A0, A1, ... , An
  M = rref(M);
  # only take last column, coefficients
  CX = M(:, n + 2);
  CY = M(:, n + 3);
  # flip polynomial arrays  
  CX = flip(CX);
  CY = flip(CY);
  
endfunction

function [CX, CY, CZ] = get_coefficients(M, PX, PY, PZ, n)

  # make the augmented matrix by adding two last rows of XY values
  M = M';
  M(end + 1, :) = PX;
  M(end + 1, :) = PY;
  M(end + 1, :) = PZ;
  #transpose M
  M = M';
  # apply RREF to get A0, A1, ... , An
  M = rref(M);
  # only take last column, coefficients
  CX = M(:, n + 2);
  CY = M(:, n + 3);
  CZ = M(:, n + 4);
  # flip polynomial arrays  
  CX = flip(CX);
  CY = flip(CY);
  CZ = flip(CZ);
  
endfunction