% Recursion problems

% mymember(X,L)/2  mymember(X,L) means that X is an item in List L.
% query ?- mymember(a,[b,c,a,d]).

mymember(X,[X|_]).
mymember(X,[_|T]) :- mymember(X,T).

% sum(A,L2,S) sum(A,L2,S) means that S is the result list of the Sum of element A and list 2
% query ?-





% sum(L, S) means that S is the sum of the elements in list L.
% query ?- mysum([4,2],S)
mysum([],0). % Base case for termination
mysum([H|T], S) :- mysum(T,S1) , S is H + S1. 