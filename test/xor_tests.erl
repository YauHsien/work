-module(xor_tests).
-include_lib("eunit/include/eunit.hrl").
-include("../include/assignment.hrl").

swap_test() ->
    {?binding(a, N), ?binding(b, M)} =
        xor_:swap(?binding(a, 3), ?binding(b, 5)),
    ?assert(N =:= 5),
    ?assert(M =:= 3),
    ok.
