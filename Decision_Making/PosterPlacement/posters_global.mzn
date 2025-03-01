include "globals.mzn";

% Number of posters
int: n;

% The dimensions of the matrix
int: max_width;
int: max_height;

% The dimensions of the posters
array[1..n] of 1..max_width: widths;
array[1..n] of 1..max_height: heights;

/* The coordinates of the posters, each composed by the starting point */
% The width
array[1..n] of var 1..max_width: x;

% The length
array[1..n] of var 1..max_height: y;

% Pretending posters don't overcome the max dimensions
constraint forall (i in 1..n) (
	(x[i] + widths[i] - 1 <= max_width) /\
	(y[i] + heights[i] - 1 <= max_height)
);

% Pretending that posters don't overlap
constraint diffn(x, y, widths, heights);

solve satisfy;
