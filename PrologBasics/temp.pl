block(a).
block(b).
block(c).

place(1).
place(2).
place(3).
place(4).

clear(2,[]).
clear(4,[]).
clear(b,[]).
clear(c,[]).
on(a,1,[]).
on(b,3,[]).
on(c,a,[]).

% Defines the move operation
move(Block, From, To) :- 
    block(Block),
    clear(Block, []),
    (place(To); block(To)),
    Block \= To,
    clear(To, []),
    (place(From); block(From)),
    on(Block, From, []).

% Check if move is possible
poss([move(Block, From, To) | S]) :- 
    block(Block),
    clear(Block, S),
    (place(To); block(To)),
    Block \= To,
    clear(To, S),
    (place(From); block(From)),
    on(Block, From, S).

% Check if a place is clear
clear(X, [move(_, X, _) | S]) :- poss([move(_, X, _) | S]).
clear(X, [A | S]) :-
    poss([A | S]),
    A \= move(_, _, X),
    clear(X, S).

% Check if an object is on a place
on(X, Y, [move(X, Z, Y) | S]) :- poss([move(X, Z, Y) | S]).
on(X, Y, [A | S]) :-
    poss([A | S]),
    A \= move(X, Y, _),
    on(X, Y, S).
