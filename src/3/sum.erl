-module(sum).
-export([sum/1, sum/2]).

% Returns the sum of all the integers from 0 to N.
% Returns 0 for a negative N.
sum(N) -> sum_acc(N, 0).

sum_acc(N, C) when N > 0 ->
	sum_acc(N - 1, C + N);
sum_acc(_N, C) ->
	C.

% Returns the sum of all the integers in [N, M].
% Returns a negative sum for negative N and M.
sum(N, M) -> sum_acc(N, M, 0).

sum_acc(N, M, C) when N < M ->
	sum_acc(N + 1, M, C + N);
sum_acc(N, M, C) when N == M ->
	C + N.