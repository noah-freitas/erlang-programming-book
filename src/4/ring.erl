-module(ring).
-export([start/3]).
-export([loop/1]).

% Starts a message passing chain.
% Message will be passed M times between N nodes.
start(M, N, Message) ->
	FirstNode = createNodes(N),
	sendMessage(M, FirstNode, Message),
	ok.


% Creates N linked nodes running loop.
% The loop's parameter will be the pid of the next node.
createNodes(0) ->
	self();
createNodes(N) ->
	spawn(ring, loop, [createNodes(N - 1)]).


% Sends {message, Message} to FirstNode N times.
% When N == 0, sends stop to FirstNode.
sendMessage(0, FirstNode, _Message) ->
	FirstNode ! stop,
	ok;
sendMessage(N, FirstNode, Message) ->
	FirstNode ! {message, Message},
	sendMessage(N - 1, FirstNode, Message).


% Node message receive loop.
%
% Listening for two meaningful messages:
%	{message, Message}	=> 	Message is printed and passed to next node.
%	stop				=>	Loop is terminated; stop message passed to next node.
%
% Receiving either meaningful message produces debugging output, including the
% message or command received and the pid of the process.
loop(Pid) ->
	receive
		{message, Message} ->
			io:format("~p (From: ~p)~n", [Message, self()]),
			Pid ! {message, Message},
			loop(Pid);
		stop ->
			io:format("Stopping: ~p~n", [self()]),
			Pid ! stop,
			ok;
		_ ->
			loop(Pid)
	end.
