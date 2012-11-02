-module(boolean).
-export([b_not/1, b_and/2, b_or/2, b_nand/2]).

b_not(false) ->
	true;
b_not(true) ->
	false;
b_not(_) ->
	{error, unknown_boolean};

