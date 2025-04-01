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

% Domain objects and their possible positions in order to fully represent the environment for your actions and fluents
object(cup).    % The cup is an object
object(kettle). % The kettle is an object
object(robot).  % The robot is an object
object(hot_water).  % The water is an object
object(coffee). % The coffee is an object
object(hot_water_and_coffee).  % The cup can contain both hot water and coffee


% Optional we can introduce a move action : place(far_from_counter). % The robot can be far from the counter
place(counter). % The object can be on the counter or near the counter
place(cupboard). % The cupboard is a place too.

% Initial state of the world
at(cup, cupboard, []).         % The cup is in the cupboard initially
at(kettle, counter, []).       % The kettle is on the counter initially
at(robot, counter, []).        % The robot is at the counter initially

plugged_in(kettle, n, []).     % The kettle is not plugged in initially
filled(kettle, n, []).         % The kettle has no water initially
boiled(kettle, n, []).          % The water is not boiled initially
contains(cup, n, []).          % The cup is empty initially
stirred(cup, n, []).           % Initially, the coffee is not stirred, and is also the final state (goal state).

% Action 1 - get_cup()
% Precondition axiom : The cup must be in the cupboard and the robot must be near the counter too
poss(get_cup, S) :- 
    at(cup, cupboard, S), 
    at(robot, counter, S).

% Successor axiom
% After getting the cup, it's on the counter
at(cup, counter, [get_cup|S]) :- 
    poss(get_cup, S).

% The cup stays where it was unless moved
at(cup, Curr_Pos, [A|S]) :-  
    at(cup, Curr_Pos, S),
    A \= get_cup.



% Action 2 - fill_kettle()
% Precondition axiom : The kettle must be on the counter and the robot must be there too , and the cup is on the counter
poss(fill_kettle, S) :- 
    at(cup, counter, S),
    at(kettle, counter, S), 
    at(robot, counter, S).

% Successor axiom
% Plugging in the kettle.
plugged_in(kettle, y, [fill_kettle|S]) :- 
    poss(fill_kettle, S).

% Filled kettle: After filling, the kettle is filled with water
filled(kettle, y, [fill_kettle|S]) :- 
    poss(fill_kettle, S).

% Ensure that the kettle stays filled unless explicitly changed
filled(kettle, y, [A|S]) :-  
    filled(kettle, y, S),
    A \= fill_kettle.





% Action 3 - boil_kettle()
% Precondition axiom: Kettle must be filled and plugged in
poss(boil_kettle, S) :- 
    filled(kettle, y, S),
    plugged_in(kettle, y, S),
    at(robot, counter, S).

% Successor axioms:
% Boiling the water
boiled(kettle, y, [boil_kettle|S]) :- 
    poss(boil_kettle, S).

% Ensure the kettle stays boiled 
boiled(kettle, y, [A|S]) :-  
    boiled(kettle, y, S),
    A \= boil_kettle.



% Action 4 - pour_water()
% Precondition axiom: The kettle must be boiled, the robot must be at the counter, and the cup must be empty
poss(pour_water, S) :- 
    boiled(kettle, y, S),
    at(robot, counter, S),
    at(cup, counter, S),
    contains(cup, n, S).   % Cup should be empty before pouring

% Successor axiom: After pouring, the cup contains hot water
contains(cup, hot_water, [pour_water|S]) :- 
    poss(pour_water, S).

% The cup stays as it was unless poured into
contains(cup, Curr_Contents, [A|S]) :-  
    contains(cup, Curr_Contents, S),
    A \= pour_water.

% Action 5 - add_coffee()
% Precondition axiom: The cup must contain hot water, the robot must be at the counter, and the coffee must be available
poss(add_coffee, S) :- 
    contains(cup, hot_water, S),
    at(robot, counter, S),
    object(coffee).  

% Successor axiom: After adding coffee, the cup contains both hot water and coffee
contains(cup, hot_water_and_coffee, [add_coffee|S]) :- 
    poss(add_coffee, S).

% The cup stays as it was unless coffee is added
contains(cup, Curr_Contents, [A|S]) :-  
    contains(cup, Curr_Contents, S),
    A \= add_coffee.

% Action 6 - stir_coffee()
% Precondition: The cup must contain hot water and coffee, not yet stirred, and the robot must be at the counter
poss(stir_coffee, S) :- 
    contains(cup, hot_water_and_coffee, S),
    stirred(cup, n, S),
    at(robot, counter, S).

% Successor axiom: After stirring, the cup is stirred
stirred(cup, y, [stir_coffee|S]) :- 
    poss(stir_coffee, S).

% Persistence: The stirred state persists unless changed by an action
stirred(cup, Curr_State, [A|S]) :-  
    stirred(cup, Curr_State, S),
    A \= stir_coffee.

