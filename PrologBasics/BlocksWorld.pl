% The Blocks Domain
% Three blocks a,b,c
% There are four positions where the three blocks can be placed.
% A position or block is considered clear if it has no block on top of it.
% Initially, Block a is on Position 1, Block b is on Position 3, and Block c is on Block a.
% The robot has the ability to move a clear block from its current position to a new clear position or a new clear block


% The State of the world
% Fluent: on(Block, Object, Situation)

% Initial positions of blocks in situation s
on(a, p1, s).  % Block a is on Position 1
on(b, p3, s).  % Block b is on Position 3
on(c, a, s).   % Block c is on Block a

% Clear positions and blocks in situation s
clear(b, s).   % Block b has nothing on top
clear(c, s).   % Block c has nothing on top
clear(p2, s).  % Position 2 is empty/clear
clear(p4, s).  % Position 4 is empty/clear


% move_to(B, From, To, Situation): Moves Clear block "B" from "From" current position to "To" in Situation "S"

move_to(B, From, To, S) :-
    clear(B, S),     % The block itself must be clear
    clear(To, S),        % The destination must be clear
    on(B, From, S).  % The block must actually be on From