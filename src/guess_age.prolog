-module(guess_age).

solve :- numbers(Numbers),            %% C 女士提出了一些數字做為選項， Numbers 為候選集合
	 digit_in_tens(DigitsInTens), %% C 女士告訴 A 先生她年齡的10位數，落在此變數 DigitInTens 中，
	 digit_in_ones(DigitsInOnes), %% C 女士告訴 B 先生她年齡的個位數，落在此變數 DigitInOnes 中，
	 %% --
	 findall(X, (member(X, DigitsInTens), map_by_digit_in_tens(Numbers, X, relation)), DigitsInTens),
         %% A 先生說：「我不知道 C 女士的年紀多大，
         %% --
	 findall(X, (member(X, DigitsInOnes), map_by_digit_in_ones(Numbers, X, relation)), DigitsInOnes1),
	 numbers_with_digit_in_ones(Numbers, DigitsInOnes1, Numbers1),
	 %% 但我肯定你也不知道。」 --> Numbers1 是新的候選集合
	 %% --
	 findall(X, (member(X, DigitsInOnes), map_by_digit_in_ones(Numbers1, X, relation)), DigitsInOnes1),
	 %% 「本來我不知道，」 B 先生說，
	 %% --
	 findall(X, (member(X, DigitsInOnes1), map_by_digit_in_ones(Numbers1, X, function)), DigitsInTens1),
	 %% 「可是現在我知道了。」 --> Numbers2 是新的候選集合
	 %% --
	 format("~p~n", [[DigitsInOnes1, Numbers1]]).
	 
%    %% 「哦，那我也知道了，科科。」 A 先生說。
%    findall(X, (member(X, DigitsInTens), map_by_digit_in_tens(Numbers3, X, function)), Numbers3).

numbers([35, 36, 38, 42, 45, 46, 51, 55, 57, 61, 62]).

digit_in_tens([3, 4, 5, 6]).

digit_in_ones([1, 2, 5, 6, 7, 8]).

map_by_digit_in_tens(Numbers, Digit, MapType) :-
    setof(N,
	  ( member(N, Numbers),
	    DigitInTens is N div 10,
	    DigitInTens =:= Digit ),
	  Ns),
    map_type(Ns, MapType).

map_by_digit_in_ones(Numbers, Digit, MapType) :-
    setof(N,
	  ( member(N, Numbers),
	    DigitInOnes is N rem 10,
	    DigitInOnes =:= Digit ),
	  Ns),
    map_type(Ns, MapType).

numbers_with_digit_in_tens(Numbers, Digits, Numbers1) :-
    findall(N,
	    ( member(N, Numbers),
	      DigitInTens is N div 10,
	      member(DigitInTens, Digits) ),
	    Numbers1).

numbers_with_digit_in_ones(Numbers, Digits, Numbers1) :-
    findall(N,
	    ( member(N, Numbers),
	      DigitInOnes is N rem 10,
	      member(DigitInOnes, Digits) ),
	    Numbers1).

map_type([], bottom) :- !.
map_type([_], function) :- !.
map_type([_,_|_], relation).
