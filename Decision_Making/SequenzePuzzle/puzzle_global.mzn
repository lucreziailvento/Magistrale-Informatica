%global
include "globals.mzn";

int: n; % Number of digits
array [1..n] of var 0..n-1: x;  %x[i] is how many time i appears in digits

%Constraint 1
constraint let {
  array[1..n] of 0..n-1: cover = 0..n-1
} in global_cardinality(x, cover, x);

solve satisfy;