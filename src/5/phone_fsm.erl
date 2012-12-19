-module(phone_fsm).

idle() ->
    receive
		{Number, incoming} ->
			start_ringing(),
			ringing(Number);
		off_hook ->
			start_tone(),
			dial()
	end.

ringing(Number) ->
	receive
		{Number, other_on_hook} ->
			stop_ringing(),
			idle();
		{Number, off_hook} ->
			stop_ringing(),
			connected(Number)
	end.

start_ringing() ->
	receive
		off_hook -> stop_ringing();
		other_on_hood -> stop_ringing();
		_ -> start_ringing()
	end.

stop_ringing() ->
	.

start_tone() ->
	.