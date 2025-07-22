DOMAINS
	node = symbol
	nodeList = node*

PREDICATES
	Nondeterm child(node, node)
	Nondeterm dfs(node, node, nodeList)
	Nondeterm dfs_child(node, node, nodeList) 

CLAUSES

	child(a, b).
	child(a, c).
	child(a, d).
	child(b, e).
	child(b, f).
	child(c, g).


	dfs(A, G, [A | Z]) :- dfs_child(A, G, Z). 
	
	dfs_child(A, G, [G]) :- child(A, G).

	dfs_child(A, G, [X | L]) :- child(A, X), dfs_child(X, G, L).


GOAL
	dfs(a, e, Path),
	write("DFS Path: "), 
	write(Path), nl.