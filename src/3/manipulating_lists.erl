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

filter([], _I) ->
	[];
filter([H | T], I) when H =< I ->
	[H | filter(T, I)];
filter([_H | T], I) ->
	filter(T, I).

reverse(L) ->
	reverse(L, []).
reverse([], N) ->
	N;
reverse([H | T], N) ->
	reverse(T, [H | N]).