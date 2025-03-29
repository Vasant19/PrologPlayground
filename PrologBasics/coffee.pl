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


% Simplified action representation
% 1) get_cup() - Open cupboard, take cup, place on counter
% 2) fill_kettle() - Fill kettle with water, plug it in, wait for it to boil
% 3) pour_water() - Wait for water to boil, pour hot water into cup
% 4) add_coffee - Add instant coffee to cup
% 5) stir() - Stir the coffee to complete the process

% Initial state of the world
get_cup(n,[]).
fill_kettle(n,[]).