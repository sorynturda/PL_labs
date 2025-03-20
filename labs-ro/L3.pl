%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 			LABORATORUL 3 EXEMPLE		%%%%%%
%%%%%% 			Operații pe liste			%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%--------------------------------------------------
% Predicatul MEMBER %
%--------------------------------------------------
member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).


% Urmărește execuția la:
% ?- member1(3,[1,2,3,4]).
% ?- member1(a,[a, b, c, a]).
% ?- X=a, member1(X, [a, b, c, a]).
% ?- member1(a, [1,2,3]).


%--------------------------------------------------
% Predicatul APPEND %
%--------------------------------------------------
append1([], L2, L2).
%append1([H|T], L2, [H|TailR]) :- append1(T, L2, TailR).
append1([H|T], L2, R) :- 
    append1(T, L2, R1),
    R=[H|R1].

% Urmărește execuția la:
% ?- append1([a,b],[c,d],R).
% ?- append1([1, [2]], [3|[4, 5]], R).
% ?- append1(T, L, [1, 2, 3, 4, 5]).
% ?- append1(_, [X|_], [1, 2, 3, 4, 5]).


%--------------------------------------------------
% Predicatul DELETE %
%--------------------------------------------------
% șterge prima apariție și se oprește
% altfel iterează peste elementele listei
% daca a ajuns la lista vida înseamnă că elementul nu a fost găsit
% și putem returna lista vidă
delete1(X, [X|T], T).
delete1(X, [H|T], [H|R]) :- delete1(X, T, R).
delete1(_, [], []).



% Urmărește execuția la:
% ?- delete1(3, [1, 2, 3, 4], R).
% ?- X=3, delete1(X, [3, 4, 3, 2, 1, 3], R).
% ?- delete1(3, [1, 2, 4], R).
% ?- delete1(X, [1, 2, 4], R).


%--------------------------------------------------
% Predicatul DELETE ALL %
%--------------------------------------------------
% dacă s-a șters prima apariție se va continua și pe restul elementelor
delete_all(X, [X|T], R) :- delete_all(X, T, R).
delete_all(X, [H|T], [H|R]) :- delete_all(X, T, R).
delete_all(_, [], []).


% Urmărește execuția la:
% ?- delete_all(3, [1, 2, 3, 4], R).
% ?- X=3, delete_all(X, [3, 4, 3, 2, 1, 3], R).
% ?- delete_all(3, [1, 2, 4], R).
% ?- delete_all(X, [1, 2, 4], R).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 				EXERCIȚII				%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------
% 1. Scrieți predicatul add_first(X,L,R) care adaugă X la începutul listei L și pune rezultatul în R. 
% Sugestie: simplificați pe cât de mult posibil acest predicat.
% ?- add_first(1,[2,3,4],R).
% R=[1,2,3,4].

% add_first(X,L,R). – adaugă X la începutul listei L și pune rezultatul în R

<<<<<<< HEAD
 add_first(X, L, R):- R=[X|L].
=======
add_first(X, L, R) :- R=[X|L].
>>>>>>> 7fda4f0 (lab 3 de facut)


%--------------------------------------------------
% 2. Scrieți predicatul append3/4 care să realizeze concatenarea a 3 liste. 
% Sugestie: Nu folosiți append-ul a două liste.
% ?- append3([1,2],[3,4,5],[6,7],R).
% R=[1,2,3,4,5,6,7] ;
% false.


% append3(L1,L2,L3,R). – va realiza concatenarea listelor L1,L2,L3 în R

<<<<<<< HEAD
append3([H|T],L2,L3,[H|R]):- append3(T,L2,L3,R).
append3([],[H|T],L3,[H|R]):- append3([],T,L3,R).
append3([],[],R,R).
=======
append3([], [], R, R).
append3([H|T], L2, L3, [H|R]) :- append3(T, L2, L3, R).
append3([], [H|T], L3, [H|R]) :- append3([], T, L3, R).
>>>>>>> 7fda4f0 (lab 3 de facut)



%--------------------------------------------------
% 3. Scrieți un predicat care realizează suma elementelor dintr-o lista dată. 
% ?- sum_bwd([1,2,3,4], S).
% R=10.
% ?- sum_fwd([1,2,3,4], S).
% R=10.

% sum(L, S). – calculează suma elementelor din L și returnează suma în S

sum_bwd([], 0).
sum_bwd([H|T], S):-
		sum_bwd(T, S1),
		S is H+S1.

sum_fwd([], Acc, Acc).
sum_fwd([H|T], Acc, S) :- 
		Acc1 is H+Acc,
		sum_fwd(T, Acc1, S).
sum_fwd(L, S):-
		sum_fwd(L, 0, S). 




%--------------------------------------------------
% 4. Scrieți un predicat care separă numerele pare de cele impare. 
% (Întrebare: de ce avem nevoie pentru recursivitate înainte?)
% ?- separate_parity([1, 2, 3, 4, 5, 6], E, O).
% E = [2, 4, 6]
% O = [1, 3, 5] ;
% false

<<<<<<< HEAD

separate_parity([H|T], [H|E], O):-  
    	0 is H mod 2,!,
    	separate_parity(T,E,O).
separate_parity([H|T], E, [H|O]):-  
    	separate_parity(T,E,O).
separate_parity([], [], []).
=======
separate_parity([], [], []).
separate_parity([H|T], E, [H|O]):- 
		1 is H mod 2,
		separate_parity(T, E, O).
separate_parity([H|T], [H|E], O):-
		0 is H mod 2,
		separate_parity(T, E, O).

>>>>>>> 7fda4f0 (lab 3 de facut)


%--------------------------------------------------
% 5. Scrieți un predicat care să șteargă toate elementele duplicate dintr-o listă.
% ?- remove_duplicates([3, 4, 5, 3, 2, 4], R).
% R = [3, 4, 5, 2] ; % păstrează prima apariție
% false
% SAU
% ?- remove_duplicates([3, 4, 5, 3, 2, 4], R).
% R = [5, 3, 2, 4] ; % păstrează ultima apariție
% false

<<<<<<< HEAD
remove_duplicates([H|T], Acc, R):- 
    	member(H,Acc),!,
    	remove_duplicates(T, Acc, R).
remove_duplicates([H|T], Acc, R):-
    	append(Acc, [H], Acc1),
		remove_duplicates(T,Acc1,R).
remove_duplicates([], Acc, Acc).

remove_duplicates(L,R) :-
    	remove_duplicates(L, [], R).
=======
remove_duplicates([], []).
remove_duplicates([H|T], R) :-
		member(H, T), !,
		remove_duplicates(T, R).
remove_duplicates([H|T], [H|R]) :-
		remove_duplicates(T, R).



>>>>>>> 7fda4f0 (lab 3 de facut)


%--------------------------------------------------
% 6. Scrieți un predicat care să înlocuiască toate aparițiile lui X în lista L cu Y și să pună rezultatul în R.
% ?- replace_all(1, a, [1, 2, 3, 1, 2], R).
% R = [a, 2, 3, a, 2] ;
% false

replace_all(_, _, [], []).
% replace_all(X, Y, [X|T] , [Y|R]) :-
% 		replace_all(X, Y, T, R).
replace_all(X, Y, [X|T] , [Y|R]) :-
		replace_all(X, Y, T, R).


<<<<<<< HEAD
replace_all(X, Y, [X|T], [Y|R]) :-
    replace_all(X,Y,T,R).
replace_all(X, Y, [H|T], [H|R]):-
    H\=X,
    replace_all(X,Y,T,R).
replace_all(_, _, [], []).
=======
>>>>>>> 7fda4f0 (lab 3 de facut)




%--------------------------------------------------
% 7. Scrieți un predicat care șterge tot al k-lea element din lista de intrare.
% ?- drop_k([1, 2, 3, 4, 5, 6, 7, 8], 3, R).
% R = [1, 2, 4, 5, 7, 8] ;
% false


drop_k_fwd([_|T], K, CurrentN, Acc, R) :-
		0 is (CurrentN+1) mod K, !,
    	NextN is CurrentN+1,
    	drop_k_fwd(T, K, NextN, Acc, R).
drop_k_fwd([H|T], K, CurrentN, Acc, R) :-
    	NextN is CurrentN+1,
    	append1(Acc, [H], Acc1),
    	drop_k_fwd(T, K, NextN, Acc1, R).
drop_k_fwd([], _, _, Acc, Acc).

drop_k_fwd(L, K, R):- 
    	drop_k_fwd(L, K, 0, [], R).

drop_k_bwd([_|T], K, CurrentN, R) :-
    	0 is CurrentN mod K, !,
    	NextN is CurrentN+1,
		drop_k_bwd(T, K, NextN, R).
drop_k_bwd([H|T], K, CurrentN, [H|R]) :-
		NextN is CurrentN+1,
		drop_k_bwd(T, K, NextN, R).
drop_k_bwd([], _, _, []).
drop_k_bwd(L, K, R) :-
    	drop_k_bwd(L, K, 1, R).



%--------------------------------------------------
% 8. Scrieți un predicat care șterge duplicatele consecutive fără a modifica ordinea elementelor din listă.
% Sugestie: căutați observația despre șablonul extins în Laboratorul 1.
% ?- remove_consecutive_duplicates([1,1,1,1, 2,2,2, 3,3, 1,1, 4, 2], R).
% R = [1,2,3,1,4,2] ;
% false


% remove_consecutive_duplicates(L, R):-  % *IMPLEMENTAȚI AICI*




%--------------------------------------------------
% 9. Scrieți un predicat care adăugă duplicatele consecutive într-o sub-listă fără a modifica ordinea elementelor din listă.
% ?- pack_consecutive_duplicates([1,1,1,1, 2,2,2, 3,3, 1,1, 4, 2], R).
% R = [[1,1,1,1], [2,2,2], [3,3], [1,1], [4], [2]];
% false


% pack_consecutive_duplicates(L, R):-  % *IMPLEMENTAȚI AICI*




