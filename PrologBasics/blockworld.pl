% The Blocks Domain
% Three blocks a,b,c
% There are four positions where the three blocks can be placed.
% A position or block is considered clear if it has no block on top of it.
% Initially, Block a is on Position 1, Block b is on Position 3, and Block c is on Block a.
% The robot has the ability to move a clear block from its current position to a new clear position or a new clear block

:- dynamic on/3.
:- dynamic clear/2.

% Initial State
block(a).
block(b).
block(c).

place(1).
place(2).
place(3).
place(4).

% Fluents 
clear(2 , []).
clear(4 , []).
clear(b , []).
clear(c , []).

on(a,1,[]).
on(b,3,[]).
on(c,a,[]).

% Precondition Axiom
poss([move(Block,From,To)]):-
  block(Block),
  clear(Block,[]),
  (place(To);block(To)),
  Block \= To,
  clear(To,[]),
  (place(From);block(From)),
  on(Block,From,[]).


% Successor Axiom - What happens when we move a block
move_block(Block, From, To) :-
    % Check if the move is possible
    poss([move(Block, From, To)]),
    
    % Update the state by removing old facts
    retractall(on(Block, From, [])),
    retractall(clear(To, [])),
    
    % Add new facts
    assert(on(Block, To, [])),
    assert(clear(From, [])),
    
    % Print the move for debugging
    format('Moved block ~w from ~w to ~w~n', [Block, From, To]).
