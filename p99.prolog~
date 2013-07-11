:- module(p99, [last/2, lastButOne/2, element_at/3, number_elem/2, reverse/2,
		palindrome/1, flatten/2, compress/2, pack/2, encode/2,
		encode_modified/2, decode/2, encode_direct/2, dupli/2]).

%1
last([X], X) :- !.
last([_|T], X) :-
	last(T, X).

%2
lastButOne([X,_], X) :- !.
lastButOne([_|T], X) :- [_,_|_] = T, !,
	lastButOne(T, X).

%3
element_at(X, [X|_], 1) :- !.
element_at(X, [_|T], K) :- K > 1, !,
	K_1 is K-1,
	element_at(X, T, K_1).

%4
number_elem(List, N) :-
	number_elem(List, 0, N).
number_elem([], N, N).
number_elem([_|T], A, N) :-
	A1 is A+1,
	number_elem(T, A1, N).

%5
reverse(List, RevList) :-
	reverse(List, [], RevList).
reverse([], RevList, RevList).
reverse([H|T], A, RevList) :-
	reverse(T, [H|A], RevList).

%6
palindrome(List) :-
	reverse(List, List).

%7
flatten(List, FlatList) :-
	flatten(List, [], FlatList).
flatten([], RevFlatList, FlatList) :-
	reverse(RevFlatList, FlatList).
flatten([H|T], A, FlatList) :- is_list(H), !,
	flatten(H, H1),
	reverse(H1, H2),
	append(H2, A, A1),
	flatten(T, A1, FlatList).
flatten([H|T], A, FlatList) :-
	flatten(T, [H|A], FlatList).

%8
compress([], []).
compress([H|[]], [H]) :- !.
compress([H|[H|T]], Result) :- !,
	compress([H|T], Result).
compress([H|[H1|T]], [H|Result1]) :-
	compress([H1|T], Result1).

%9
pack(List, PackList) :-
	pack(List, [], PackList).
pack([], RevPackList, PackList) :-
	lists:reverse(RevPackList, PackList).
pack([H|T], [], PackList) :- !,
	pack(T, [[H]], PackList).
pack([H|T], [[H|T1]|T2], PackList) :- !,
	pack(T, [[H,H|T1]|T2], PackList).
pack([H|T], A, PackList) :-
	pack(T, [[H]|A], PackList).

%10
encode(List, LenList) :-
	p99:pack(List, PackList),
	count(PackList, LenList).
count(PackList, LenList) :-
	count(PackList, [], LenList).
count([], RevLenList, LenList) :-
	lists:reverse(RevLenList, LenList).
count([[H|T1]|T], A, LenList) :-
	lists:length([H|T1], L),
	count(T, [[L,H]|A], LenList).

%11
encode_modified(List, LenList) :-
	p99:pack(List, PackList),
	count_modified(PackList, LenList).
count_modified(PackList, LenList) :-
	count_modified(PackList, [], LenList).
count_modified([], RevLenList, LenList) :-
	lists:reverse(RevLenList, LenList).
count_modified([[H]|T], A, LenList) :- !,
	count_modified(T, [H|A], LenList).
count_modified([[H|T1]|T], A, LenList) :-
	lists:length([H|T1], L),
	count_modified(T, [[L,H]|A], LenList).

%12
decode([], []).
decode([H|T], Result) :-
	expand(H, H1),
	decode(T, T1),
	lists:append(H1, T1, Result).
expand(EncItem, DecItem) :-
	expand(EncItem, [], DecItem).
expand([], DecItem, DecItem).
expand([1,H], A, DecItem) :-
	expand([], [H|A], DecItem).
expand([N,H], A, DecItem) :- N > 1, !,
	N_1 is N-1,
	expand([N_1,H], [H|A], DecItem).
expand(H, A, DecItem) :- not(is_list(H)), !,
	expand([1,H], A, DecItem).

%13
encode_direct(List, EncList) :-
	encode_direct(List, [], EncList).
encode_direct([], RevEncList, EncList) :-
	lists:reverse(RevEncList, EncList).
encode_direct([H|T], [], EncList) :- !,
	encode_direct(T, [H], EncList).
encode_direct([H|T], [H|T1], EncList) :- !,
	encode_direct(T, [[2,H]|T1], EncList).
encode_direct([H|T], [[N,H]|T1], EncList) :- !,
	N1 is N+1,
	encode_direct(T, [[N1,H]|T1], EncList).
encode_direct([H|T], [H1|T1], EncList) :- !,
	encode_direct(T, [H,H1|T1], EncList).

%14
dupli([], []).
dupli([H|T], [H,H|T1]) :-
	dupli(T, T1).


