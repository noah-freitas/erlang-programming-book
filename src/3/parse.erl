-module(parse).
-export([parse/1]).

parse([C | Rest], Stack = [S1 | PoppedStack], Buffer, Output) ->
    case C of
        ( -> parse(Rest, [C | Stack], Buffer, Output);
        ) ->
            [ParensExp | PoppedOutput] = Output,
            parse(Rest, [ParensExp | Stack], Buffer, PoppedOutput);
        + -> parse(Rest, PoppedStack, {add, S1}, Output);
        C when is_integer(C) -> 
            if
                Buffer == {} -> parse(Rest, [{num, C} | Stack], Buffer, Output);
                Buffer != {} -> parse(Rest, Stack, {}, [append_element(Buffer, {num, C}) | Output])
            end
    end.
