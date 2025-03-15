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
% B: vertical ocation of monkey (onfloor, onbox)
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

move(State1, Action, State2).



% Initial State: Monkey is at the middle, on the floor, box is in the middle, 
% and monkey does not have bananas
state(atdoor, on_floor, middle, has_not)



% Goal state
% the monkey should have the bananas in the end no matter where it is or where the box is
goal(state(_,_,_,has)).
