# SPDX-License-Identifier: LGPL-3.0-or-later
#
# SPDX-FileCopyrightText: 2023 Glenn Y. Rolland <glenux@glenux.net>
# Copyright © 2023 Glenn Y. Rolland <glenux@glenux.net>

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
GRAPHVIZ_DOT_PNG := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.dot,$(GRAPHVIZ_DEST_DIR)/%.dot.png,$(GRAPHVIZ_DOT))
GRAPHVIZ_DOT_PDF := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.dot,$(GRAPHVIZ_DEST_DIR)/%.dot.pdf,$(GRAPHVIZ_DOT))

## Find .circo graphs
GRAPHVIZ_CIRCO := $(shell find $(GRAPHVIZ_SRC_DIR) \( -name '*.circo' ! -name '_*' \))
GRAPHVIZ_CIRCO_SVG := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.circo,$(GRAPHVIZ_DEST_DIR)/%.circo.svg,$(GRAPHVIZ_CIRCO))
GRAPHVIZ_CIRCO_PNG := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.circo,$(GRAPHVIZ_DEST_DIR)/%.circo.png,$(GRAPHVIZ_CIRCO))
GRAPHVIZ_CIRCO_PDF := $(patsubst $(GRAPHVIZ_SRC_DIR)/%.circo,$(GRAPHVIZ_DEST_DIR)/%.circo.pdf,$(GRAPHVIZ_CIRCO))

GRAPHVIZ_SVG := $(GRAPHVIZ_DOT_SVG) $(GRAPHVIZ_CIRCO_SVG)
GRAPHVIZ_PNG := $(GRAPHVIZ_DOT_PNG) $(GRAPHVIZ_CIRCO_PNG)
GRAPHVIZ_PDF := $(GRAPHVIZ_DOT_PDF) $(GRAPHVIZ_CIRCO_PDF)

##
## Prerequisistes (system packages)
##
GRAPHVIZ_APT_PACKAGES := graphviz

##
## Rules
##

$(GRAPHVIZ_DEST_DIR):
	mkdir -p $(GRAPHVIZ_DEST_DIR)

$(GRAPHVIZ_DEST_DIR)/%.dot.svg: $(GRAPHVIZ_SRC_DIR)/%.dot | $(GRAPHVIZ_DEST_DIR)
	dot -Tsvg $< > $@

$(GRAPHVIZ_DEST_DIR)/%.circo.svg: $(GRAPHVIZ_SRC_DIR)/%.circo | $(GRAPHVIZ_DEST_DIR)
	circo -Tsvg $< > $@

$(GRAPHVIZ_SVG): | $(GRAPHVIZ_DEST_DIR)

$(GRAPHVIZ_PDF): | $(GRAPHVIZ_DEST_DIR)

$(GRAPHVIZ_PNG): | $(GRAPHVIZ_DEST_DIR)

.PHONY: graphviz-build-dot-svg
graphviz-build-dot-svg: $(GRAPHVIZ_DOT_SVG)

.PHONY: graphviz-build-circo-svg
graphviz-build-circo-svg: $(GRAPHVIZ_CIRCO_SVG)

.PHONY: graphviz-build-svg
graphviz-build-svg: graphviz-build-dot-svg graphviz-build-circo-svg

.PHONY: graphviz-buil
graphviz-build: graphviz-build-svg


# Clean
#
.PHONY: graphviz-clean-svg
graphviz-clean-svg:
	rm -f $(GRAPHVIZ_SVG)

.PHONY: graphviz-clean-pdf
graphviz-clean-pdf:
	rm -f $(GRAPHVIZ_PDF)

.PHONY: graphviz-clean-png
graphviz-clean-png:
	rm -f $(GRAPHVIZ_PNG)

.PHONY: graphviz-clean
graphviz-clean: graphviz-clean-svg graphviz-clean-png graphviz-clean-pdf

