-module(xor_).
-include("../include/assignment.hrl").

-export([swap/2]).

swap(?binding(A, N), ?binding(B, M)) ->
    Maxb = meet_axb(N, M),
    BindingB1 = ?binding(B, Maxb(M)),
    {_, M1} = BindingB1,
    BindingA1 = ?binding(A, Maxb(M1)),
    {BindingA1, BindingB1}.

meet_axb(N, M) ->
    K = N bxor M,
    fun(S) ->
        K bxor S
    end.
