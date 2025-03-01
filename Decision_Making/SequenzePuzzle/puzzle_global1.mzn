%global+implied
include "globals.mzn";

int: n; % Number of digits
array [1..n] of var 0..n-1: x;  %x[i] is how many time i appears in digits

%Constraint 1:
constraint let {
  array[1..n] of 0..n-1: cover = 0..n-1
} in global_cardinality(x, cover, x);

%Constraint2
constraint sum(i in 1..n) (x[i]) = n;

%Constraint3
constraint sum(i in 1..n) (x[i] * (i-1)) = n;

solve satisfy;