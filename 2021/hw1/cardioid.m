%---------------------------------------------------------------------------
% MAT300 Curves and Surfaces
% Markel Pisano Berrojalbiz
% markel.p@digipen.edu
% 1/13/2021
% 
% Cardioid Animation
%---------------------------------------------------------------------------

function cardioid

out_dir = "temp_img"; %create folder to save images (COPY-PASTE IN YOUR CODE)
mkdir (out_dir); %create folder to save images (COPY-PASTE IN YOUR CODE)

% Setup animation duration
anim_seconds = 4;
fps = 15;
frames = anim_seconds * fps;
% angle delta
angle_delta = 2 * pi / frames;

% Setup cardioid properties
R0 = 2;
R1 = 2;
C0 = [-2 0];  % [x y]
C1 = [2 0];   % [x y]

thera = 0;
x = [];
y = [];

% +1 frame to close the loop
for i = 1 : 1 : frames + 1

  % distance from outer circle to inner
  R = R0 + R1;
  % center of outer circle
  Px = R * cos(thera) + C0(1);
  Py = R * sin(thera) + C0(2);
  % since the outer circle rotates around the inner one 
  % and their size proportion is 1:1, it's angle respect to
  % the XY plane is 2*thera + PI
  thera_prime = pi + 2*thera;

  % draw inner circle
  draw_circle(C0(1), C0(2), R0, thera);
  hold on
  % draw outer circle
  draw_circle(Px, Py, R1, thera_prime);
  hold on
  % update angle
  thera += angle_delta;
  % compute cardioid new point
  X = Px + R1 * cos(thera_prime);
  Y = Py + R1 * sin(thera_prime);

  
  x(i) = X;
  y(i) = Y;
  % draw current cardoid point
  plot(X, Y, 'b');
  hold on
  % draw current cardioid curve
  plot(x, y, 'r');
  % set graph limits
  axis([-8, 8, -8, 8], "square")
  hold off
  % output to file
  fname = fullfile (out_dir, sprintf ("img%03i.png", i)); % save image (COPY-PASTE IN YOUR CODE)
  imwrite (getframe (gcf).cdata, fname); %(COPY-PASTE IN YOUR CODE)

  
endfor

printf("DONE");

endfunction

% draw a circle and a line it's center to the current angle position
function draw_circle(Cx, Cy, R, thera)
  vertices = 20;  % circle precision
  angle_delta = 2 * pi / vertices;
  x = [];
  y = [];
  for i = 1 : 1 : vertices + 1
    % circle parametric function
    x(i) = R * cos(thera) + Cx;
    y(i) = R * sin(thera) + Cy;
    % update angle
   thera += angle_delta;
   
  endfor
  % draw line to the current angle
  plot([Cx, x(1)], [Cy, y(1)], 'r');
  hold on
  % draw circle
  plot(x, y, 'b');
  
endfunction
