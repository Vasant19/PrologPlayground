% Parent/2 : Determines if X is a parent of Y.
% Jim and Jenn are parents of Joe and Sally. 
parent(jim,joe). 
parent(jim,sally). 
parent(jenn,joe).
parent(jenn,sally).

% Joe is father of Josh and Jeff. 
parent(joe,josh).
parent(joe,jeff).

% Jeff is father of Rob.
parent(jeff,rob).

% educated/1: Determines if X is educated if X is a parent.
% ?- setof(X, educated(X), List). To get the list of educated people without duplication
educated(X) :- parent(X, _).


% Sibling/2: Determines if X is a sibling of Y.
sibling(X, Y) :- parent(Z, X), parent(Z, Y), dif(X,Y).

poor(X) :- parent(X, Y), sibling(Y, _).


% grandparent/2: Determines if X is a grandparent of Z.
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

% grandchild/2: Determines if X is a grandchild of Z.
grandchild(X, Z) :- parent(Z, Y), parent(Y, X).


% male/1: Determines if a person is male , %female/1: Determines if a person is female.
male(jim).
male(joe).
male(josh).
male(jeff).
male(rob).
female(jenn).
female(sally).

% sister/2: Determines if X is a sister of Y.
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), dif(X, Y).

% aunt/2: Determines if X is an aunt of Y.
aunt(X, Y) :- sister(X, Z), parent(Z, Y).