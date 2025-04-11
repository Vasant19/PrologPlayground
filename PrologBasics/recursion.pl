% Recursion problems

% mymember(X,L)/2  mymember(X,L) means that X is an item in List L.
% query ?- mymember(a,[b,c,a,d]).

mymember(X,[X|_]).

mymember(X,[_|T]):- mymember(X,T).

% sum(A,L2,S) sum(A,L2,S) means that S is the result list of the Sum of element A and list 2
% query ?-

sum().