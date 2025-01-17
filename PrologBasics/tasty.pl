% Declaring Consumables and food items in Prolog 

% vegetables/1 predicate (this will be 2 lines) that means its argument is a type of vegetable, and is true of the following: celery cucumber
vegetables(celery).
vegetables(cucumber).

% bread/1 predicate that means its argument is a type of bread, and is true of the following: fruit rye
bread(fruit).
bread(rye).

% cake/1 predicate that means its argument is a type of cake, and is true of the following: fruit chocolate
cake(fruit).
cake(chocolate).

% tasty/1 predicate that means its argument is a tasty food, and is true of something if it is a type of bread and a type of cake
tasty(X) :- bread(X), cake(X).
