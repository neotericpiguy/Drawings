SCAD_SRCS=$(shell find -iname '*.scad')
PNGS=$(addprefix $(BUILD_PATH)/,$(SCAD_SRCS:.scad=.png))

BUILD_PATH=preview

all: $(PNGS)

$(BUILD_PATH)/%.png: %.scad
	@mkdir -p $(BUILD_PATH)
	openscad -o $@ $^
