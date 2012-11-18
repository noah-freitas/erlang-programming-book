-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).

start() ->
	register(frequency, spawn(frequency, init, [])).

init() ->
	Frequencies = {get_frequencies(), []},
	loop(Frequencies).

get_frequencies() ->
	[10, 11, 12, 13, 14, 15].

stop() ->
	call(self(), stop).

allocate() ->
	call(self(), allocate).

deallocate(Freq) ->
	call(self(), {deallocate, Freq}).

call(Pid, Message) ->
	frequency ! {request, Pid, Message},
	receive
		{reply, Reply} -> Reply
	end.

loop(Frequencies) ->
	receive
		{request, Pid, allocate} ->
			{NewFrequencies, Reply} = allocate(Frequencies, Pid),
			reply(Pid, Reply),
			loop(NewFrequencies);
		{request, Pid, {deallocate, Freq}} ->
			NewFrequencies = deallocate(Frequencies, Freq, Pid),
			reply(Pid, ok),
			loop(NewFrequencies);
		{request, Pid, stop} ->
			{_Free, Allocated} = Frequencies,
			% Only stop the loop if there are no allocated frequencies.
			if
				Allocated == [] ->
					reply(Pid, ok);
				Allocated /= [] ->
					reply(Pid, {error, allocated_frequencies}),
					loop(Frequencies)
			end
	end.

reply(Pid, Reply) ->
	Pid ! {reply, Reply}.

allocate({[], Allocated}, _Pid) ->
	{{[], Allocated}, {error, no_frequency}};
allocate({[Freq|Free], Allocated}, Pid) ->
	% If this Pid has already been allocated 3 frequencies, return a
	% frequency_quota error.  Otherwise allocate a new frequency to this Pid.
	case lists:filter(fun ({_Freq, Pid2}) -> Pid == Pid2 end, Allocated) of
		X when length(X) < 3 -> {{Free, [{Freq, Pid} | Allocated]}, {ok, Freq}};
		_ -> {{[Freq|Free], Allocated}, {error, frequency_quota}}
	end.

deallocate({Free, Allocated}, Freq, Pid) ->
	NewAllocated = lists:delete({Freq, Pid}, Allocated),
	{[Freq|Free], NewAllocated}.
