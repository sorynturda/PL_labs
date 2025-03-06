% Predicatul woman/1
woman(ana).
woman(sara).
woman(ema).
woman(maria). 
woman(carmen).
woman(dorina).
woman(irina).

% Predicatul man/1
man(andrei).
man(george).
man(alex). % … adăugați restul faptelor acestui predicat
man(mihai).
man(sergiu).
man(marius).

% Predicatul parent/2
parent(maria, ana). % maria este părintele anei
parent(george, ana). % george este părintele anei
parent(maria, andrei).
parent(george, andrei). % … adăugați restul faptelor acestui predicat
parent(carmen, sara).
parent(carmen, ema).
parent(alex, sara).
parent(alex, ema).
parent(marius, maria).
parent(dorina, maria).
parent(mihai, george).
parent(mihai, carmen).
parent(irina, george).
parent(irina, carmen).
parent(sergiu, mihai).

% Predicatul mother/2
% X este mama lui Y, daca X este femeie și X este părintele lui Y
mother(X,Y):- woman(X), parent(X,Y).
father(X,Y):- man(X), parent(X,Y).

% Predicatul sibling/2
% X și Y sunt frați/surori dacă au cel puțin un părinte în comun
% și X diferit de Y
sibling(X,Y) :- parent(Z,X), parent(Z,Y), X\=Y.

% Predicatul sister/2
% X este sora lui Y dacă X este femeie și X și Y sunt frați/surori
sister(X,Y) :- sibling(X,Y), woman(X).

% Predicatul aunt/2
% X este mătușa lui Y daca este sora lui Z și Z este părintele lui Y
aunt(X,Y) :- sister(X,Z), parent(Z,Y).

brother(X,Y) :- sibling(X,Y), man(X).
uncle(X,Y) :- brother(X,Z), parent(Z,Y).
grandmother(X, Y) :- mother(X,Z), parent(Z,Y).
grandfather(X, Y) :- father(X,Z), parent(Z,Y).

% X este stramosul lui Y
ancestor(X,Y) :- parent(Z,Y), ancestor(X, Z).
ancestor(X, X).


