SCAD_SRCS=$(shell find -iname '*.scad')
PNGS=$(addprefix $(BUILD_PATH)/,$(SCAD_SRCS:.scad=.png))
INC_PATHS=$(shell find modules -type d -not -iname '*git*')

SCAD_PNG_VIEWS_SRCS=$(shell find -iname '*_top.scad')
TOP_PNG=$(addprefix $(BUILD_PATH)/,$(SCAD_PNG_VIEWS_SRCS:_top.scad=_top_view.png))
SIDE_PNG=$(addprefix $(BUILD_PATH)/,$(SCAD_PNG_VIEWS_SRCS:_top.scad=_side_view.png))
FRONT_PNG=$(addprefix $(BUILD_PATH)/,$(SCAD_PNG_VIEWS_SRCS:_top.scad=_front_view.png))
ISO_PNG=$(addprefix $(BUILD_PATH)/,$(SCAD_PNG_VIEWS_SRCS:_top.scad=_iso_view.png))
PNG_VIEWS=$(TOP_PNG) $(SIDE_PNG) $(FRONT_PNG) $(ISO_PNG)

space := $(subst ,, )
MODULE_PATHS:= $(subst $(space),:,$(INC_PATHS))

# https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_OpenSCAD_in_a_command_line_environment
BUILD_PATH=preview
PNG_OPTS=--view=wireframe --autocenter --viewall --projection=o
TOP_VIEW =--camera=0,0,0,0,0,-90 $(PNG_OPTS)
SIDE_VIEW =--camera=0,0,0,-90,0,0 $(PNG_OPTS)
FRONT_VIEW =--camera=0,0,0,0,90,0 $(PNG_OPTS)
ISO_VIEW =--camera=0,0,0,-90,90,-90 $(PNG_OPTS)

all: $(PNG_VIEWS) $(PNGS) README.md

README.md: $(PNGS) ./bin/previews
	@./bin/previews

$(BUILD_PATH)/%.png: %.scad
	@mkdir -p $(@D)
	OPENSCADPATH=$(MODULE_PATHS) openscad -o $@ $^

$(BUILD_PATH)/%_top_view.png: %_top.scad
	@mkdir -p $(@D)
	OPENSCADPATH=$(MODULE_PATHS) openscad $(TOP_VIEW) -o $@ $^

$(BUILD_PATH)/%_side_view.png: %_top.scad
	@mkdir -p $(@D)
	OPENSCADPATH=$(MODULE_PATHS) openscad $(SIDE_VIEW) -o $@ $^

$(BUILD_PATH)/%_front_view.png: %_top.scad
	@mkdir -p $(@D)
	OPENSCADPATH=$(MODULE_PATHS) openscad $(FRONT_VIEW) -o $@ $^

$(BUILD_PATH)/%_iso_view.png: %_top.scad
	@mkdir -p $(@D)
	OPENSCADPATH=$(MODULE_PATHS) openscad $(ISO_VIEW) -o $@ $^

clean:
	-rm -rf $(PNGS) $(PNG_VIEWS)

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
