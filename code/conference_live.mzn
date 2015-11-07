%% problem statement

int: n = 10;
set of int: TALK = 1..n;

int: compilers = 1;
int: frontend = 2;
int: backend = 3;
int: fun = 4;

set of int: THEME = compilers..fun;

array[TALK] of int: duration = [40, 40, 40, 40, 40, 20, 20, 20, 20, 20];
array[TALK] of THEME: theme = [compilers, compilers, compilers, fun, fun, frontend, fun, fun, fun, backend];
array[TALK] of 1..4: difficulty = [1, 1, 2, 3, 2, 2, 3, 2, 1, 1];

%% aux stuff

int: maxtime = sum(i in TALK)(duration[i]);
set of int: TIME = 0..maxtime;

%% decision variables

array[TALK] of var TIME: start;

%% helper variables

array[TALK] of var TIME: end;

constraint forall(i in TALK)(end[i] = start[i] + duration[i]);

include "disjunctive.mzn";
constraint disjunctive(start, duration);


set of int: POSITION = 1..n;
array[TALK] of var POSITION: order;

constraint forall(i1 in TALK, i2 in TALK where i1 < i2)
                 (start[i1] < start[i2] <-> order[i1] < order[i2]);

include "alldifferent.mzn";
constraint alldifferent(order);

array[POSITION] of var TALK: order_reverse;
include "inverse.mzn";
constraint inverse(order, order_reverse);

constraint forall(i in 1..(n-1))
                 (theme[order_reverse[i]] = fun \/ theme[order_reverse[i+1]] = fun);
%constraint order = array1d(1..10 ,[8, 10, 6, 9, 7, 4, 5, 3, 2, 1]);

var int: obj;

constraint obj = sum(i in TALK)(if order[i] < n/2 then difficulty[i] else difficulty[i] * 2 endif);

%solve satisfy;
solve minimize obj;

%include "conference_viz.mzn";
%output [conference_viz(duration, theme, start)];
