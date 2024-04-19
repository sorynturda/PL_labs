%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 			LABORATORY 9 EXAMPLES		%%%%%%
%%%%%%   Difference Lists and Side Effects  %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------
%--------------------------------------------------
% LISTS %
%--------------------------------------------------
%--------------------------------------------------

%--------------------------------------------------
% The ADD predicate %
%--------------------------------------------------

% For complete lists
add_cl(X, [H|T], [H|R]):- add_cl(X, T, R).
add_cl(X, [], [X]).

% For difference lists
add_dl(X, LS, LE, RS, RE):- RS = LS, LE = [X|RE].

add_dl2(X,LS,[X|RE],LS,RE). % * SIMPLIFIED

% Follow the execution of:
% ? - LS=[1,2,3,4|LE], add_dl2(5,LS,LE,RS,RE).
% LE = [5|RE],
% LS = RS, RS = [1, 2, 3, 4, 5|RE]

%--------------------------------------------------
% The APPEND predicate %
%--------------------------------------------------
append_dl(LS1, LE1, LS2,LE2, RS,RE):- RS=LS1, LE1=LS2, RE=LE2.

% Follow the execution of:
% ? - LS1=[1,2,3,4|LE1], LS2=[5,6,7,8|LE2], append_dl(LS1, LE1, LS2, LE2, RS, RE).
% LE1 = LS2, LS2 = [5, 6, 7, 8|RE],
% LE2 = RE,
% LS1 = RS, RS = [1, 2, 3, 4, 5, 6, 7, 8|RE]



%--------------------------------------------------
% The QUICKSORT predicate %
%--------------------------------------------------
% H is pivot, Sm = smaller than pivot, Lg = greater than pivot
partition(H, [X|T], [X|Sm], Lg):-X<H, !, partition(H, T, Sm, Lg).
partition(H, [X|T], Sm, [X|Lg]):-partition(H, T, Sm, Lg).
partition(_, [], [], []).

quicksort_dl([H|T], S, E):- % a new argument was added
	partition(H, T, Sm, Lg), % partition predicate remains the same
	quicksort_dl(Sm, S, [H|L]), %implicit concatenation
	quicksort_dl(Lg, L, E).
quicksort_dl([], L, L). % stopping condition has been changed

% Follow the execution of:
% ?- quicksort_dl([4,2,5,1,3], L, []).
% ?- quicksort_dl([4,2,5,1,3], L, _).







%--------------------------------------------------
%--------------------------------------------------
% TREES %
%--------------------------------------------------
%--------------------------------------------------

%TREE
tree1(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))).


%--------------------------------------------------
% The INORDER predicate %
%--------------------------------------------------

% For complete lists
inorder(t(K,L,R),List):-
	inorder(L,ListL),
	inorder(R,ListR),
	append1(ListL,[K|ListR],List).
inorder (nil,[]).

% For difference lists
% when we reached the end of the tree we unify the beginning and end
% of the partial result list – representing an empty list as a difference list
inorder_dl(nil,L,L).
inorder_dl(t(K,L,R),LS,LE):-
	%obtain the start and end of the lists for the left and right subtrees
	inorder_dl(L,LSL,LEL),
	inorder_dl(R,LSR,LER),
	% the start of the result list is the start of the left subtree list
	LS=LSL,
	% key K is inserted between the end of left and the start of right
	LEL=[K|LSR],
	% the end of the result list is the end of the right subtree list
	LE=LER.

% Test the following queries:
% ? - tree1(T), inorder_dl(T,L,[]).
% ? - tree1(T), inorder_dl(T,L,_).

% *simplified 
inorder_dl2(nil,L,L).
inorder_dl2(t(K,L,R),LS,LE):-
	inorder_dl2(L,LS,[K|LT]), 
	inorder_dl2(R,LT,LE).
	







%--------------------------------------------------
%--------------------------------------------------
% SIDE EFFECTS %
%--------------------------------------------------
%--------------------------------------------------

% Your first query with side effects:
% ?- assert(insect(ant)), assert(insect(bee)), (retract(insect(I)), writeln(I), retract(insect(II)), fail.


%--------------------------------------------------
% The FIBONACCI predicate %
%--------------------------------------------------
:- dynamic memofib/2.

fib(N,F):-
	memofib(N,F),!.
	fib(N,F):- N>1,
	N1 is N-1,
	N2 is N-2,
	fib(N1,F1),
	fib(N2,F2),
	F is F1+F2,
	assertz(memofib(N,F)).
fib(0,1).
fib(1,1).


% Follow the execution of (run the queries sequentially):
% ?- listing(memo_fib/2). % lists all definitions of the predicate memo_fib with 2 arguments
% ?- fib(4,F).
% ?- listing(memo_fib/2).
% ?- fib(10,F).
% ?- listing(memo_fib/2).
% ?- fib(10,F).



%--------------------------------------------------
% The PRINT FIBONACCI predicate - Printing memorised results %
%--------------------------------------------------
print_all:-
	memofib(N,F),
	write(N),
	write(' - '),
	write(F),
	nl,
	fail.
print_all.

% Follow the execution of:
% ?-print_all.
% ?-retractall(memo_fib(_,_)).
% ?-print_all.


%--------------------------------------------------
% Collecting memorised results %
%--------------------------------------------------

% Follow the execution of:
% ?- findall(X, append(X,_,[1,2,3,4]), List).
% ?- findall(lists(X,Y), append(X,Y,[1,2,3,4]), List).
% ?- findall(X, member(X,[1,2,3]), List).


%PERM
perm(L, [H|R]):-append(A, [H|T], L), append(A, T, L1), perm(L1, R).
perm([], []).

all_perm(L,_):-
	perm(L,L1),
	assertz(p(L1)),
	fail.
all_perm(_,R):-
	collect_perms(R).
	
collect_perms([L1|R]):-
	retract(p(L1)),
	!,
	collect_perms(R).
collect_perms([]).

% ?- all_perm([1,2,3],L).
% L=[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]];
% no.


% Follow the execution of:
% ?- retractall(p(_)), all_perm([1,2],R).
% ?- listing(p/1).
% ?- retractall(p(_)), all_perm([1,2,3],R).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 				EXERCISES				%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trees:
incomplete_tree(t(7, t(5, t(3, _, _), t(6, _, _)), t(11, _, _))).
complete_tree(t(7, t(5, t(3, nil, nil), t(6, nil, nil)), t(11, nil, nil))).

% Write a predicate which:
%--------------------------------------------------
% 1. Transforms a complete list into a difference list and vice versa.
% ?- convertCL2DL([1,2,3,4], LS, LE).
% LS = [1, 2, 3, 4|LE]
% ?- LS=[1,2,3,4|LE], convertDL2CL(LS,LE,R).
% R = [1, 2, 3, 4]


% convertCL2DL(L, LS, LE):- % *IMPLEMENTATION HERE*

% convertDL2CL(LS, LE, R):- % *IMPLEMENTATION HERE*


%--------------------------------------------------
% 2. Transforms an incomplete list into a difference list and vice versa.
% ?- convertIL2DL([1,2,3,4|_], LS, LE).
% LS = [1, 2, 3, 4|LE]
% ?- LS=[1,2,3,4|LE], convertDL2IL(LS,LE,R).
% R = [1, 2, 3, 4|_]


% convertIL2DL(L, LS, LE):- % *IMPLEMENTATION HERE*

% convertDL2IL(LS, LE, R):- % *IMPLEMENTATION HERE*



%--------------------------------------------------
% 3. Flattens a deep list using difference lists instead of append.
% ?- flat_dl([[1], 2, [3, [4, 5]]], RS, RE).
% RS = [1, 2, 3, 4, 5|RE] ;
% false


% flat_dl(L, RS, RE):- % *IMPLEMENTATION HERE*




%--------------------------------------------------
%4. Generates a list with all the possible decompositions of a list into 2 lists,
%without using the built-in predicate findall.
%?- all_decompositions([1,2,3], List).
%List=[ [[], [1,2,3]], [[1], [2,3]], [[1,2], [3]], [[1,2,3], []] ] ;
%false


% all_decompositions(L, R):- % *IMPLEMENTATION HERE*




%--------------------------------------------------
% 5. Traverses a complete tree in pre-order and post-order using difference lists in an implicit manner.
% ?- complete_tree(T), preorder_dl(T, S, E).
% S = [6, 4, 2, 5, 9, 7|E]
% ?- complete_tree(T), postorder_dl(T, S, E).
% S = [2, 5, 4, 7, 9, 6|E]


% preorder_dl(t(K,L,R), S, E):- % *IMPLEMENTATION HERE*

% postorder_dl(t(K,L,R), S, E):- % *IMPLEMENTATION HERE*



%--------------------------------------------------
% 6. Collects all even keys in a complete binary tree, using difference lists.
% ?- complete_tree(T), even_dl(T, S, E).
% S = [2, 4, 6|E]


% even_dl(t(K,L,R), S, E):- % *IMPLEMENTATION HERE*



%--------------------------------------------------
% 7. Collects, from a incomplete binary search tree, all keys between K1 and K2, using difference lists.
% ?- incomplete_tree(T), between_dl(T, S, E, 3, 7).
% S = [4, 5, 6|E]


% between_dl(t(K,L,R), S, E):- % *IMPLEMENTATION HERE*




%--------------------------------------------------
% 8. Collects, from a incomplete binary search tree, all keys at a given depth K using difference lists.
% ? – incomplete_tree(T), collect_depth_k(T, 2, S, E).
% S = [4, 9|E].

    
% collect_depth_k(t(K,L,R), S, E):- % *IMPLEMENTATION HERE*