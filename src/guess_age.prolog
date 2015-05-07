-module(guess_age).

find(Set1) :-
    digit_in_tens(DitDigits),
    findall(N, (member(N, DitDigits), map_by_digit_in_tens(N, relation)), Set1).

numbers([35, 36, 38, 42, 45, 46, 51, 55, 57, 61, 62]).

digit_in_tens([3, 4, 5, 6]).

digit_in_ones([1, 2, 5, 6, 7, 8]).

not_deterministic([]) :- !, fail.
not_deterministic([_]) :- !, fail.
not_deterministic(_).

map_by_digit_in_tens(Digit, MapType) :-
    numbers(Numbers),
    setof(N,
	  ( member(N, Numbers),
	    DigitInTens is N div 10,
	    DigitInTens =:= Digit ),
	  Ns),
    map_type(Ns, MapType).

map_by_digit_in_ones(Digit, MapType) :-
    numbers(Numbers),
    setof(N,
	  ( member(N, Numbers),
	    DigitInOnes is N rem 10,
	    DigitInOnes =:= Digit ),
	  Ns),
    map_type(Ns, MapType).

map_type([], bottom) :- !.
map_type([_], function) :- !.
map_type(_, relation).
