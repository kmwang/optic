%%%-------------------------------------------------------------------
%%% @doc
%%% Tests for src/optic_proplists.erl
%%% @end
%%%-------------------------------------------------------------------
-module(test_optic_proplists).

-include_lib("eunit/include/eunit.hrl").

%%%===================================================================
%%% Tests
%%%===================================================================

all_get_test_() ->
    [?_assertEqual({ok, [1, 1, 2, 3]},
                   optic:get([optic_proplists:all()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}])),
     ?_assertEqual({error, undefined},
                   optic:get([optic_proplists:all()], atom))].

all_put_test_() ->
    [?_assertEqual({ok, [{one, 4}, {one, 4}, {two, 4}, {three, 4}]},
                   optic:put([optic_proplists:all()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}],
                             4)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_proplists:all()], atom, 4))].

all_create_test() ->
    ?assertEqual({ok, []},
                 optic:put([optic_proplists:all([create])], atom, 4)).

keys_get_test_() ->
    [?_assertEqual({ok, [one, one, two, three]},
                   optic:get([optic_proplists:keys()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}])),
     ?_assertEqual({error, undefined},
                   optic:get([optic_proplists:keys()], atom))].

keys_put_test_() ->
    [?_assertEqual({ok, [{four, 1}, {four, 1}, {four, 2}, {four, 3}]},
                   optic:put([optic_proplists:keys()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}],
                             four)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_proplists:keys()], atom, four))].

keys_create_test() ->
    ?assertEqual({ok, []},
                 optic:put([optic_proplists:keys([create])], atom, four)).

values_get_test_() ->
    [?_assertEqual({ok, [1, 1, 2, 3]},
                   optic:get([optic_proplists:values()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}])),
     ?_assertEqual({error, undefined},
                   optic:get([optic_proplists:values()], atom))].

values_put_test_() ->
    [?_assertEqual({ok, [{one, 4}, {one, 4}, {two, 4}, {three, 4}]},
                   optic:put([optic_proplists:values()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}],
                             4)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_proplists:values()], atom, 4))].

values_create_test() ->
    ?assertEqual({ok, []},
                 optic:put([optic_proplists:values([create])], atom, 4)).

properties_get_test_() ->
    [?_assertEqual({ok, [{one, 1}, {one, 1}, {two, 2}, {three, 3}]},
                   optic:get([optic_proplists:properties()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}])),
     ?_assertEqual({error, undefined},
                   optic:get([optic_proplists:properties()], atom))].

properties_put_test_() ->
    [?_assertEqual({ok, [{four, 4}, {four, 4}, {four, 4}, {four, 4}]},
                   optic:put([optic_proplists:properties()],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}],
                             {four, 4})),
     ?_assertEqual({error, undefined},
                   optic:put([optic_proplists:properties()], atom, four))].

properties_create_test() ->
    ?assertEqual({ok, []},
                 optic:put([optic_proplists:properties([create])], atom, four)).

key_get_test_() ->
    [?_assertEqual({ok, [1, 1.5]},
                   optic:get([optic_proplists:key(one)],
                             [{one, 1}, {one, 1.5}, {two, 2}, {three, 3}])),
     ?_assertEqual({error, undefined},
                   optic:get([optic_proplists:key(one)], atom))].

key_put_test_() ->
    [?_assertEqual({ok, [{one, 4}, {one, 4}, {two, 2}, {three, 3}]},
                   optic:put([optic_proplists:key(one)],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}],
                             4)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_proplists:key(one)], atom, 4))].

key_create_test_() ->
    [?_assertEqual({ok, [{four, 4}, {one, 1}]},
                   optic:put([optic_proplists:key(four, [create])], [{one, 1}], 4)),
     ?_assertEqual({ok, [{four, 4}]},
                   optic:put([optic_proplists:key(four, [create])], atom, 4))].

property_get_test_() ->
    [?_assertEqual({ok, [{one, 1}, {one, 1.5}]},
                   optic:get([optic_proplists:property(one)],
                             [{one, 1}, {one, 1.5}, {two, 2}, {three, 3}])),
     ?_assertEqual({error, undefined},
                   optic:get([optic_proplists:property(one)], atom))].

property_put_test_() ->
    [?_assertEqual({ok, [{four, 4}, {four, 4}, {two, 2}, {three, 3}]},
                   optic:put([optic_proplists:property(one)],
                             [{one, 1}, {one, 1}, {two, 2}, {three, 3}],
                             {four, 4})),
     ?_assertEqual({error, undefined},
                   optic:put([optic_proplists:property(one)], atom, 4))].

property_create_test_() ->
    [?_assertEqual({ok, [{four, 4}, {one, 1}]},
                   optic:put([optic_proplists:property(four, [create])], [{one, 1}], {four, 4})),
     ?_assertEqual({ok, [{four, 4}]},
                   optic:put([optic_proplists:property(four, [create])], atom, {four, 4}))].
