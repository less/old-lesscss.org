
REBAR = rebar
APP = {{appid}}

default: compile

all: deps compile sync

compile:
	$(REBAR) compile

deps:
	$(REBAR) get-deps

clean:
	$(REBAR) clean

generate:
	$(REBAR) generate
	chmod u+x rel/$(APP)/bin/$(APP)

sync:
	cd dev/sync && make && cd -

distclean: clean 
	$(REBAR) delete-deps

console:
	rel/$(APP)/bin/$(APP) console -pa ../../ebin

rebuild:
	$(REBAR) clean compile generate
	chmod u+x rel/$(APP)/bin/$(APP)

eunit:
	$(REBAR) skip_deps=true eunit

docs: deps
	$(REBAR) skip_deps=true doc

dialyzer: compile
	@dialyzer -Wno_return -c apps/$(APP)/ebin

.PHONY: deps

