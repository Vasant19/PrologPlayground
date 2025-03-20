% Initial implementation of a simple chatbot in Prolog 
talk(Sentence ,Reply):- 
    %parse the sentence
    parse(Sentence, LF, Type),
    %convert the FOL logical form into a horn
    %clause if possible
    clausify(LF, Clause, FreeVars), !,
    %concoct a reply based on the clause and
    % whether it was a query or assertion
    reply(Type, FreeVars, Clause, Reply).