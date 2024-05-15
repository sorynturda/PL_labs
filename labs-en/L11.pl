%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 			LABORATORY 11 EXAMPLES		%%%%%%
%%%%%% Graphs Search Algorithms (DFS & BFS) %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

edge(1,2).
edge(1,5).
edge(2,3).
edge(2,5).
edge(3,4).
edge(4,5).
edge(4,6).


%--------------------------------------------------
% The DFS predicate %
%--------------------------------------------------
:- dynamic visited_node/1.

% dfs(Source, Path)
dfs(X,_) :- df_search(X). % traversal of nodes
% when traversal is finished, collection starts
dfs(_,L) :- !, collect_reverse([], L). % collecting results

% traversal predicate
df_search(X):-
    % store X as visited node
    asserta(visited_node(X)),
    % take the first edge from X to a Y
    % the rest are found through backtracking
    edge(X,Y),
    % check if this Y was already visited
    not(visited_node(Y)),
    % if it was not -this is why the negation is needed – 
    % then we continue the traversal by moving the current node to Y
    df_search(Y).

% collecting predicate - collecting is done in reverse order
collect_reverse(L, P):-
    % we retract each stored visited node
    retract(visited_node(X)), !, 
    % we add it to the list as the first element
    % thus, they will appear reversed
    collect_reverse([X|L], P).
    % we unify the first and second arguments, 
    % the result will be in the second argument
collect_reverse(L,L).


% Follow the execution of:
% ?- dfs(1,R).
% R = [1, 2, 3, 4, 5, 6].



%--------------------------------------------------
% The BFS predicate %
%--------------------------------------------------
:- dynamic visited_node/1.
:- dynamic queue/1.   % the queue stores the nodes that need to be expanded

% bfs(Source, Path)
bfs(X, _):- % traversal of nodes
    assertz(visited_node(X)), % add source as visited
    assertz(queue(X)), % add source as first element in queue
    bf_search. 
bfs(_,R):- !, collect_reverse([],R). % collecting results (same as previous)

bf_search:-
    retract(queue(X)), %retract node that needs to be expanded
    expand(X), !, % call expand predicate
    bf_search. % recursion

expand(X):-	
    edge(X,Y), % find a node Y linked to given X
    not(visited_node(Y)), % check if Y was already visited
    % if Y was not visited before
    asserta(visited_node(Y)), % add Y to visited nodes
    assertz(queue(Y)), % add Y to queue to be expanded 
    % at some point
    fail. % fail required to find another Y
expand(_).

% Follow the execution of:
% ?- bfs(1,R).
% R = [1, 2, 5, 3, 4, 6].


%--------------------------------------------------
% The Best-First Search predicate %
%--------------------------------------------------
pos_vec(start,0,2,[a,d]).
pos_vec(a,2,0,[start,b]).
pos_vec(b,5,0,[a,c, end]).
pos_vec(c,10,0,[b, end]).
pos_vec(d,3,4,[start,e]).
pos_vec(e,7,4,[d]).
pos_vec(end,7,2,[b,c]).

is_target(end).



best([], []):-!.
best([[Target|Rest]|_], [Target|Rest]):- is_target(Target),!.
best([[H|T]|Rest], Best):-
	pos_vec(H,_,_, Neighb),
	expand(Neighb, [H|T], Rest, Exp),
	quick_sort(Exp, SortExp, []),
	best(SortExp, Best).

% Based on the current path (second argument), the expand/4 predicate 
% searches for neighbours of the last expansion (first argument) 
expand([],_,Exp,Exp):- !.
expand([H|T],Path,Rest,Exp):- 
	\+(member(H,Path)), !, expand(T,Path,[[H|Path]|Rest],Exp).
expand([_|T],Path,Rest,Exp):- expand(T,Path,Rest,Exp).

% The quick_sort/3 predicate uses difference lists
quick_sort([H|T],S,E):-
	partition(H,T,A,B),
	quick_sort(A,S,[H|Y]),
	quick_sort(B,Y,E).
quick_sort([],S,S).

% In this case, the partition/4 predicate uses an auxiliary predicate 
% order/2 that defines how the partition should be made
% based on distances
partition(H,[A|X],[A|Y],Z):- order(A,H), !, partition(H,X,Y,Z).
partition(H,[A|X],Y,[A|Z]):- partition(H,X,Y,Z).
partition(_,[],[],[]).

% predicate that calculates the distance between two nodes
dist(Node1,Node2,Dist):-
pos_vec(Node1, X1, Y1, _),
pos_vec(Node2, X2, Y2, _),
	Dist is (X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2).

% the order/2 predicate based on distances used in partition/4 
order([Node1|_],[Node2|_]):- 
is_target(Target),
	dist(Node1,Target,Dist1),
	dist(Node2,Target,Dist2),
	Dist1<Dist2.



% Follow the execution of:
% ?- best([[start]], Best).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 				EXERCISES				%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------
% 1. Modify the DFS predicate such that it searches nodes only to a given depth (DLS – Depth-Limited Search). Set the depth limit via a predicate, depth_max(2). for example.
% ?- d_search(a,DFS), dl_search(a, DLS).
% DFS = [a, b, d, e, g, c, f, h],
% DLS = [a, b, d, c, f].

edge_ex1(a,b).
edge_ex1(a,c).
edge_ex1(b,d).
edge_ex1(d,e).
edge_ex1(c,f).
edge_ex1(e,g).
edge_ex1(f,h).

% dl_search(X, R):- % *IMPLEMENTATION HERE* 
 