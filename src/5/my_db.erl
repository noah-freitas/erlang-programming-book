-module(my_db).
-export([start/0, stop/0, write/2, delete/1, read/1, match/1]).
-export([loop/1]).

% Main receive/respond loop for Db server.
% Messages are transformed to calls to the db module functions,
% and the message passing process is responded to.
loop(Db) ->
	receive
		{stop, Pid} -> 
			Pid ! db:destroy(Db);
		{write, Pid, Key, Element} -> 
			NewDb = db:write(Key, Element, Db),
			Pid ! ok,
			loop(NewDb);
		{delete, Pid, Key} -> 
			NewDb = db:delete(Key, Db),
			Pid ! ok,
			loop(NewDb);
		{read, Pid, Key} -> 
			Pid ! db:read(Key, Db),
			loop(Db);
		{match, Pid, Element} ->
			Pid ! db:match(Element, Db),
			loop(Db)
	end.


% Starts a new Db Server with an empty Db.
% => ok.
start() ->
	register(my_db, spawn(my_db, loop, [db:new()])),
	ok.


% Stops the Db Server.
% => ok.
stop() ->
	my_db ! {stop, self()},
	receive Message -> Message 	end.


% Writes a Key, Element pair to the Db.
% => ok.
write(Key, Element) ->
	my_db ! {write, self(), Key, Element},
	receive Message -> Message 	end.


% Deletes a Key, Element pair from the Db.
% => ok.
delete(Key) ->
	my_db ! {delete, self(), Key},
	receive Message -> Message 	end.


% Reads an Element from the Db referenced by Key.
% => {ok, Element} | {error, instance}.
read(Key) ->
	my_db ! {read, self(), Key},
	receive Message -> Message 	end.


% Searches the Db for Element and returns the associated Keys
% => [Key1, ..., KeyN].
match(Element) ->
	my_db ! {match, self(), Element},
	receive Message -> Message 	end.
