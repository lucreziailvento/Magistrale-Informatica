% Find the code of my safe composed of 10 digits, where the first digit gives the number of 0s in the 
%code, the second the number of 1s, the third the number of 2s, and so on with the 10th digit giving  
%the number of 9s in the code.l Solve the puzzle with a more general version: find a 
%sequence of n integers X0,…, Xn-1 that contains values between 0 and n-1, in a way that any value i
%appears Xi times in the sequence
%A sequenze Puzzle
int: n; % Number of digits
array [0..n-1] of var 0..n-1: x;  %x[i] is how many time i appears in digits

%Constraint 1:
% For each i, x[i] must equal the number of times the integer i appears in 'digits'

constraint forall(i in 0..n-1)(x[i] = sum (j in 0..n-1)(x[j] == i)); 


solve satisfy;