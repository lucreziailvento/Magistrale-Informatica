include "globals.mzn";

int: J;     %number of jobs
int: M;     %number of machines = number of tasks
set of int: MACH = 1..M;
set of int: TASK = 1..M;
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

int: max_time = sum(duration);

%decision variable
array[JOB,TASK] of var 0..(max_time-1):starting_times; %orari di inizio dei task di ciascun job su ciascuna macchina
var 0..max_time:end; %makespan

% Precedence Constraints
constraint forall(j in JOB, m in 1..M-1) (  %m sono i task all'interno del job 
    starting_times[j, m+1] >= starting_times[j, m] + duration[j, machine[j, m]]  %task nello stesso job con machine[j ,m]m abbiamo la durata del task m sulla macchina specificata per quel task 
);

% Constraints
constraint forall(m in MACH) (
    disjunctive([starting_times[j, t] | j in JOB, t in TASK where machine[j, t] == m],
                [duration[j,m]|j in JOB])
);



% Makespan Constraint
constraint forall(j in JOB) (  %% ci assicuriamo che end si ultimo (dummy task)
    end >= starting_times[j, M] + duration[j, machine[j, M]]
); %Per ogni job, assicura che il makespan sia maggiore o uguale all'orario di inizio del task finale M più la sua durata.

solve minimize end;
%solve :: int_search(starting_times, smallest, indomain_min) minimize end;
output["\(end)"];
