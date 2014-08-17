%% @Auther Yau-Hsien Huang
%% Puzzle: http://www.brainbashers.com/showpuzzles.asp?puzzle=ZUYK
%% After a local art theft, six suspects were being interviewed.
%% Below is a summary of their statements.
%% Police know that exactly four of them told one lie each and all of the other statements are true.
%% From this information can you tell who committed the crime?

said('Alan', was_not('Brian')).
said('Alan', was_not('Dave')).
said('Alan', was_not('Eddie')).
said('Brian', was_not('Alan')).
said('Brian', was_not('Charlie')).
said('Brian', was_not('Eddie')).
said('Charlie', was_not('Brian')).
said('Charlie', was_not('Freddie')).
said('Charlie', was_not('Eddie')).
said('Dave', was_not('Alan')).
said('Dave', was_not('Freddie')).
said('Dave', was_not('Charlie')).
said('Eddie', was_not('Charlie')).
said('Eddie', was_not('Dave')).
said('Eddie', was_not('Freddie')).
said('Freddie', was_not('Charlie')).
said('Freddie', was_not('Dave')).
said('Freddie', was_not('Alan')).

lie_on(theft(Person), Sayer, Person) :-
    said(Sayer, was_not(Person)).

reason(theft(Person)) :-
    lie_on(theft(Person), A, Person),
    lie_on(theft(Person), B, Person),
    lie_on(theft(Person), C, Person),
    lie_on(theft(Person), D, Person),
    A \= B,
    A \= C,
    A \= D,
    B \= C,
    B \= D,
    C \= D, !.

