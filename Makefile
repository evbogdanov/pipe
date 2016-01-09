.PHONY: compile run test

compile:
	rebar compile

run:
	erl -env ERL_LIBS `pwd` +pc unicode

test:
	rebar eunit
