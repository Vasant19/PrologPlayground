% The Blocks Domain
% Three blocks a,b,c
% There are four positions where the three blocks can be placed.
% A position or block is considered clear if it has no block on top of it.
% Initially, Block a is on Position 1, Block b is on Position 3, and Block c is on Block a.
% The robot has the ability to move a clear block from its current position to a new clear position or a new clear block

% Hanlding discontiguous predicates as they are defined in different parts of the code
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
on(a, 1, s).  % Block a is on Position 1
on(b, 3, s).  % Block b is on Position 3
on(c, a, s).   % Block c is on Block a

% Clear positions and blocks in situation s
clear(b, s).   % Block b has nothing on top
clear(c, s).   % Block c has nothing on top
clear(2, s).  % Position 2 is empty/clear
clear(4, s).  % Position 4 is empty/clear


% Precondition Axiom that states under which condition is action possible
% poss(Action, Situation) - Defines when an action is possible in a given situation S
poss(move(B, From, To), S) :-  
    block(B),               % The block must be a block
    clear(B, S),            % The block itself must be clear  
    clear(To, S),           % The destination must be clear  
    on(B, From, S),         % The block must actually be on From  
    dif(B, To),             % A block cannot move onto itself  
    dif(From, To).          % A block must move to a different location  

% move_to(B, From, To, Situation): Moves Clear block "B" from "From" current position to "To" in Situation "S"
move(B, From, To, S) :-  
    poss(move(B, From, To), S).  % Ensure move is only executed when possible using Precondition axiom

% Successor State Axiom that defines the state of the world after an action is executed
