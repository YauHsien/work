.PHONY: all test clean


all:
	./rebar compile

test:
	./rebar eunit

clean:
	rm ebin/*
	rm */*~
	rm */#*
