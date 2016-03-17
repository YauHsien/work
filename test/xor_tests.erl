-module(xor_tests).
-include_lib("eunit/include/eunit.hrl").
-include("../include/assignment.hrl").

swap_test() ->
    {{Y,Mt,D},{H,Mn,S}} = calendar:local_time(),
    random:seed(Y+H, Mt+Mn, D+S),
    N = random:uniform(1000000),
    M = random:uniform(1000000) + 1000000,
    io:fwrite("[test] swapping ~B and ~B...~n", [N, M]),
    {?binding(a, N1), ?binding(b, M1)} =
        xor_:swap(?binding(a, N), ?binding(b, M)),
    ?assert(N =:= M1),
    ?assert(M =:= N1),
    ok.
