start :- 
	get_input(Input),
	count_next_higher(Input, TrueCount),
	pprint(TrueCount).

/* Getting input stream */

%% this predicate should be called first, others for recursion
get_input(Input) :-
	open("input.txt", read, Stream),
	read_line_to_codes(Stream, Line1),
	get_input(Stream, Line1, Input).
	
get_input(Stream, Line1, Input) :-
	get_input(Stream, Line1, [], Input).
	
get_input(_, end_of_file, Input, Input).

get_input(Stream, Line, Acc, Input) :-
	is_list(Line),
	append(Acc, [Line], Acc1),
	read_line_to_codes(Stream, Line1),
	get_input(Stream, Line1, Acc1, Input).

/* actual part 1 */
count_next_higher(Input, TrueCount) :-
	count_next_higher(Input, 0, TrueCount). 

%% input is empty, end of input
count_next_higher([], C, C).

count_next_higher([_], C, C).

count_next_higher([X|Xs], C, R) :-
	split_string(X, ",", "", Head), %% convert char array to 1 single (string) list item
	next_higher(Head, Xs),
	C1 is C + 1,
	count_next_higher(Xs, C1, R).
	
count_next_higher([X|Xs], C, R) :-
	split_string(X, ",", "", Head),
	\+ next_higher(Head, Xs),
	count_next_higher(Xs, C, R).
	
next_higher(H, [T|_]) :-
	split_string(T, ",", "", B),
	atomics_to_string(H, "", A),
	atomics_to_string(B, "", B1),
	atom_number(A, A1),
	atom_number(B1, B2),
	B2 > A1.

/* printing prettily */
pprint(TrueCount) :-
	format("Number of numbers higher than the previous one are ~p ~n", [TrueCount]).
