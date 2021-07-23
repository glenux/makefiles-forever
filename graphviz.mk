##
## GRAPHVIZ MODULE
##

##
## External variables influencing build process (API)
##
GRAPHVIZ_SRC_DIR ?=
GRAPHVIZ_DEST_DIR ?=

##
## Internal variables
##

## Find .dot graphs
GRAPHVIZ_DOT := $(shell find $(GRAPHVIZ_SRC_DIR) \( -name '*.dot' ! -name '_*' \))
GRAPHVIZ_DOT_SVG := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.dot,$(GRAPHVIZ_DEST_DIR)/%.dot.svg,$(GRAPHVIZ_DOT))

## Find .circo graphs
GRAPHVIZ_CIRCO := $(shell find $(GRAPHVIZ_SRC_DIR) \( -name '*.circo' ! -name '_*' \))
GRAPHVIZ_CIRCO_SVG := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.circo,$(GRAPHVIZ_DEST_DIR)/%.circo.svg,$(GRAPHVIZ_CIRCO))
GRAPHVIZ_SVG := $(GRAPHVIZ_DOT_SVG) $(GRAPHVIZ_CIRCO_SVG)

##
## Prerequisistes (system packages)
##
GRAPHVIZ_APT_PACKAGES := graphviz

##
## Rules
##

$(GRAPHVIZ_DEST_DIR)/%.dot.svg: $(GRAPHVIZ_SRC_DIR)/%.dot
	dot -Tsvg $< > $@

$(GRAPHVIZ_DEST_DIR)/%.circo.svg: $(GRAPHVIZ_SRC_DIR)/%.circo
	circo -Tsvg $< > $@

$(GRAPHVIZ_SVG): | $(GRAPHVIZ_DEST_DIR)
	mkdir -p $(GRAPHVIZ_DEST_DIR)

graphviz-build-dot-svg: $(GRAPHVIZ_DOT_SVG)

graphviz-build-circo-svg: $(GRAPHVIZ_CIRCO_SVG)

graphviz-build-svg: graphviz-build-dot-svg graphviz-build-circo-svg

graphviz-build: graphviz-build-svg


# Clean
#
graphviz-clean-svg:
	rm -f $(GRAPHVIZ_SVG)

graphviz-clean: graphviz-clean-svg

