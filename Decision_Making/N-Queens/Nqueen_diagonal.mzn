include "gecode.mzn";
% Minimize the total distance of the queens to the main diagonal
% Alldifferent model
include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.  
constraint alldifferent(q)::domain;  % distinct rows
constraint alldifferent([q[i] + i | i in 1..n])::domain; % distinct diagonals
constraint alldifferent([q[i] - i | i in 1..n])::domain;

%objective function
var int:total_distance = sum(i in 1..n)(abs(q[i]-i));


 %n=50
%solve minimize total_distance;
solve::int_search(q,dom_w_deg,indomain_random)  minimize total_distance;
%solve::int_search(q,dom_w_deg,indomain_random):: restart_luby(250)  minimize total_distance;
%solve :: int_search(q,dom_w_deg,indomain_random) ::  relax_and_reconstruct(q,85) :: restart_luby(250) minimize total_distance;
output["objective", show(total_distance)];



