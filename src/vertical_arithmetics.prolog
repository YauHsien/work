set([1, 2, 3, 4, 5, 6, 7, 8, 9]).

digit(N) :-
    set(S),
    member(N, S).

times([A, B], C, [D, E]) :-
    digit(A),
    digit(B), A =\= B,
    digit(C), not(member(C, [A, B])),
    digit(D), not(member(D, [A, B, C])),
    digit(E), not(member(E, [A, B, C, D])),
    Lhs is (A * 10 + B) * C,
    Rhs is D * 10 + E,
    Lhs =:= Rhs.

adds([D, E], [F, G], [H, I], S) :-
    member(F, S),
    member(G, S), F =\= G,
    member(H, S), not(member(H, [F, G])),
    member(I, S), not(member(I, [F, G, H])),
    Lhs is D * 10 + E + F * 10 + G,
    Rhs is H * 10 + I,
    Lhs =:= Rhs.

proof([A, B, C, D, E, F, G, H, I]) :-
    N is (A * 10 + B) * C,
    M is D * 10 + E,
    O is M + F * 10 + G,
    P is H * 10 + I,
    N =:= M, O =:= P.

solution([A, B, C, D, E, F, G, H, I]) :-
    times([A, B], C, [D, E]),
    bagof(X, (set(S), member(X, S), not(member(X, [A, B, C, D, E]))), S1),
    adds([D, E], [F, G], [H, I], S1),
    proof([A, B, C, D, E, F, G, H, I]).
% ?- solution(R).
% R = [1, 7, 4, 6, 8, 2, 5, 9, 3] ;
% false.





