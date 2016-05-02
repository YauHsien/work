num([2, 3, 4, 5]).
color([green, yellow, blue, white]).
drink([beer, water, coffee, milk]).
pet([fish, cat, horse, bird]).
sport([polo, baseball, hockey, billiard]).

single([[_, _, green, coffee, _, _],
	[_, _, _, _, bird, polo],
	[_, _, yellow, _, _, hockey],
	[_, 3, _, milk, _, _],
	[_, _, _, beer, _, billiard]]).

twin([[[_, _, green, _, _, _], [_, _, white, _, _, _], on_the_left],
      [[_, _, _, _, _, baseball], [_, _, _, _, cat, _], next_to],
      [[_, _, _, _, horse, _], [_, _, _, _, _, hockey], next_to],
      [[norwegian, _, _, _, _, _], [_, _, blue, _, _, _], next_to],
      [[_, _, _, _, _, baseball], [_, _, _, water, _, _], neighbor_of]
     ]).

on_the_left([_, N, _, _, _, _], [_, M, _, _, _, _]) :-
    N is M - 1.

next_to(X, Y) :-
    neighbor_of(X, Y).

neighbor_of([_, N, _, _, _, _], [_, M, _, _, _, _]) :-
    N is M + 1;
    N is M - 1.

solve(List) :-
    [[brit, N1, red, D1, P1, S1],
     [swede, N2, C1, D2, dog, S2],
     [dane, N3, C2, tea, P2, S3],
     [norwegian, 1, C3, D3, P3, S4],
     [german, N4, C4, D4, P4, soccer]] = List,
    num(Ns), perm([N1, N2, N3, N4], Ns),
    color(Cs), perm([C1, C2, C3, C4], Cs),
    drink(Ds), perm([D1, D2, D3, D4], Ds),
    pet(Ps), perm([P1, P2, P3, P4], Ps),
    sport(Ss), perm([S1, S2, S3, S4], Ss),
    single(Sns),
    forall(member(X, Sns), member(X, List)),
    twin(Tns),
    forall(member([X,Y,P], Tns),
	   (member(X, List), member(Y, List), apply(P, [X,Y]))).

perm([], _Set).
perm([H|T], Set) :-
    member(H, Set),
    perm(T, Set),
    not(member(H, T)).








