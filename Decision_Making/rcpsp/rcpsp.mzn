include "globals.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;       % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations

int: max_duration = sum(duration); %la somma massima delle durate dei task.

array[TASKS] of var 0..max_duration: start_time ;%inizio di ciascun task

%constraint precedenza
%per ogni coppia dell'array l'attività successive deve essere maggiore o uguale all'inizio dell'attività precedente + la durata 
constraint forall(i in PREC)(start_time[pre[i,2]]>= start_time[pre[i,1]] + duration[pre[i,1]]);

%constrain cumulative
constraint forall(r in RESOURCES)(
  cumulative(start_time,duration,req[r,TASKS],L[r])
);


solve minimize (max(i in TASKS) (start_time[i] + duration[i])); %minimizzare la somma massima tra l'orario di inizio e la durata di ogni attività.
%solve::int_search(start_time,smallest,indomain_min) minimize (max(i in TASKS) (start_time[i] + duration[i]));