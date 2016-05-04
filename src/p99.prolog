
% P01
my_last(X, [X]).
my_last(X, [_, H|T]) :-
    my_last(X, [H|T]).

% P02
last_but_one(X, [X,_]).
last_but_one(X, [H|T]) :-
    not(length([H|T], 2)),
    last_but_one(X, T).

% P03
element_at(X, [X|_], 1).
element_at(X, [_|T], K) :-
    K > 1,
    K1 is K - 1,
    element_at(X, T, K1).

% P04
my_length(0, []).
my_length(N, [_|T]) :-
    my_length(N1, T),
    N is N1 + 1.

% P05
my_reverse([], []).
my_reverse([H1|T1], List2) :-
    append(T2, [H1], List2),
    my_reverse(T1, T2), !.
my_reverse([H1|T1], List2) :-
    my_reverse(T1, T2),
    append(T2, [H1], List2).

% P06
palindrome(List) :-
    my_reverse(List, List).

% P07
my_flatten([], []).
my_flatten([H|T], List) :-
    is_list(H), !,
    my_flatten(H, H1),
    my_flatten(T, T1),
    append(H1, T1, List).
my_flatten([H|T], List) :-
    my_flatten(T, T1),
    List = [H|T1].

% P08
compress([], []).
compress([X], [X]) :- !.
compress([H,H|T], List) :- !,
    compress([H|T], List).
compress([H,X|T], [H|List]) :-
    compress([X|T], List).

% P09
pack([], []).
pack([X], [[X]]) :- !.
pack([H,H|T], [[H|Hs]|List]) :- !,
    pack([H|T], [Hs|List]).
pack([H,X|T], [[H]|List]) :-
    pack([X|T], List).

% P10
encode([], []).
encode([X], [[1,X]]) :- !.
encode([H,H|T], [[N,H]|List]) :- !,
    encode([H|T], [[M,H]|List]),
    N is M + 1.
encode([H,X|T], [[1,H]|List]) :-
    encode([X|T], List).

% P11
encode_modified([], []).
encode_modified([X], [X]) :- !.
encode_modified([H,H|T], [[N,H]|List]) :-
    encode_modified([H|T], [[M,H]|List]), !,
    N is M + 1.
encode_modified([H,H|T], [[2,H]|List]) :- !,
    encode_modified([H|T], [H|List]).
encode_modified([H,X|T], [H|List]) :-
    encode_modified([X|T], List).

% P12
decode_modified([], []).
decode_modified([H|T], [H|List]) :- not(is_list(H)), !,
    decode_modified(T, List).
decode_modified([[1,H]|T], [H|List]) :- !,
    decode_modified(T, List).
decode_modified([[N,H]|T], [H|List]) :-
    N1 is N - 1,
    decode_modified([[N1,H]|T], List).

% P13
encode_direct([], []).
encode_direct([X], [X]) :- !.
encode_direct([H,H|T], [[N,H]|List]) :-
    encode_direct([H|T], [[M,H]|List]), !,
    N is M + 1.
encode_direct([H,H|T], [[2,H]|List]) :-
    encode_direct([H|T], [H|List]), !.
encode_direct([H,X|T], [H|List]) :-
    encode_direct([X|T], List).

% P14
dupli([], []).
dupli([H|T], [H,H|R]) :-
    dupli(T, R).

% P15
dupli([], _, []).
dupli([H|T], N, List) :-
    decode_modified([[N,H]], H1),
    dupli(T, N, T1),
    append(H1, T1, List).

% P16
drop(List1, N, List2) :-
    drop(List1, N, List2, N).

drop([], _, [], _).
drop([_|T], N, R, 1) :- !,
    drop(T, N, R, N).
drop([H|T], N, R, M) :-
    M1 is M - 1,
    drop(T, N, T1, M1),
    R = [H|T1].

% P17
split([], _, [], []).
split([H|T], 0, [], [H|T]) :- !.
split([H|T], N, [H|H1], T1) :-
    N1 is N - 1,
    split(T, N1, H1, T1).

% P18
slice(List1, 0, N, List2) :- !,
    slice(List1, 1, N, List2).
slice(List1, N, M, List2) :- N =< M, !,
    N1 is N - 1,
    M1 is M - N + 1,
    split(List1, N1, _, List3),
    split(List3, M1, List2, _).
slice(_, _, _, []).

% P19
rotate(List, 0, List) :- !.
rotate(List1, N, List2) :- N > 0, !,
    split(List1, N, List3, List4),
    append(List4, List3, List2).
rotate(List1, N, List2) :-
    my_length(M, List1),
    N1 is M + N,
    rotate(List1, N1, List2).

% P20
remove_at(_, [], _, []).
remove_at(X, [X|T], 1, T) :- !.
remove_at(X, [H|T], N, [H|T1]) :-
    N1 is N - 1,
    remove_at(X, T, N1, T1).

% P21
insert_at(X, T, 1, [X|T]) :- !.
insert_at(X, [H|T], N, [H|T1]) :-
    N1 is N - 1,
    insert_at(X, T, N1, T1).


% P22
range(N, N, [N]) :- !.
range(N, M, [N|T]) :- N < M, !,
    N1 is N + 1,
    range(N1, M, T).
range(_, _, []).

% P23
rnd_select(List, 0, []) :- is_list(List), !.
rnd_select(List1, N, List2) :- is_list(List1), !,
    N1 is N - 1,
    length(List1, M),
    R is random(M-1) + 1,
    remove_at(X, List1, R, T),
    rnd_select(T, N1, T1),
    List2 = [X|T1].

% P24
rnd_select(N, M, List) :- number(N), number(M),
    range(1, M, List1),
    rnd_select(List1, N, List).

