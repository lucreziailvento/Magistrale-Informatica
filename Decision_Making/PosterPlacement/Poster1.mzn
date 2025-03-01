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

array[1..2*n] of var int: all_vars;

% Pretending posters don't overcome the max dimensions
constraint forall (i in 1..n) (
	(x[i] + widths[i] - 1 <= max_width) /\
	(y[i] + heights[i] - 1 <= max_height)
);

%this is constructed to create a new search order
constraint forall (i in 1..n) (all_vars[2*i] = y[i] /\ all_vars[2*i-1] = x[i]);

% Pretending that posters don't overlap
constraint diffn(x, y, widths, heights);


% Search for all solutions, using the data in the file
%solve::int_search(all_vars,input_order,indomain_min) satisfy;
%solve::int_search(all_vars,input_order,indomain_random) satisfy;
%solve::int_search(all_vars,first_fail,indomain_min) satisfy;
%solve::int_search(all_vars,first_fail,indomain_random) satisfy;
%solve::int_search(all_vars,dom_w_deg,indomain_min) satisfy;
solve::int_search(all_vars,dom_w_deg,indomain_random) satisfy;

