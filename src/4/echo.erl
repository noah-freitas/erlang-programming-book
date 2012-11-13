-module(echo).
-export([start/0, print/1, stop/0]).
-export([loop/0]).

start() ->
	register(echo, spawn(echo, loop, [])),
	ok.

loop() ->
	receive
		stop -> {ok, self()};
		{print, Term} -> print(Term), loop();
		_ -> loop(), ok
	end.

print(Term) ->
	io:format("~w~n", [Term]).

stop() ->
	case echo of
		% This first case doesn't seem to work.
		undefined -> ok;
		_ -> echo ! stop, unregister(echo), ok
	end.
