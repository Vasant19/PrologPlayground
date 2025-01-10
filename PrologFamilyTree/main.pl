
% Implenetation of Declarative programming and Setting Facts

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

% Everyone who has a child is educated.
educated(X) :- parent(X, _).

