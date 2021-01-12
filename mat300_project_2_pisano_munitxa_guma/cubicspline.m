%------------------------------------------------------------------------------
% Subject: MAT300
% Function name: cubicspline.m
% Students name: Kerman Munitxa, Julia Guma, Markel Pisano
% 3/11/2020
%
% Description: Compute the cubic spline given some points
%------------------------------------------------------------------------------

function cubicspline(data)  

 
  %Get the data
  eval(data);
  
  %Get the size of the mesh
  size = columns(PX);
  
  %Create the mesh [0, n]
  t = linspace(0, size-1, size);
 
  %Check if we are in 2 or three dimensions 
  PZ_data = [];  
  if(Dimension == 3)
    PZ_data = PZ;
  endif
    
   %Build the matrix
   for row=1:1:size       
      mat(row, 1) = 1;%The first column is always 1    
      
      %For every column, get input the row values
      for col=2:1:(row + 2)       
        a = 0;
        
        %first numbers are always (1, x, x2, x3)
         if(col < 5)
            a = t(row) ^ (col - 1);
         else%These values are the right shifted basis
          a = max(t(row) - t(col - 3), 0) ^ 3; 
         endif 
     
         mat(row, col) = a;            
       endfor 
       
       mat(row, size + 3) = PX(row);%Add the values of x
       mat(row, size + 4) = PY(row);%Add the values of y
       
       if Dimension == 3
        mat(row, size + 5) = PZ(row);%Add the values of z (if necessary)
       endif       
   endfor
   
   %Adding the values of the second derivatives
   mat(size + 1, :) = 0;
   mat(size + 1, 3) = 2;
   mat(size + 2, :) = 0;
   mat(size + 2, 3) = 2;
   
   %conveniently, our first t is 0, so we forget about its row
   for i = 4:1:(size+2)
    mat(size + 2, i) = 6 * (t(size) - t(i-3));    
   endfor
   
   %getting the rref
   mat = rref(mat);
   
   %Get the values of t
   t_new = linspace(t(1), t(size), outputnodes);
   
   %getting the a from the matrix
   a_x = mat(:, size + 3);   
   a_y = mat(:, size + 4);
   
   if Dimension == 3
      a_z = mat(:, size + 5);
      z_plot = zeros(1, outputnodes);  
   endif
   
   
   %Getting the x and y for the plotting using the as
   x_plot = zeros(1, outputnodes);
   y_plot = zeros(1, outputnodes);   
   
   %first as using x^0,x^1,x^2,x^3
   for i=1:1:outputnodes
    for j=1:1:4
     x_plot(i) += a_x(j) * (t_new(i)^ (j-1));
     y_plot(i) += a_y(j) * (t_new(i)^ (j-1));
     
    if Dimension == 3
      z_plot(i) += a_z(j) * (t_new(i)^ (j-1));
    endif
      
    endfor
   endfor
   
   
    %Right shifted basis. These as using (t -ti)^3
    for i=1:1:outputnodes
      for j=5:1:rows(a_x)
        power = max(t_new(i) - t(j - 3), 0) ^ 3;
        x_plot(i) += a_x(j) * power;
        y_plot(i) += a_y(j) * power;  
       
         if Dimension == 3
           z_plot(i) += a_z(j) * power;  
         endif
       endfor       
   endfor
   
   
   
   if( Dimension == 2)
   %Display the given points
       for n=1:1:size
        plot(PX(n), PY(n), 'ro');
        hold on;  
       endfor
   
   plot(x_plot, y_plot, 'b');   
   else   
   %Display the given points
       for n=1:1:size
        plot3(PX(n), PY(n), PZ(n), 'ro');
        hold on;  
       endfor
   
   plot3(x_plot, y_plot, z_plot,'b');
   endif
  
  
  
endfunction