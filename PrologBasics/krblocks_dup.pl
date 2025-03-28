% The Blocks Domain
% Three blocks a,b,c
% There are four positions where the three blocks can be placed.
% A position or block is considered clear if it has no block on top of it.
% Initially, Block a is on Position 1, Block b is on Position 3, and Block c is on Block a.
% The robot has the ability to move a clear block from its current position to a new clear position or a new clear block

% Ignore warnings
:- discontiguous on/3.
:- discontiguous clear/2.

% Declaration of blocks
block(a). 
block(b). 
block(c). 

% Declaration of places (positions where the blocks are)
place(1). 
place(2).
place(3).
place(4).

% Fluents that represent the state of the blocks
clear(2,[]).
clear(4,[]).
clear(b,[]).
clear(c,[]).
on(a,1,[]).
on(b,3,[]).
on(c,a,[]).

% precondition axiom
% poss([move(Block,From,To)]) where a move is possible if the block is clear, 
% the block is not on the same position as the destination, 
% the destination is clear, and the block is on the source position.
poss([move(Block,From,To)|S]):- 
    block(Block), 
    clear(Block,S), 
    (place(To);block(To)), 
    Block \= To, 
    clear(To,S), 
    (place(From);block(From)), on(Block,From,S).

% successor axioms (when the fluents are true)
% Block/Position X is clear if the move involving X is possible
clear(X,[move(_,X,_)|S]):- 
    poss([move(_,X,_)|S]).

% Block is clear if no action in the plan blocks it
clear(X,[A|S]):- 
    poss([A|S]), 
    A \= move(_,_,X),clear(X,S).

% If block X is moved onto block Y, then X is on Y
on(X,Y,[move(X,Z,Y)|S]):- 
    poss([move(X,Z,Y)|S]).

% If the move is not involving block X on Y, check the rest of the plan
on(X,Y,[A|S]):- 
    poss([A|S]), 
    A \= move(X,Y,_),on(X,Y,S).

% to see increasing length of plan, use query plan(true,S).
plan(Goal,Plan):-
    bposs(Plan),Goal.

% Start the process of checking possible plans
bposs(S) :- tryposs([],S).

% tryposs(S,S) :- poss(S).
% % If the plan is valid, print it
tryposs(S,S) :- poss(S),write(S).   % print the plan so far

%% If the plan is not yet complete, try adding more actions to it
tryposs(X,S) :- tryposs([_|X],S).   %plan gets longer

% Queries or Goal states 
% ?- plan(on(a,2,S),S).
% ?- plan(on(a,3,S),S).