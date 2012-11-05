-module(db).
-exports([
	new/0,
		% create a new database.
		% => Db.
	destroy/1,
		% (Db)
		% delete the database.
		% => ok.
	write/3,
		% (Key, Element, Db)
		% writes to a database.
		% => NewDb.
	delete/2,
		% (Key, Db)
		% deletes from a database.
		% => NewDb.
	read/2,
		% (Key, Db)
		% reads from a database.
		% {ok, Element} | {error, instance}.
	match/2
		% (Element, Db)
		% searches a database.
		% => [Key1, ..., KeyN].
]).

new() ->
	[].


destroy(_Db) ->
	ok.


write(Key, Element, Db) ->
	[{Key, Element} | Db].


delete(Key, Db) ->
	delete(Key, Db, []).

delete(_Key, [], NewDb) ->
	NewDb;
delete(Key, [{Key, _Element} | T], NewDb) ->
	delete(Key, T, NewDb);
delete(Key, [H | T], NewDb) ->
	delete(Key, T, [H | NewDb]).


read(_Key, []) ->
	{error, instance};
read(Key, [{Key, Element} | _T]) ->
	{ok, Element};
read(Key, [_H | T]) ->
	read(Key, T).


match(Element, Db) ->
	match(Element, Db, []).

match(_Element, [], Keys) ->
	Keys;
match(Element, [{Key, Element} | T], Keys) ->
	match(Element, T, [Key | Keys]);
match(Element, [_H | T], Keys) ->
	match(Element, T, Keys).
