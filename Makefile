SCAD_SRCS=$(shell find -iname '*.scad')
PNGS=$(addprefix $(BUILD_PATH)/,$(SCAD_SRCS:.scad=.png))

BUILD_PATH=preview

all: $(PNGS)

$(BUILD_PATH)/%.png: %.scad
	@mkdir -p $(BUILD_PATH)
	openscad -o $@ $^

clean:
	-rm -rf $(PNGS)

distclean:
	-rm -rf $(BUILD_PATH)

repoclean:
	git clean -fxxd
