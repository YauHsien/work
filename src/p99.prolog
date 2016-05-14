
% Problem set is at
% http://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/

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
rnd_select([], _, []) :- !.
rnd_select(List1, N, List2) :- is_list(List1), !,
    N1 is N - 1,
    length(List1, M),
    R is random(M) + 1,
    remove_at(X, List1, R, T),
    rnd_select(T, N1, T1),
    List2 = [X|T1].

% P24
rnd_select(N, M, List) :- number(N), number(M),
    range(1, M, List1),
    rnd_select(List1, N, List).

% P25
rnd_permu(List1, List2) :-
    my_length(N, List1),
    rnd_select(List1, N, List2).

% P26
combination(0, _, []) :- !.
combination(N, List, [H|T]) :-
    my_length(L, List),
    range(1, L, S),
    member(Ih, S),
    remove_at(H, List, Ih, List1),
    N1 is N - 1,
    combination(N1, List1, T).

% P27
group3(List, Group1, Group2, Group3) :-
    combination(3, [2,3,4], [N1, N2, N3]),
    split(List, N1, Group1, List1),
    split(List1, N2, Group2, List2),
    split(List2, N3, Group3, _).

group(List1, Ns, List2) :-
    my_length(L, Ns),
    combination(L, Ns, Ns1),
    group_N(List1, Ns1, List2).

group_N(_, [], []).
group_N(List1, [N|Ns], [List2|List3]) :-
    split(List1, N, List2, List4),
    group_N(List4, Ns, List3).

% P28
lsort(List1, List2) :-
    my_length(L, List1),
    combination(L, List1, List2),
    length_sorted(List2).

length_sorted([]).
length_sorted([_]) :- !.
length_sorted([H1,H2|T]) :-
    my_length(N1, H1),
    my_length(N2, H2),
    N1 =< N2,
    length_sorted([H2|T]).

lfsort(List1, List2) :-
    lsort(List1, List3),
    findall(L, (member(X, List3), my_length(L, X)), List4),
    pack(List4, List5),
    lsort(List5, List6),
    findall(X, (member([Y|_], List6),
		findall(Z, (member(Z, List1), my_length(Y, Z)),
			X)),
	    List7),
    append(List7, List2).

% P31
is_prime(1) :- !.
is_prime(N) :- N > 1,
    test_if_prime(2, N).

test_if_prime(M, N) :-
    M * M > N, !.
test_if_prime(M, N) :-
    N rem M =:= 0, !,
    fail.
test_if_prime(M, N) :-
    M1 is M + 1,
    test_if_prime(M1, N).

% P32
gcd(G, 0, G) :- !.
gcd(N, M, G) :- N < M, !,
    gcd(M, N, G).
gcd(N, M, G) :- M > 0,
    N1 is N rem M,
    gcd(M, N1, G).

% P33
coprime(N, M) :-
    gcd(N, M, 1).

% P34
% By using arithmetic_function/1, functions can be created
% in SWI.
% But note that the artithmetic_function/1 is deprecated now.
:- arithmetic_function(totient_phi/1).
totient_phi(M, P) :-
    M1 is M - 1,
    totient_phi(M, M1, P).

totient_phi(_, 1, 1) :- !.
totient_phi(N, M, P) :- M > 1, coprime(N, M), !,
    M1 is M - 1,
    totient_phi(N, M1, P1),
    P is P1 + 1.
totient_phi(N, M, P) :- M > 1,
    M1 is M - 1,
    totient_phi(N, M1, P).

% P35
prime_factors(N, L) :-
    prime_factors(N, L, 2).

prime_factors(N, [N], M) :- N > 0, M * M > N, !.
prime_factors(N, [M|L], M) :- N > 0,
    1 < M,
    M * M =< N,
    is_prime(M),
    N rem M =:= 0, !,
    N1 is N div M,
    prime_factors(N1, L, M).
prime_factors(N, L, M) :- N > 0,
    M1 is M + 1,
    prime_factors(N, L, M1).

% P36
prime_factors_multi(N, L) :-
    prime_factors_multi(N, L, 2).

prime_factors_multi(N, [[N,1]], M) :- N > 0, M * M > N, !.
prime_factors_multi(N, L, M) :- N > 0,
    1 < M,
    N rem M =\= 0, !,
    M1 is M + 1,
    prime_factors_multi(N, L, M1).
prime_factors_multi(N, [[M,X]|L], M) :- N > 0,
    N1 is N div M,
    prime_factors_multi(N1, [[M,X1]|L], M), !,
    X is X1 + 1.
prime_factors_multi(N, [[M,1]|L], M) :- N > 0,
    N1 is N div M,
    prime_factors_multi(N1, L, M).

% P37
:- arithmetic_function(totient_phi_improved/1).
totient_phi_improved(M, P) :-
    prime_factors_multi(M, L),
    calculate_totient_phi(L, P).

calculate_totient_phi([], 1).
calculate_totient_phi([[N,M]|T], P) :-
    calculate_totient_phi(T, P1),
    P is P1 * (N-1) * (N ^ (M-1)).

% P38
measure1(N) :-
    statistics(inferences, I1),
    _ is totient_phi(10090),
    statistics(inferences, I2),
    N is I2 - I1.

measure2(N) :-
    statistics(inferences, I1),
    _ is totient_phi_improved(10090),
    statistics(inferences, I2),
    N is I2 - I1.

% P39
prime_numbers(N, M, []) :- N > M, !.
prime_numbers(N, M, [N|L]) :- is_prime(N), !,
    N1 is N + 1,
    prime_numbers(N1, M, L).
prime_numbers(N, M, L) :-
    N1 is N + 1,
    prime_numbers(N1, M, L).

% P40
goldbach(N, [X,Y]) :- N > 0, N rem 2 =:= 0,
    N1 is N div 2,
    prime_numbers(1, N1, R),
    member(X, R),
    Y is N - X,
    is_prime(Y).

% P41
goldbach_list(N, M) :- N =< M,
    goldbach(N, [X,Y]), !,
    format("~p = ~p + ~p~n", [N, X, Y]),
    N1 is N + 1,
    goldbach_list(N1, M).
goldbach_list(N, M) :- N =< M,
    N1 is N + 1,
    goldbach_list(N1, M).

goldbach_list(N, M, Limit) :- N =< M,
    goldbach(N, [X,Y]), X >= Limit, !,
    format("~p = ~p + ~p~n", [N, X, Y]),
    N1 is N + 1,
    goldbach_list(N1, M, Limit).
goldbach_list(N, M, Limit) :- N =< M,
    N1 is N + 1,
    goldbach_list(N1, M, Limit).

% P46
and(A, B) :- A, B.

or(A, B) :- A; B.

nand(A, B) :- A, B, !, fail.
nand(_, _).

nor(A, _B) :- A, !, fail.
nor(_A, B) :- B, !, fail.
nor(_, _).

xor(A, B) :- or(A, B), A \= B.

impl(A, B) :- not(A); B.

equ(A, B) :- impl(A, B), impl(B, A).

table(A, B, R) :-
    member(A, [true, false]),
    member(B, [true, false]),
    format("~w ~w", [A, B]),
    (R -> R1 = true; R1 = false),
    format(" ~w~n", [R1]).

% P47
:- op(910, fx, not).
:- op(920, yfx, and).
:- op(930, yfx, or).
:- op(920, yfx, nand).
:- op(930, yfx, nor).
:- op(950, yfx, impl).
:- op(950, yfx, equ).
:- op(950, yfx, xor).

% P48
table(List, R) :-
    bind(List),
    print_with_space(List),
    (R -> R1 = true; R1 = false),
    format("~w~n", [R1]).

bind([]).
bind([H|T]) :- not(ground(H)),
    member(H, [true, false]),
    bind(T).

print_with_space([]).
print_with_space([H|T]) :-
    format("~w ", [H]),
    print_with_space(T).

% P49
gray(N, C) :-
    C1 = [[48], [49]],
    gray(N, C, C1, c(1, C1)).

gray(N, C, _, c(N, C1)) :- !,
    findall(X, (combination(1, C1, [Y]), atom_codes(X, Y)), C).
gray(N, C, C1, c(M, Cm)) :- N > M,
    M1 is M + 1,
    findall(X, (combination(1, C1, [Y]), combination(1, Cm, [Z]),
		append(Y, Z, X)),
	    Cm1),
    gray(N, C, C1, c(M1, Cm1)).

% P50
huffman(Fs, Hs) :-
    sort_fs_list(Fs, Fs1),
    huffman1(Fs1, Fr),
    apply_hc(Fr, Hs1),
    findall(hc(X,Y), (member(fr(X,_), Fs), member(hc(X,Y), Hs1)), Hs).

sort_fs_list(Fs, List) :-
    sort_fs_list(Fs, [], List).

sort_fs_list([], List, List).
sort_fs_list([H|T], List1, List2) :-
    insert_sort(H, List1, List3),
    sort_fs_list(T, List3, List2).

insert_sort(E, [], [E]).
insert_sort(fr(S,F), [fr(S1,F1)|T], [fr(S,F),fr(S1,F1)|T]) :- F =< F1, !.
insert_sort(fr(S,F), [fr(S1,F1)|T], [fr(S1,F1)|T1]) :- F > F1,
    insert_sort(fr(S,F), T, T1).

huffman1([Fr], Fr).
huffman1(Fs, Fs1) :- Fs = [_,_|_],
    split(Fs, 2, Fs2, Fs3),
    [fr(_,F1), fr(_,F2)] = Fs2,
    F3 is F1 + F2,
    insert_sort(fr(Fs2, F3), Fs3, Fs4),
    huffman1(Fs4, Fs1).

apply_hc(fr(List1,_), List2) :- is_list(List1),
    apply_hc(List1, List3),
    findall(hc(X, Y), (member(hc(X, Z), List3), atom_codes(Y, Z)), List2).
apply_hc([LT,RT], List) :-
    apply_hc(LT, [48], List1),
    apply_hc(RT, [49], List2),
    append(List1, List2, List).

apply_hc(fr(List1,_), Tag, List2) :- is_list(List1), !,
    apply_hc(List1, List3),
    findall(hc(X,Y), (member(hc(X,Z), List3), append(Tag, Z, Y)), List2).
apply_hc(fr(S,_), Tag, [hc(S,Tag)]).

% P54
istree(nil).
istree(t(_,L,R)) :-
    istree(L),
    istree(R).

% P55
cbal_tree(0, nil).
cbal_tree(1, t(x, nil, nil)).
cbal_tree(2, t(x, nil, RT)) :-
    cbal_tree(1, RT).
cbal_tree(2, t(x, LT, nil)) :-
    cbal_tree(1, LT).
cbal_tree(N, t(x, LT, RT)) :- N > 2,
    N1 is N - 1,
    N2 is N1 div 2,
    N3 is N1 - N2,
    cbal_tree(N2, LT),
    cbal_tree(N3, RT).

% P56
symmetric(nil).
symmetric(t(_, LT, RT)) :-
    mirror(LT, RT).

mirror(nil, nil).
mirror(t(_, LT1, RT1), t(_, LT2, RT2)) :-
    mirror(LT1, RT2),
    mirror(RT1, LT2).

% P57
construct(List, Tree) :-
    construct(List, nil, Tree).

construct([], Tree, Tree).
construct([H|T], Tree, Tree1) :-
    add(H, Tree, Tree2),
    construct(T, Tree2, Tree1).

add(X, nil, t(X, nil, nil)).
add(X, t(Y, LT, RT), t(Y, LT, RT1)) :- X >= Y, !,
    add(X, RT, RT1).
add(X, t(Y, LT, RT), t(Y, LT1, RT)) :-
    add(X, LT, LT1).

test_symmetric(List) :-
    construct(List, Tree),
    symmetric(Tree).

% P58
sym_cbal_trees(N, Ts) :-
    findall(T, (cbal_tree(N, T), symmetric(T)), Ts).

% P59
hbal_tree(0, nil).
hbal_tree(N, t(x, LT, RT)) :- N > 1,
    N1 is N - 1,
    N2 is N - 2,
    hbal_tree(N2, LT),
    hbal_tree(N1, RT).
hbal_tree(N, t(x, LT, RT)) :- N > 1,
    N1 is N - 1,
    N2 is N - 2,
    hbal_tree(N1, LT),
    hbal_tree(N2, RT).
hbal_tree(N, t(x, LT, RT)) :- N > 0,
    N1 is N - 1,
    hbal_tree(N1, LT),
    hbal_tree(N1, RT).

% P60
hbal_tree_nodes(0, nil).
hbal_tree_nodes(N, t(x, LT, RT)) :- N > 0,
    N1 is N - 1,
    addNodes(N2, N3, N1),
    maxHeight(N2, H1),
    maxHeight(N3, H2),
    (H1 =:= H2; H1 =:= H2 + 1; H1 + 1 =:= H2),
    minNodes(H1, N2),
    minNodes(H2, N3),
    hbal_tree_nodes(N2, T1),
    hbal_tree_nodes(N3, T2),
    (T1 \= T2, (LT = T1, RT = T2; LT = T2, RT = T1);
     T1 == T2, LT = T1, RT = T2).

count_hbal_trees_nodes(N, C) :-
    setof(T, hbal_tree_nodes(N, T), L),
    my_length(C, L).

minNodes(H, H) :- H =< 1, !.
minNodes(H, N) :-
    H1 is H - 1,
    H2 is H - 2,
    minNodes(H1, N1),
    minNodes(H2, N2),
    N is 1 + N1 + N2.

maxHeight(N, N) :- N =< 2, !.
maxHeight(N, H) :-
    N1 is N - 1,
    addNodes(N2, N3, N1),
    maxHeight(N2, H1),
    maxHeight(N3, H2),
    (H1 =:= H2 + 1, !, H is H1 + 1;
     H1 + 1 =:= H2, !, H is H2 + 1;
     H1 =:= H2, !, H is H1 + 1).

addNodes(N, M, S) :-
    S1 is S div 2,
    range(0, S1, Ss),
    member(N, Ss),
    M is S - N.

% P61
count_leaves(nil, 0) :- !.
count_leaves(t(_, nil, nil), 1) :- !.
count_leaves(t(_, LT, RT), N) :-
    count_leaves(LT, N1),
    count_leaves(RT, N2),
    N is N1 + N2.

% P61A
leaves(nil, []) :- !.
leaves(t(X, nil, nil), [X]) :- !.
leaves(t(_, LT, RT), List) :-
    leaves(LT, List1),
    leaves(RT, List2),
    append(List1, List2, List).

% P62
internals(nil, []) :- !.
internals(t(_, nil, nil), []) :- !.
internals(t(X, LT, RT), [X|List]) :-
    internals(LT, List1),
    internals(RT, List2),
    append(List1, List2, List).

% P62B
atlevel(nil, _, []) :- !.
atlevel(t(X, _, _), 1, [X]) :- !.
atlevel(_, N, []) :- N < 1, !.
atlevel(t(_, LT, RT), N, List) :- N > 1,
    N1 is N - 1,
    atlevel(LT, N1, List1),
    atlevel(RT, N1, List2),
    append(List1, List2, List).

% P63
complete_binary_tree(N, T) :-
    complete_binary_tree(N, 1, T).

complete_binary_tree(TotalN, AddressM, nil) :- TotalN < AddressM, !.
complete_binary_tree(TotalN, AddressM, t(AddressM, LT, RT)) :-
    M1 is 2 * AddressM,
    M2 is M1 + 1,
    complete_binary_tree(TotalN, M1, LT),
    complete_binary_tree(TotalN, M2, RT).

% P64
layout_binary_tree(T, PT) :-
    layout_binary_tree(T, PT, 1, _Width, 1).

% (+, -, +, -, +)
layout_binary_tree(nil, nil, _, 0, _).
layout_binary_tree(t(W, LT, RT), t(W, X, Y, LT1, RT1), Left, Width, Height) :-
    Height1 is Height + 1,
    layout_binary_tree(LT, LT1, Left, Width1, Height1),
    X is Left + Width1,
    Left1 is X + 1,
    layout_binary_tree(RT, RT1, Left1, Width2, Height1),
    Y is Height,
    Width is Width1 + 1 + Width2.

% P65
layout_binary_tree_2(T, PT) :-
    tree_height(T, H),
    layout_binary_tree_2(T, PT, 1, H, 1).

% (+, -)
tree_height(nil, 0).
tree_height(t(_, LT, RT), H) :-
    tree_height(LT, H1),
    tree_height(RT, H2),
    (H1 > H2, !, H is H1 + 1;
     H is H2 + 1).

% (+, -, +, +, +)
layout_binary_tree_2(nil, nil, _, _, _).
layout_binary_tree_2(t(W, LT, RT), t(W, X, Y, LT1, RT1), Left, Height, Level) :-
    Level1 is Level + 1,
    layout_binary_tree_2(LT, LT1, Left, Height, Level1),
    Distance is 2 ** (Height - Level) div 2,
    (nil = LT1, X is Left;
     t(_, X1, _, _, _) = LT1, X is X1 + Distance),
    Y is Level,
    Left1 is X + 1,
    layout_binary_tree_2(RT, RT2, Left1, Height, Level1),
    (nil = RT2, Offset is Distance + 1;
     t(_, X2, _, _, _) = RT2, Offset is Distance - X2 + 1),
    move_right(RT2, Offset, RT1).

% (+, +, -)
move_right(nil, _, nil).
move_right(t(W, X, Y, LT, RT), N, t(W, X1, Y, LT1, RT1)) :-
    X1 is X + N,
    move_right(LT, N, LT1),
    move_right(RT, N, RT1).
