% Debugging tracing and testing file for Prolog programs using 
% trace. and notrace. commands for debugging 
% guitracer. and  noguitracer. command for GUI debugging
% mymember(X,L) is true if X is an element of list L


% this first clause says H is a member of the list (second argument) that has H as the first element.
mymember(H,[H|_]).


% this second clause says that H is a member of the list if H is a member of the tail of the list
mymember(H,[_|T]):- mymember(H,T).
 