-module(echo).
-export([start/0, print/1, stop/0]).
-export([loop/0]).

start() ->
	register(echo, spawn(echo, loop, [])),
	ok.

loop() ->
	receive
		stop -> {ok, self()};
		{print, Term} -> io:format("~w~n", [Term]), loop();
		_ -> loop(), ok
	end.

print(Term) ->
	echo ! {print, Term},
	ok.

stop() ->
	echo ! stop,
	unregister(echo),
	ok.
