
level(1, [wolf, sheep, cabbage], [none, none, none]).
level(2, [none, sheep, cabbage], [wolf, none, none]).
level(2, [wolf, none, cabbage], [none, sheep, none]).
level(2, [wolf, sheep, none], [none, none, cabbage]).
level(3, [none, none, cabbage], [wolf, sheep, none]).
level(3, [none, sheep, none], [wolf, none, cabbage]).
level(3, [wolf, none, none], [none, sheep, cabbage]).
level(4, [none, none, none], [wolf, sheep, cabbage]).

forward(Departure1, Arrival1, Departure2, Arrival2) :-
    level(N, Departure1, Arrival1),
    M is N + 1,
    level(M, Departure2, Arrival2).

hold(Departure1, Arrival1, Departure2, Arrival2) :-
    level(N, Departure1, Arrival1),
    level(N, Departure2, Arrival2),
    [Departure1, Arrival1] \= [Departure2, Arrival2].

safe(Part) :-
    member(wolf, Part),
    member(sheep, Part), !,
    fail.
safe(Part) :-
    member(sheep, Part),
    member(cabbage, Part), !,
    fail.
safe(_).

safe(Departure, Arrival) :-
    safe(Departure),
    safe(Arrival).

step(Departure1, Arrival1, Departure2, Arrival2, [[depart,Step],return]) :-
    subtract(Departure1, Departure2, [Step]),
    subtract(Arrival2, Arrival1, [Step]).

exchange(Departure1, Arrival1, Departure2, Arrival2, [[depart,A],[return,B]]) :-
    member(A, [wolf, sheep, cabbage]),
    member(B, [wolf, sheep, cabbage]),
    A \= B,
    member(A, Departure1),
    member(A, Arrival2),
    member(B, Departure2),
    member(B, Arrival1).

fine(Departure1, Arrival1, Departure2, Arrival2, [[depart,Step]]) :-
    level(4, Departure2, Arrival2),
    step(Departure1, Arrival1, Departure2, Arrival2, [[depart,Step],return]).

solve(Departure1, Arrival1, Route) :-
    level(3, Departure1, Arrival1),
    level(4, Departure2, Arrival2),
    fine(Departure1, Arrival1, Departure2, Arrival2, Route), !.
solve(Departure1, Arrival1, Route) :-
    forward(Departure1, Arrival1, Departure2, Arrival2),
    safe(Departure2, Arrival2),
    step(Departure1, Arrival1, Departure2, Arrival2, Route1),
    append(Route1, Route2, Route),
    solve(Departure2, Arrival2, Route2).
solve(Departure1, Arrival1, Route) :-
    hold(Departure1, Arrival1, Departure2, Arrival2),
    exchange(Departure1, Arrival1, Departure2, Arrival2, Route1),
    append(Route1, Route2, Route),
    solve(Departure2, Arrival2, Route2).
/*
 * ?- solve([wolf,sheep,cabbage], [none,none,none], R), write(R), nl().
 * [[depart,sheep],return,[depart,wolf],[return,sheep],[depart,cabbage],return,[depart,sheep]]
 * R = [[depart, sheep], return, [depart, wolf], [return, sheep],
   [depart, cabbage], return, [depart, sheep]] ;
 * [[depart,sheep],return,[depart,wolf],[return,sheep],[depart,sheep],[return,wolf],[depart,wolf],[return,sheep],[depart,cabbage],return,[depart,sheep]]
 * R = [[depart, sheep], return, [depart, wolf], [return, sheep], [depart,
 sheep], [return, wolf], [depart, wolf], [return|...], [...|...]|...] .
 */






