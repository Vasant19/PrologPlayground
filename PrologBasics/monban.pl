% Monkey and Banana problem
% • There is a monkey, a single bunch of bananas (or one banana, if you prefer), and a box
% • The monkey, box, and bananas are each at different locations to start
% • The bananas are hanging too high for the monkey to reach, but if the monkey climbs on top of the box, the monkey can grab the bananas
% • The monkey is analogous to a robot with the following basic functionality:
%        ◦ The monkey can go to a specific location
%        ◦ The monkey can push the box to a specific location
%        ◦ The monkey can climb onto and climb off the box
%        ◦ If the conditions are right, the monkey can grab the bananas
% • The monkey needs to plan a sequence of actions that will result in achieving the goal: the monkey having the bananas

% state(A,B,C,D)
% A: horizontal location of monkey (middle, atdoor, atwindow)
% B: vertical Location of monkey (onfloor, onbox)
% C: position of box (middle, atdoor, atwindow)
% D: monkey has or not the bananas (has, hasnot)

% Defining objects in the domain
% Possible locations in the world
place(middle).
place(at_door).
place(at_window).

box_position(middle).
box_position(at_door).
box_position(at_window).

% The monkey is an agent
monkey(monkey).

% The box is an object
box(box).

% The bananas exist
bananas(bananas).

% Possible monkey positions
monkeyposition(on_floor).
monkeyposition(on_box).

% Possible banana possession states
possession(has).
possession(has_not).

% Actions
% Action 1: Monkey can grab the bananas if it is on the box and does not have the bananas
move(state(middle , on_box, middle , has_not),
grab,
state(middle, on_box, middle, has)).

% Action 2: Monkey can climb on the box if it is on the floor and the box is in the same location
move(state(P, on_floor, P, H),
climb,
state(P, on_box, P, H)).

% Action 3: Monkey can push the box to a location if it is on the floor and the box is in the same location
move(state(P1, on_floor, P1, H), 
push(P1, P2),
state(P2, on_floor, P2, H)).

% Action 4: Monkey can walk to a location if it is on the floor
move(state(P1, on_floor, B, H),
walk(P1, P2),
state(P2, on_floor, B, H)).

% Goal state
% the monkey should have the bananas in the end no matter where it is or where the box is
goal(state(_,_,_,has)).

goal(State1) :- move(State1,Move, State2), goal(State2).


% Initial State: Monkey is at the middle, on the floor, box is in the middle, 
% and monkey does not have bananas
initial_state(state(at_door, on_floor, middle, has_not)).






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













%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Queries to test the program
% 1. initial_state(State).

% Check if the monkey can climb on the box
% 2. move(state(at_door, on_floor, at_door, has_not), climb, NewState).

% Check if the monkey can grab the bananas
% 3. move(state(middle, on_box, middle, has_not), grab, NewState).

% Check if the monkey can push the box
% 4. move(state(at_door, on_floor, at_door, has_not), push(at_door, middle), NewState).

% Check if the monkey can walk to a location
% 5. move(state(at_door, on_floor, middle, has_not), walk(at_door, at_window), NewState).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%