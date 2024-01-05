# SPDX-License-Identifier: LGPL-3.0-or-later
#
# SPDX-FileCopyrightText: 2023 Glenn Y. Rolland <glenux@glenux.net>
# Copyright © 2023 Glenn Y. Rolland <glenux@glenux.net>

##
## MOCODO MODULE
##

##
## External variables (API)
##
MOCODO_OPT ?= --colors brewer-6 --shapes verdana
MOCODO_SRC_DIR ?=
MOCODO_DEST_DIR ?=

##
## Internal variables (lazy recursive evaluation)
##

## Find .mcd and .mld files
## Convert .mcd to .mcd.mld, .mcd.svg and .mcd.pdf files
## Convert .mld to .mld.svg, and .mld.pdf files

MOCODO_MCD_FILES = $(shell find $(MOCODO_SRC_DIR) \( -name '*.mcd' ! -name '_*' \))
MOCODO_MCD_MLD = $(patsubst $(MOCODO_SRC_DIR)/%.mcd,$(MOCODO_DEST_DIR)/%.mcd.mld,$(MOCODO_MCD_FILES))
MOCODO_MCD_SVG = $(patsubst $(MOCODO_SRC_DIR)/%.mcd,$(MOCODO_DEST_DIR)/%.mcd.svg,$(MOCODO_MCD_FILES))
MOCODO_MCD_PDF = $(patsubst $(MOCODO_SRC_DIR)/%.mcd,$(MOCODO_DEST_DIR)/%.mcd.pdf,$(MOCODO_MCD_FILES))

MOCODO_MLD_FILES = $(shell find $(MOCODO_SRC_DIR) \( -name '*.mld' ! -name '_*' \)) $(MOCODO_MCD_MLD)
MOCODO_MLD_SVG = $(patsubst $(MOCODO_SRC_DIR)/%.mld,$(MOCODO_DEST_DIR)/%.mld.svg,$(MOCODO_MLD_FILES))
MOCODO_MLD_PDF = $(patsubst $(MOCODO_SRC_DIR)/%.mld,$(MOCODO_DEST_DIR)/%.mld.pdf,$(MOCODO_MLD_FILES))

##
## Prerequisistes (system packages)
##
MOCODO_APT_PACKAGES = ghostscript librsvg2-bin

##
## Rules
##
$(MOCODO_DEST_DIR)/%.mcd.mld: $(MOCODO_SRC_DIR)/%.mcd
	tmp=$$(mktemp -d) \
	&& pipenv run mocodo \
	    $(MOCODO_OPT) \
		--mld --no_mcd \
		--relations diagram \
		--input $< \
		--output $${tmp} \
	&& mv $${tmp}/*.mld $@ \
	&& rm -fr $${tmp} \
	&& touch --reference $< $@

$(MOCODO_DEST_DIR)/%.mcd.svg: $(MOCODO_SRC_DIR)/%.mcd
	tmp=$$(mktemp -d) \
	&& pipenv run mocodo \
	    $(MOCODO_OPT) \
		--mld --no_mcd \
		--relations diagram \
		--input $< \
		--output $${tmp} \
	&& mv $${tmp}/*.svg $@ \
	&& rm -fr $${tmp} \
	&& touch --reference $< $@

$(MOCODO_DEST_DIR)/%.mld.svg: $(MOCODO_SRC_DIR)/%.mld
	tmp=$$(mktemp -d) \
	&& pipenv run mocodo \
	    $(MOCODO_OPT) \
		--input $< \
		--output $${tmp} \
	&& mv $${tmp}/*.svg $@ \
	&& rm -fr $${tmp} \
	&& touch --reference $< $@

$(MOCODO_DEST_DIR)/%.mld.pdf: $(MOCODO_SRC_DIR)/%.mld.svg
	# rsvg-convert -f pdf $< > $@
	rsvg-convert -f ps $< | gs -sDEVICE=pdfwrite -sOutputFile=$@ -f -

$(MOCODO_DEST_DIR)/%.mcd.pdf: $(MOCODO_SRC_DIR)/%.mcd.svg
	# rsvg-convert -f pdf $< > $@
	rsvg-convert -f ps $< | gs -sDEVICE=pdfwrite -sOutputFile=$@ -f -

.PHONY: mocodo-mcd-mld
mocodo-mcd-mld: $(MOCODO_MCD_MLD)

.PHONY: mocodo-mcd-svg
mocodo-mcd-svg: $(MOCODO_MCD_SVG)

.PHONY: mocodo-mld-pdf
mocodo-mcd-pdf: $(MOCODO_MCD_PDF)

.PHONY: mocodo-mld-svg
mocodo-mld-svg: $(MOCODO_MLD_SVG)

.PHONY: mocodo-mld-pdf
mocodo-mld-pdf: $(MOCODO_MLD_PDF)

.PHONY: mocodo-svg
mocodo-svg: mocodo-mcd-svg mocodo-mld-svg

.PHONY: mocodo-pdf
mocodo-pdf: mocodo-mcd-pdf mocodo-mld-pdf

.PHONY: mocodo-clean-mld
mocodo-clean-mld: 
	rm -f $(MOCODO_MCD_MLD)

.PHONY: mocodo-clean-svg
mocodo-clean-svg: 
	rm -f $(MOCODO_MCD_SVG) $(MOCODO_MLD_SVG)

.PHONY: mocodo-clean-pdf
mocodo-clean-pdf: 
	rm -f $(MOCODO_MCD_PDF) $(MOCODO_MLD_PDF)

.PHONY: mocodo-clean
mocodo-clean: mocodo-clean-mld mocodo-clean-svg mocodo-clean-pdf

.PHONY: mocodo-info
mocodo-info:
	@echo "MOCODO:"
	@echo "  External variables:"
	@echo "    MOCODO_OPT: $(MOCODO_OPT)"
	@echo "    MOCODO_SRC_DIR: $(MOCODO_SRC_DIR)"
	@echo "    MOCODO_DEST_DIR: $(MOCODO_DEST_DIR)"
	@echo "  Internal variables"
	@echo "    MOCODO_MCD_FILES: $(MOCODO_MCD_FILES)"
	@echo "    MOCODO_MLD_FILES: $(MOCODO_MLD_FILES)"
	@echo "    MOCODO_MCD_MLD: $(MOCODO_MCD_MLD)"
	@echo "    MOCODO_MCD_SVG: $(MOCODO_MCD_SVG)"
	@echo "    MOCODO_MCD_PDF: $(MOCODO_MCD_PDF)"
	@echo "    MOCODO_MLD_FILES: $(MOCODO_MLD_FILES)"
	@echo "    MOCODO_MLD_SVG:  $(MOCODO_MLD_SVG)" 
	@echo "    MOCODO_MLD_PDF:  $(MOCODO_MLD_PDF)"

