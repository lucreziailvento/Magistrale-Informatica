%Puzzle with implied constraint
%A sequenze Puzzle
include "alldifferent.mzn";
int: n; % Number of digits
array [0..n-1] of var 0..n-1: x;  %x[i] is how many time i appears in digits

%Constraint 1:
% For each i, x[i] must equal the number of times the integer i appears in 'digits'

constraint forall(i in 0..n-1)(x[i] = sum (j in 0..n-1)(x[j] == i)); % quante i ci sono in x 
%Constraint2
constraint sum(i in 0..n-1)(x[i]) = n;

%Constraint3
constraint sum(i in 0..n-1)(x[i]*i) = n;

solve satisfy;