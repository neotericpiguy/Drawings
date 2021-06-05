SCAD_SRCS=$(shell find -iname '*.scad')
PNGS=$(addprefix $(BUILD_PATH)/,$(SCAD_SRCS:.scad=.png))
INC_PATHS=$(shell find modules -type d -not -iname '*git*')

space := $(subst ,, )
MODULE_PATHS:= $(subst $(space),:,$(INC_PATHS))

BUILD_PATH=preview

all: $(PNGS) README.md

README.md: $(PNGS) ./bin/previews
	@./bin/previews

$(BUILD_PATH)/%.png: %.scad
	@mkdir -p `dirname $@`
	OPENSCADPATH=$(MODULE_PATHS) openscad -o $@ $^

clean:
	-rm -rf $(PNGS)

distclean:
	-rm -rf $(BUILD_PATH) README.md

repoclean:
	git clean -fxxd

#Not required but good to have
style-check: $(SCAD_SRCS)
	clang-format -i $^
	@if [ "`git diff --name-only  | wc -l`" -gt "1" ]; then \
		echo "Non compliant with style:"; \
		git diff --name-only; \
		git diff; \
		exit 1;\
	fi

view:
	OPENSCADPATH=$(MODULE_PATHS) openscad modules/
