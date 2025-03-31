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
% 3) pour_water() - Wait for water to boil, pour hot water into cup
% 4) add_coffee - Add instant coffee to cup
% 5) stir() - Stir the coffee to complete the process


% Domain objects and their possible positions in order to fully represent the environment for your actions and fluents
object(cup).    % The cup is an object
object(kettle). % The kettle is an object
object(robot).  % The robot is an object

% Initial state of the world
at(cup, cupboard, []).         % The cup is in the cupboard initially
at(kettle, counter, []).       % The kettle is on the counter initially
at(robot, counter, []).        % The robot is at the counter initially

plugged_in(kettle, n, []).     % The kettle is not plugged in initially
filled(kettle, n, []).         % The kettle has no water initially
boiled(water, n, []).          % The water is not boiled initially
contains(cup, n, []).          % The cup is empty initially
stirred(cup, n, []).           % Initially, the coffee is not stirred, and is also the final state (goal state).
