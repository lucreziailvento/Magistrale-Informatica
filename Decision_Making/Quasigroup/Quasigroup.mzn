include "alldifferent.mzn";

int: N;  %dimensioni

array[1..N, 1..N] of 0..N: start; %matrice valori iniziali
array[1..N, 1..N] of var 1..N: square;  %matrice che rappresenta il quasigroup

% Copia i valori iniziali da start a square
constraint forall (i in 1..N, j in 1..N) (
    if(start[i, j]in 1..N) then (square[i, j]= start[i, j])else true endif
);
    
constraint forall (i in 1..N) (     %applichiamo il vincolo a ciascuna riga 
		alldifferent( [ square[i, j] | j in 1..N ])::domain
);

constraint forall (j in 1..N) (        %%applichiamo il vincolo a ciascuna  colonna
		alldifferent([ square[i, j] | i in 1..N ])::domain
);

%solve satisfy;
%solve::int_search(square,dom_w_deg,indomain_random) satisfy;
solve::int_search(square,dom_w_deg,indomain_random):: restart_luby(250) satisfy;
