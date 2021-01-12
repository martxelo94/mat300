##############################################
INTERPOLATION PROJECT
Author: Markel Pisano Berrojalbiz
Date: 1-11-2021 (MM-DD-20YY)
##############################################

USAGE	#######################################
- Run Octave(GUI)
- Set the folder containing this readme.txt file as current project.
- Go to the terminal.
- Call function "interpolation" with specified *.m file as parameter like this:
	interpolation('input_data')
- Change "input_data.m" for setting interpolation method and more attributes.

FILES	#######################################
- explanations.pdf
	Mathematical explanation of each method, code implementation and examples.
- input_data.m
	Input data to configure the program.
- interpolation.m
	Selects the method to interpolate with.
- gaussjordanmethod.m
	Applies and outputs Gauss-Jordan interpolation.
- lagrangemethod.m
	Applies and outputs Lagrange interpolation.	
- newtonmethod.m
	Applies and outputs Newton interpolation.
- meshselection.m
	Selects the boundaries of the mesh.
