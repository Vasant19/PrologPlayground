% Recursion problems

% mymember(X,L)/2  mymember(X,L) means that X is an item in List L.
% query ?- mymember(a,[b,c,a,d]).
mymember(X,[X|_]).
mymember(X,[_|T]) :- mymember(X,T).

% howmany(X, L, N) means that N is the number of occurrences of X in list L.
% query ?- howmany(a,[a,b,a,c,a],N).
howmany(_, [], 0). % Base case: empty list has 0 occurrences.
howmany(X, [X|T], N) :- howmany(X, T, N0), N is N0 + 1. % Case: head matches X.
howmany(X, [Y|T], N) :- X \= Y, howmany(X, T, N). % Case: head does not match X.

% mylist(L) means that L is a valid list.
% query ?- mylist([a,b,c]).
mylist([]). % Base case: an empty list is a valid list.
mylist([_|T]) :- mylist(T). % Recursive case: a list with a head and tail is valid if the tail is a valid list.

% sum(L, S) means that S is the sum of the elements in list L.
% query ?- mysum([4,2],S)
mysum([],0). % Base case for termination
mysum([H|T], S) :- mysum(T,S1) , S is H + S1.  % Recursive case 