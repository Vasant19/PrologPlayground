% Prolog code for the follows/2 predicate which is true for pairs of these items where
% the first argument follows (appears immediately after in the alphabet) the second argument.
% This predicate represents a relation that includes seven tuples

follows(b, a).
follows(c, b).
follows(d, c).
follows(e, d).
follows(f, e).
follows(g, f).
follows(h, g).

% Implementation of a recursive after/2 predicate such that after(Y,X) is true of Y and X when
% Y follows X , or if Y is after the letter that follows X.

after(Y, X) :- follows(Y, X).

% Defination of the recursive after/2 predicate.
after(Y, X) :- follows(Y, X).
after(Y, X) :- follows(Z, X), after(Y, Z).

% Best example of recursion is the countdown program
% countdown(0) :- 
%     write('Blastoff!'), nl. % Base case: stop at 0 and print "Blastoff!"
% countdown(N) :- 
%     N > 0, 
%     write(N), nl, % Print the current number
%     N1 is N - 1,  % Calculate the next number
%     countdown(N1). % Recursive call with the smaller number

