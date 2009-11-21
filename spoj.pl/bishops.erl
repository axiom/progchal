-module(bishops).
-export([main/0]).

main() ->
	case io:fread("", "~d") of
		{ok, [B]} when B > 2 -> io:format("~B~n", [2 * B - 2]), main();
		{ok, [B]} -> io:format("~B~n", [B]), main();
		eof -> true
	end.
