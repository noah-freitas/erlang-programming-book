-module(db_lists).
-export([
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
	lists:delete(Key, Db).


read(Key, Db) ->
	case lists:keyfind(Key, 1, Db) of
		false -> {error, instance};
		{_Key, Element} -> {ok, Element}
	end.


match(Element, Db) ->
	lists:reverse(match(Element, Db, [])).
match(Element, Db, Keys) ->
	case lists:keytake(Element, 2, Db) of
		false -> Keys;
		{value, {Key, _Element}, NewDb} -> match(Element, NewDb, [Key | Keys])
	end.