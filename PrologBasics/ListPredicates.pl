% Predicate mycount(List,Count) which is true if Count is the number of items of the list, 

% Base case: an empty list has 0 elements.
mycount([], 0). % If the list is empty, the count is 0.

% Recursive case: the count of a list is one plus the count of its tail.
mycount([_|T], Count) :- % For a non-empty list, ignore the head and count the tail.
    mycount(T, CountRemaining),  % Recursively count the elements in the tail.
    Count is CountRemaining + 1. % Add 1 to the count of the tail.

% Predicate nth(N,List,Item) which is true if Item is the N-th element of List.
nth(N, List, Item) :-
    append(Prefix, [Item|_], List), % Split List into Prefix (the part before Item) and Suffix (the rest).
    length(Prefix, K), % Find the length of the Prefix.
    N is K + 1. % The position of Item is 1 more than the length of Prefix.

% Predicate myinsert(Item,List,Position,Result) which is true if Result is the list formed by inserting Item into List at position Position
myinsert(Item, List, Position, Result) :-
    integer(Position), % Ensure that Position is an integer.
    Position > 0, % Ensure that Position is positive.
    Pos is Position - 1, % Convert the 1-based Position into 0-based index.
    length(Prefix, Pos),  % Find the Prefix of length Pos (the part before the insertion point).
    append(Prefix, Suffix, List),  % Split List into Prefix and Suffix.
    append(Prefix, [Item|Suffix], Result). % Insert the Item in the Prefix and rejoin with Suffix to create Result.

% Write a predicate mydelete(N,List,Result) which is true if Result is the list formed by deleting the Nth element of List
mydelete(N, List, Result) :-
    integer(N), % Ensure that N is an integer.
    N > 0, % Ensure that N is positive.
    Pos is N - 1, % Convert the 1-based N into 0-based index.
    length(Prefix, Pos), % Find the Prefix of length Pos (the part before the deletion point).
    append(Prefix, [_|Suffix], List), % Split List into Prefix, the element to be deleted, and Suffix.
    append(Prefix, Suffix, Result). % Remove the element by rejoining Prefix and Suffix.
