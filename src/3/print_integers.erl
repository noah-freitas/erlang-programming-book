-module(print_integers).
-export([to/1, even_to/1]).

% Prints all the integers from 1 to N.
%
% Example usage:
%	to(3) =>
%		< Number:1
%		< Number:2
%		< Number:3
to(N) ->
	L = integers_between(1, N),
	print(L).


% Prints all the even integers from 1 to N.
%
% Example usage:
%	even_to(5) =>
%		< Number:2
%		< Number:4
even_to(N) ->
	L = even_integers_between(2, (N div 2) * 2), % Make sure N is even.
	print(L).


% Same functionality as create module, not sure how to import it here.
integers_between(N, M) when N < M ->
	[N | integers_between(N + 1, M)];
integers_between(N, N) ->
	[N].


even_integers_between(N, M) when N < M ->
	[N | even_integers_between(N + 2, M)];
even_integers_between(N, N) ->
	[N].


print([H | []]) ->
	io:format("Number:~p~n", [H]);
print([H | T]) ->
	io:format("Number:~p~n", [H]),
	print(T).