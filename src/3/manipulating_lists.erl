-module(manipulating_lists).
-export([
	filter/2,
		% (List, IntegerLimit)
		% creates a list with all the integers in List less than IntegerLimit.
		% => FilteredList
	reverse/1,
		% (List)
		% creates a reverse of List.
		% => ReversedList
	concatenate/1
		% (ListOfLists)
		% concatenates a list of lists into a single list.
		% => ConcatenatedList
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

concatenate(L) ->
	concatenate(L, []).
concatenate([], Con) ->
	reverse(Con);
concatenate([[] | List], Con) ->
	concatenate(List, Con);
concatenate([[H | T] | List], Con) ->
	concatenate([T | List], [H | Con]).
