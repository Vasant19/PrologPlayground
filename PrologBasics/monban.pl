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

% The monkey is an agent
monkey(monkey).

% The box is an object
box(box).

monkeyplace(middle).
monkeyplace(at_door).
monkeyplace(at_window).
% Possible monkey positions
monkeyverticalposition(on_floor).
monkeyverticalposition(on_box).

box_position(middle).
box_position(at_door).
box_position(at_window).

% Possible banana possession states
possession(has).
possession(has_not).


% Actions: action/3 where (Successor Axioms, Action, Precondition Axioms)
% Action: grab
% The monkey can grab the bananas only if it is on the box and in the correct location.
monkey_state(state(middle, on_box, middle, has), 
[grab|S]) :-
    monkey_state(state(middle, on_box, middle, has_not), S).

% Action: climb
% The monkey climbs onto the box if it is on the floor and the box is at the same location.
monkey_state(state(P, on_box, P, H), 
[climb|S]) :-
    monkey_state(state(P, on_floor, P, H), S).

% Action: push
% The monkey pushes the box from location P1 to P2 when on the floor.
monkey_state(state(P2, on_floor, P2, H), 
[push(P1, P2)|S]) :-
    monkey_state(state(P1, on_floor, P1, H), S).

% Action: walk
% The monkey walks from location P1 to P2 while remaining on the floor.
monkey_state(state(P2, on_floor, B, H), 
[walk(P1, P2)|S]) :-
    monkey_state(state(P1, on_floor, B, H), S).

% The Initial State: monkey is at the door, on the floor, box is athe the middle and has not the bananas.
monkey_state(state(at_door, on_floor, middle, has_not), []).

% --- Planning Section ---
% The plan/2 predicate generates a plan (a list of actions)
% that, when “read” via monkey_state/2, yields a state matching the goal pattern.
plan(goal(StatePattern), Plan) :-
    bposs(Plan),
    monkey_state(State, Plan),
    State = StatePattern,
    write('Plan found: '), write(Plan), nl.

% bposs/1 starts with an empty plan and gradually “increases” its length.
bposs(S) :-
    tryposs([], S).

% tryposs(CurrentPlan, Plan) succeeds when the plan is complete.
tryposs(S, S) :-
    monkey_state(_, S),
    write('Current plan: '), write(S), nl.
% Otherwise, extend the plan by one (anonymous) action and try again.
tryposs(X, S) :-
    tryposs([_|X], S).
