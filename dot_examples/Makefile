%.svg: src/%.dot
	dot -Tsvg $^ > $@

all: test.svg cool.svg

clean:
	-rm *.svg

