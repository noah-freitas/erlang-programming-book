-module(echo).
-export([start/0, print/1, stop/0]).
-export([loop/0]).

start() ->
	register(echo, spawn(echo, loop, [])).

loop() ->
	receive
		stop -> ok;
		{print, Term} -> print(Term), loop();
		Unknown -> ok
	end.

print(Term) ->
	io:format("~w~n", [Term]).

stop() ->
	echo ! stop,
	unregister(echo).
