-module(boolean).
-export([b_not/1, b_and/2, b_or/2, b_nand/2]).

b_not(false) ->
	true;
b_not(true) ->
	false;
b_not(_) ->
	{error, unknown_boolean}.

b_and(false, _) ->
	false;
b_and(true, true) ->
	true;
b_and(_, _) ->
	false.

b_or(true, _) ->
	true;
b_or(_, true) ->
	true;
b_or(_, _) ->
	false.

b_nand(true, false) ->
	true;
b_nand(false, true) ->
	true;
b_nand(_, _) ->
	false.
