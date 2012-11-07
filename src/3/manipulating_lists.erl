-module(manipulating_lists).
-export([
	filter/2,
		% (List, IntegerLimit)
		% creates a list with all the integers in List less than IntegerLimit.
		% => FilteredList
	reverse/1
		% (List)
		% returns a reverse of List.
		% => ReversedList
]).

filter(L, I) ->
	filter(L, I, []).
filter([], _I, N) ->
	reverse(N);
filter([H | T], I, N) when H =< I ->
	filter(T, I, [H | N]);
filter([_H | T], I, N) ->
	filter(T, I, N).

reverse(L) ->
	reverse(L, []).
reverse([], N) ->
	N;
reverse([H | T], N) ->
	reverse(T, [H | N]).