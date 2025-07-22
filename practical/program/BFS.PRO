DOMAINS
    node = symbol
    nodelist = node*
    queue = nodelist*

PREDICATES
    child(node, node)
    bfs(node, node, nodelist)
    bfs_search(queue, node, nodelist)
    get_children(node, nodelist)
    append(queue, queue, queue)
    extend_path(node, nodelist, queue)
    create_paths(nodelist, nodelist, queue)
    reverse(nodelist, nodelist)
    reverse_acc(nodelist, nodelist, nodelist)
    write_path(nodelist)

CLAUSES
    child(a, b). child(a, c). child(a, d).
    child(b, e). child(b, f). child(c, g).

    append([], L, L).
    append([H | T], L, [H | R]) :- append(T, L, R).

    get_children(Node, Children) :-
        findall(Child, child(Node, Child), Children).

    extend_path(Last, Path, NewPaths) :-
        get_children(Last, Children),
        create_paths(Children, Path, NewPaths).

    create_paths([], _, []).
    create_paths([Child | Rest], Path, [[Child | Path] | NewPaths]) :-
        create_paths(Rest, Path, NewPaths).

    bfs(Start, Target, Path) :-
        bfs_search([[Start]], Target, RevPath),
        reverse(RevPath, Path).

    bfs_search([[Target | Rest] | _], Target, [Target | Rest]).
    bfs_search([[Node | Rest] | Queue], Target, FinalPath) :-
        extend_path(Node, [Node | Rest], NewPaths),
        append(Queue, NewPaths, UpdatedQueue),
        bfs_search(UpdatedQueue, Target, FinalPath).

    reverse(L, R) :- reverse_acc(L, [], R).
    reverse_acc([], Acc, Acc).
    reverse_acc([H | T], Acc, R) :- reverse_acc(T, [H | Acc], R).

    write_path([]) :- nl.
    write_path([H]) :- write(H), nl.
    write_path([H | T]) :- write(H), write(" "), write_path(T).

GOAL
    bfs(a, g, Path),
    write_path(Path), !.
