% Pure Logic vs Non-logical 

%%%%%%% Pure Logical %%%%%%%%%%
% Prolog is a logic programming language that is based on formal logic.
% Order does not matter in pure logic.

%%%%%%% Non-Logical %%%%%%%%%%
% Cut in prolog is non-logical.
% It is used to control backtracking in Prolog.
% Arithetic is non-logical.
% Closed world assumption (CWA) is non-logical.

% Question: Given a Domain, Axiomatize the domain.

% Question: Convert to CNF
% ∀x∃y P(x,y) (for all x, there exists a y)
% Step 1: Eliminate Implications
% Step 2: Move Negation Inwards
% Step 3: Standardize Variables apart
% Step 4: Skolemize existentials
% Step 5: Move Universal Quantifiers Outwards
% Step 6: Distribute "and" ^ over "or" v


% Answer Step1: There are no implications in the expression.
% Answer Step2: There are no negations in the expression.
% Answer Step3: There are no variables to standardize apart. No repeated quantifiers with conflicting variable names, so no need to rename.
% Answer Step4: We eliminate ∃y existensial quantifier by replacing it with a Skolem function. Since ∃y is inside the scope of ∀x, we use a Skolem function of x, say f(x). => ∀x P(x,f(x))
% Answer Step5: This is already in the form ∀x (something), so it’s fine. In CNF, we usually drop the ∀ (assume everything is universally quantified by default). => P(x, f(x))
% Answer Step6: This is already in CNF, as it is a single predicate. CNF requires the expression to be a conjunction of disjunctions, but a single predicate is trivially in CNF. No ∧ or ∨ to distribute. 
% => P(x, f(x))


% mymember recursive function
% mymember(X,L) means that X is an item in List L.
mymember(X, [X|_]). % base case: X is the head of the list
mymember(X, [_|T]) :- mymember(X, T). % X is in the tail of the list

% sum of a list
% sum(L, S) means that S is the sum of the elements in list L.
sum([], 0). % basecase: The sum of an empty list is 0
sum([H|T], S) :- sum(T, S1), S is H + S1. % recursive case: The sum of a list is the head plus the sum of the tail