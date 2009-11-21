-module(tested).
-export([main/0]).

main() ->
	case io:fread("", "~d") of
		eof -> true;
		{ok, [42]} -> true;
		{ok, [X]} -> io:format("~B~n", [X]), main()
	end.
