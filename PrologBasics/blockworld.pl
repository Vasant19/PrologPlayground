% The Blocks Domain
% Three blocks a,b,c
% There are four positions where the three blocks can be placed.
% A position or block is considered clear if it has no block on top of it.
% Initially, Block a is on Position 1, Block b is on Position 3, and Block c is on Block a.
% The robot has the ability to move a clear block from its current position to a new clear position or a new clear block

% Hanlding discontiguous predicates as they are defined in different parts of the code
% The dynamic directive is used to declare that the predicate is dynamic, i.e., it can be modified at runtime.
:- dynamic on/3.
:- dynamic clear/2.
:- discontiguous on/3.
:- discontiguous clear/2.

% The State of the world

block(a).
block(b).
block(c).

place(1).
place(2).
place(3).
place(4).

% Fluent: on(Block, Object/Position, Situation)
% Fluent: clear(Object/Position, Situation)
% Initial positions of blocks in situation s
on(a, 1, []).  % Block a is on Position 1
on(b, 3, []).  % Block b is on Position 3
on(c, a, []).   % Block c is on Block a

% Clear positions and blocks in situation s
clear(b, []).   % Block b has nothing on top
clear(c, []).   % Block c has nothing on top
clear(2, []).  % Position 2 is empty/clear
clear(4, []).  % Position 4 is empty/clear

% Precondition Axiom that states under which condition is action possible
% poss(Action, Situation) - Defines when an action is possible in a given situation S
poss([move(B, From, To)|S]) :-  
    block(B),               % The block must be a block
    clear(B, S),            % The block itself must be clear  
    (place(To); block(To)), % The destination must be a place or a block
    dif(B, To),             % A block cannot move onto itself  
    clear(To, S),           % The destination must be clear
    (place(From); block(From)), % The source must be a place or a block
    on(B, From, S).     % The block must actually be on From  

% move(B, From, To, Situation): Moves Clear block "B" from "From" current position to "To" in Situation "S"
move(B, From, To, S) :-  
    poss(move(B, From, To), S).  % Ensure move is only executed when possible using Precondition axiom

% Successor State Axiom that defines the state of the world after an action is executed

% Successor state: Update the world after a move
move(B, From, To, S, S_new) :-
    poss(move(B, From, To), S),  % Ensure the move is possible
    % Remove the block from its current position
    retract(on(B, From, S)), % Remove the block from its current position
    assert(on(B, To, S_new)), % Add the block to the new position
    
    % Update the clear facts:

    % Remove the old clear facts from state S for the source and destination.
    retractall(clear(From, S)),
    retractall(clear(To, S)),
    
    % In the new state S_new:
    % 1. The source (From) becomes clear since block B has left.
    % 2. The destination (To) is now occupied by B, so we do not assert clear(To, S_new).
    % 3. Block B becomes clear because nothing is on top of it.
    assert(clear(From, S_new)),
    assert(clear(B, S_new)).


% Sample queries to check the implementation of the block world domain

% Check intial state of the world
% on(a, 1, s). % true.
% clear(2, s).


% test possiblity of a move 
% poss(move(a, 1, 2), s). % false.
% poss(move(b, 3, 4), s). % true.

% Peform a move
% move(b, 3, 4, s, S_new).

% Verify moved
% on(b, 4, S_new). % true.



%----------------------------------------
% PLANNING SECTION
%----------------------------------------

