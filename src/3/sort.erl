-module(sort).
-export([quicksort/1]).
-import(manipulating_lists, [filter/2, concatenate/1]).

quicksort([]) ->
	[];
quicksort([H | T]) ->
	Lows = filter(T, H),
	concatenate([quicksort(Lows), [H], quicksort(T -- Lows)]).