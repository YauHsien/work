
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
