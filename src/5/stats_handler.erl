-module(stats_handler).
-export([init/1, terminate/1, handle_event/2]).

init(_) ->
    dict:new().

terminate(Dict) -> ok.

handle_event({get_data, Key}, Dict) ->
	case dict:find(Key, Dict) of
		{ok, Count} -> Count;
		error -> 0
	end;
handle_event({Type, _Id, Description}, Dict) ->
	dict:update_counter({Type, Description}, 1, Dict);
handle_event(_, Dict) ->
	Dict.
