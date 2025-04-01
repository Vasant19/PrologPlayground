%%%%%%%%%%%%%%%%%%%%% OVERVIEW %%%%%%%%%%%%%%%%%%%%%
% This Prolog program simulates a simple coffee-making process, where a robot plans to make a cup of instant coffee.  
% The robot will need to do the following things:
% Example process for making coffee:
% 1. Open a cupboard, take a cup from the cupboard, and place it on the counter.
% 2. Fill a kettle with water, and plug it in.
% 3. Wait for the water to boil.
% 4. Pour hot water into the cup.
% 5. Add instant coffee to the cup.
% 6. Stir the coffee to complete the process.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Simplified action representation to make planning easier and time-efficient
% 1) get_cup() - Open cupboard, take cup, place on counter
% 2) fill_kettle() - Fill kettle with water, plug it in, wait for it to boil
% 3) boil_kettle() - Wait for water to boil
% 4) pour_water() - Wait for water to boil, pour hot water into cup
% 5) add_coffee - Add instant coffee to cup
% 6) stir() - Stir the coffee to complete the process

%------------------------------------------------------
% Discontiguous declarations
%------------------------------------------------------
:- discontiguous poss/2.
:- discontiguous at/3.
:- discontiguous plugged_in/3.
:- discontiguous filled/3.
:- discontiguous boiled/3.
:- discontiguous contains/3.
:- discontiguous stirred/3.

%------------------------------------------------------
% Domain objects and places
%------------------------------------------------------
object(cup).
object(kettle).
object(robot).
object(hot_water).
object(coffee).
object(hot_water_and_coffee).

place(counter).
place(cupboard).

%------------------------------------------------------
% Initial state of the world
%------------------------------------------------------
at(cup, cupboard, []).
at(kettle, counter, []).
at(robot, counter, []).

plugged_in(kettle, n, []).
filled(kettle, n, []).
boiled(kettle, n, []).
contains(cup, n, []).
stirred(cup, n, []). % Also the goal state => stirred(cup, y, []).

% The kettle remains at the counter
at(kettle, Pos, [A|S]) :- 
    at(kettle, Pos, S).

% The robot remains at the counter
at(robot, Pos, [A|S]) :- 
    at(robot, Pos, S).

%------------------------------------------------------
% Define available actions in the domain
%------------------------------------------------------
action(get_cup).
action(fill_kettle).
action(boil_kettle).
action(pour_water).
action(add_coffee).
action(stir_coffee).

%------------------------------------------------------
% Action 1: get_cup
% Preconditions: The cup is in the cupboard and the robot is at the counter.
% Successor: The cup moves to the counter.
% Persistence: The cup remains at the counter.
%------------------------------------------------------
poss(get_cup, S) :- 
    at(cup, cupboard, S), 
    at(robot, counter, S).

at(cup, counter, [get_cup|S]) :- 
    poss(get_cup, S).

at(cup, Pos, [A|S]) :- 
    A \= get_cup,   % cup moved only by get_cup
    at(cup, Pos, S).


%------------------------------------------------------
% Action 2: fill_kettle
% Preconditions: The cup and kettle are on the counter and the robot is there.
% Successor: The kettle becomes plugged in and filled.
%------------------------------------------------------
poss(fill_kettle, S) :- 
    at(cup, counter, S),
    at(kettle, counter, S), 
    at(robot, counter, S).

plugged_in(kettle, y, [fill_kettle|S]) :- 
    poss(fill_kettle, S).

filled(kettle, y, [fill_kettle|S]) :- 
    poss(fill_kettle, S).

%------------------------------------------------------
% Action 3: boil_kettle
% Preconditions: The kettle is filled and plugged in, and the robot is at the counter.
% Successor: The kettle becomes boiled.
%------------------------------------------------------
poss(boil_kettle, S) :- 
    filled(kettle, y, S),
    plugged_in(kettle, y, S),
    at(robot, counter, S).

boiled(kettle, y, [boil_kettle|S]) :- 
    poss(boil_kettle, S).

% Kettle plugged_in status persists
plugged_in(kettle, Val, [A|S]) :- 
    A \= fill_kettle,
    plugged_in(kettle, Val, S).

% Kettle filled status persists
filled(kettle, Val, [A|S]) :-
    A \= fill_kettle,
    filled(kettle, Val, S).

% Kettle boiled status persists
boiled(kettle, Val, [A|S]) :-
    A \= boil_kettle,
    boiled(kettle, Val, S).

%------------------------------------------------------
% Action 4: pour_water
% Preconditions: The kettle is boiled, the robot and cup are at the counter, and the cup is empty.
% Successor: The cup gets filled with hot water.
%------------------------------------------------------
poss(pour_water, S) :- 
    boiled(kettle, y, S),
    at(robot, counter, S),
    at(cup, counter, S),
    contains(cup, n, S).

contains(cup, hot_water, [pour_water|S]) :- 
    poss(pour_water, S).

%------------------------------------------------------
% Action 5: add_coffee
% Preconditions: The cup contains hot water, the robot is at the counter, and coffee is available.
% Successor: The cup then contains both hot water and coffee.
%------------------------------------------------------
poss(add_coffee, S) :- 
    contains(cup, hot_water, S),
    at(robot, counter, S),
    object(coffee).

contains(cup, hot_water_and_coffee, [add_coffee|S]) :- 
    poss(add_coffee, S).

% Cup contents persist (changed only by pour_water or add_coffee)
contains(cup, Val, [A|S]) :-
    A \= pour_water,
    A \= add_coffee,
    contains(cup, Val, S).

%------------------------------------------------------
% Action 6: stir_coffee
% Preconditions: The cup contains hot water and coffee, it has not been stirred yet, and the robot is at the counter.
% Successor: The coffee is stirred.
%------------------------------------------------------
poss(stir_coffee, S) :- 
    contains(cup, hot_water_and_coffee, S),
    stirred(cup, n, S),
    at(robot, counter, S).

stirred(cup, y, [stir_coffee|S]) :- 
    poss(stir_coffee, S).

% Stirred status persists (changed only by stir_coffee)
stirred(cup, Val, [A|S]) :-
    A \= stir_coffee,
    stirred(cup, Val, S).
%------------------------------------------------------
% Planning predicates
%------------------------------------------------------
plan(Goal, Plan) :-
    bposs(Plan, Goal).

% Start the planning process
bposs(S, Goal) :- tryposs([], S, Goal).

% If the goal is reached, output the plan (the plan is built in reverse order)
tryposs(S, S, _Goal) :- 
    satisfies_goal(S),
    !,
    write('Plan found: '), write(S), nl.

% Otherwise, try expanding the plan with a valid action
tryposs(X, S, Goal) :- 
    action(A),
    poss(A, X),
    \+ member(A, X),
    tryposs([A|X], S, Goal).

% Define the goal: the cup must be stirred (stirred(cup, y, S) holds)
satisfies_goal(S) :- 
    stirred(cup, y, S).

%% Final queries %% 
% 1) Can the robot get the cup?
% ?- poss(get_cup, []).

% 2) Can the robot fill the kettle?
% ?- poss(fill_kettle, [get_cup]).

% 3) Can the robot boil the kettle?
% ?- poss(boil_kettle, [get_cup, fill_kettle]).

% 4) Can the robot pour water into the cup?
% ?- poss(pour_water, [get_cup, fill_kettle, boil_kettle]).

% 5) Can the robot make a plan to stir the coffee and achieve the goal?
% ?- plan(stirred(cup, y, []), Plan).