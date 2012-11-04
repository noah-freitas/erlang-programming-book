-module(create).
-export([create/1, create_reverse/1]).

% Creates a list of all the integers between 1 and N.
%
% Return:
%	If N > 1, list is sorted ascending.
%	If N < 1, list is sorted descending.
%
% Example usage:
%	create(3) => [1,2,3]
%	create(-3) => [1,0,-1,-2,-3]
%	create(1) => [1]
create(N) ->
	create_between(1, N).


% Creates a list of all the integers between N and 1.
%
% Return:
%	If N > 1, list is sorted descending.
%	If N < 1, list is sorted ascending.
%
% Example usage:
%	create_reverse(3) => [3,2,1]
%	create_reverse(-3) => [-3,-2,-1,0,1]
%	create_reverse(1) => [1]
create_reverse(N) ->
	create_between(N, 1).
	% Using list module: 
	% list:reverse(create(N)).


% Pattern flow:
%   create_between(1, 3) =>
%     [1 | create_between(2, 3)
%       [2 | create_betwee(3, 3)
%         [3].
%       ]
%     ]
create_between(N, M) when N < M ->
	[N | create_between(N + 1, M)];

% Pattern flow:
%   create_between(3, 1) =>
%     [3 | create_between(2, 1) =>
%       [2 | create_between(1, 1) =>
%         [1].
%       ]
%     ]
create_between(N, M) when N > M ->
	[N | create_between(N - 1, M)];

% Pattern flow:
%   create_between(3, 3) => 
%     [3].
create_between(N, N) ->
	[N].