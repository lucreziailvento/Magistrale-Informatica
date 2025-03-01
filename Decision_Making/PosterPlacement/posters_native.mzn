% Number of posters
int: n;

% The dimensions of the matrix
int: max_height;
int: max_width;

% The dimensions of the posters
array[1..n] of 1..max_width: widths;
array[1..n] of 1..max_height: heights;

/* The coordinates of the posters, each composed by the starting point */
array[1..n] of var 1..max_width: x;
array[1..n] of var 1..max_height: y;

% Pretending posters don't overcome the max dimensions
constraint forall (i in 1..n) (
    (x[i] + widths[i] - 1 <= max_width) /\
    (y[i] + heights[i] - 1 <= max_height)
);

% Pretending that posters don't overlap
constraint forall (i, j in 1..n where i != j)(
    (x[i] + widths[i] - 1 < x[j]) \/
    (x[j] + widths[j] - 1 < x[i]) \/
    (y[i] + heights[i] - 1 < y[j]) \/
    (y[j] + heights[j] - 1 < y[i])
);

solve satisfy;
