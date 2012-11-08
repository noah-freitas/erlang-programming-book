-module(sort).
-export([
	quicksort/1,
		% (List)
		% sorts list ascending using quicksort.
		% => SortedList
	merge_sort/1
		% (List)
		% sorts list ascending using mergesort.
		% => SortedList
]).
-import(manipulating_lists, [filter/2, concatenate/1]).

quicksort([]) ->
	[];
quicksort([H | T]) ->
	Lows = filter(T, H),
	concatenate([quicksort(Lows), [H], quicksort(T -- Lows)]).


merge_sort(L) when length(L) < 2 ->
	L;
merge_sort(L) ->
	{List1, List2} = lists:split(length(L) div 2, L),
	merge(merge_sort(List1), merge_sort(List2), []).

merge([], [], Merged) ->
	lists:reverse(Merged);
merge([H | T], [], Merged) ->
	merge(T, [], [H | Merged]);
merge([], [H | T], Merged) ->
	merge([], T, [H | Merged]);
merge([H1 | T1], [H2 | T2], Merged) when H1 =< H2 ->
	merge(T1, [H2 | T2], [H1 | Merged]);
merge(List1, [H | T], Merged) ->
	merge(List1, T, [H | Merged]).
