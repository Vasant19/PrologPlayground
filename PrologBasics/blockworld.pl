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
% clear(Block, [])
% Block is clear in the initial state which is a list of actions that are empty.
clear(2 , []).
clear(4 , []).
clear(b , []).
clear(c , []).

% on(Block, Position, []) 
% Block is on Position in the initial state which is a list of actions that are empty. 

on(a,1,[]).
on(b,3,[]).
on(c,a,[]).

% Precondition Axiom
% poss([move(Block,From,To)])
% A move is possible if the block is clear, the block is not on the same position as the destination, the destination is clear, and the block is on the source position.
poss([move(Block,From,To)]):-
    block(Block),
    clear(Block,[]),
    (place(To);block(To)),
    Block \= To,
    clear(To,[]),
    (place(From);block(From)),
    on(Block,From,[]).


% Successor Axiom - What happens when we move a block
% move_block(Block, From, To)
% Move a block from one position to another
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

% ---------------------------
% Planning Procedure:
% plan(Goal, Plan) is true if Plan (an action history) leads to a state where Goal is true.
% For simplicity, we use a naive breadth-first search for sequences of actions.
% ---------------------------

% Define which moves are relevant based on the Goal.
% if the goal is on(a, _, []), then only moves involving a or c are considered.
relevant_move(Goal, Block) :-
    Goal = on(a, _, []),
    (Block = a ; Block = c).

% A planning-specific wrapper for poss/1 that filters moves by relevance.
poss_plan(Goal, [move(Block, From, To)]) :-
    poss([move(Block, From, To)]),
    relevant_move(Goal, Block).

% Planning Procedure: Depth-Limited Search using poss_plan/2.
plan(Goal, Plan) :-
    between(0, 5, Depth),
    depth_plan(Goal, Plan, Depth).

depth_plan(Goal, [], _) :-
    call(Goal).

depth_plan(Goal, [move(Block, From, To) | Rest], Depth) :-
    Depth > 0,
    poss_plan(Goal, [move(Block, From, To)]),
    move_block(Block, From, To),
    NewDepth is Depth - 1,
    depth_plan(Goal, Rest, NewDepth).
% ---------------------------
% Goal States (in terms of fluents):
%
% To move Block a to Position 2:
%    The goal is: on(a, 2, []).
%
% To move Block a to Position 3:
%    The goal is: on(a, 3, []).
%
% (These goals express that in the final state, block a is at the desired position.)
% ---------------------------

% Example queries:
% ?- plan(on(a,2,[]), Plan).
% ?- plan(on(a,3,[]), Plan).