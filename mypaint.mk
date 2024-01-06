# SPDX-License-Identifier: LGPL-3.0-or-later
#
# SPDX-FileCopyrightText: 2023 Glenn Y. Rolland <glenux@glenux.net>
# Copyright © 2023 Glenn Y. Rolland <glenux@glenux.net>

##
## MYPAINT MODULE
##

##
## External variables (API)
##
MYPAINT_SUFFIX ?= ora
MYPAINT_SRC_DIR ?=
MYPAINT_DEST_DIR ?=
MYPAINT_PDF_DENSITY ?= 75
MYPAINT_JPG_QUALITY ?= 100

##
## Internal variables (lazy recursive evaluation)
##

## Find .ora files
MYPAINT_ORA = $(shell find $(MYPAINT_SRC_DIR) \( -name '*.ora' ! -name '_*' \))
MYPAINT_ORA_PNG = $(patsubst $(MYPAINT_SRC_DIR)/%.ora,$(MYPAINT_DEST_DIR)/%.ora.png,$(MYPAINT_ORA))
MYPAINT_ORA_JPG = $(patsubst $(MYPAINT_SRC_DIR)/%.ora,$(MYPAINT_DEST_DIR)/%.ora.jpg,$(MYPAINT_ORA))
MYPAINT_ORA_PDF = $(patsubst $(MYPAINT_SRC_DIR)/%.ora,$(MYPAINT_DEST_DIR)/%.ora.pdf,$(MYPAINT_ORA))

##
## Prerequisistes (system packages)
##
MYPAINT_APT_PACKAGES := unzip mypaint imagemagick

##
## Rules
##

$(MYPAINT_DEST_DIR):
	mkdir -p $(MYPAINT_DEST_DIR)

$(MYPAINT_DEST_DIR)/%.ora.png: $(MYPAINT_SRC_DIR)/%.ora | $(MYPAINT_DEST_DIR)
	TMPDIR="$$(mktemp -d)" \
		&& unzip -q $< -d "$$TMPDIR" mergedimage.png \
		&& touch "$$TMPDIR/mergedimage.png" \
		&& mv "$$TMPDIR/mergedimage.png" $@

$(MYPAINT_DEST_DIR)/%.ora.jpg: $(MYPAINT_DEST_DIR)/%.ora.png | $(MYPAINT_DEST_DIR)
	convert -quality $(MYPAINT_JPG_QUALITY) $< $@

$(MYPAINT_DEST_DIR)/%.ora.pdf: $(MYPAINT_DEST_DIR)/%.ora.png | $(MYPAINT_DEST_DIR)
	convert -density $(MYPAINT_PDF_DENSITY) $< $@

.PHONY: mypaint-ora-jpg
mypaint-ora-jpg: $(MYPAINT_ORA_JPG)

.PHONY: mypaint-ora-png
mypaint-ora-png: $(MYPAINT_ORA_PNG)

.PHONY: mypaint-ora-pdf
mypaint-ora-pdf: $(MYPAINT_ORA_PDF)

.PHONY: mypaint-jpg
mypaint-jpg: mypaint-ora-jpg

.PHONY: mypaint-png
mypaint-png: mypaint-ora-png

.PHONY: mypaint-pdf
mypaint-pdf: mypaint-ora-pdf

.PHONY: mypaint-clean-jpg
mypaint-clean-jpg:
	rm -f $(MYPAINT_ORA_JPG)

.PHONY: mypaint-clean-png
mypaint-clean-png:
	rm -f $(MYPAINT_ORA_PNG)

.PHONY: mypaint-clean-pdf
mypaint-clean-pdf:
	rm -f $(MYPAINT_ORA_PDF)

.PHONY: mypaint-clean
mypaint-clean: mypaint-clean-pdf mypaint-clean-jpg

.PHONY: mypaint-info
mypaint-info:
	@echo "MYPAINT:"
	@echo "  External variables:"
	@echo "    MYPAINT_SUFFIX: $(MYPAINT_SUFFIX)"
	@echo "    MYPAINT_SRC_DIR: $(MYPAINT_SRC_DIR)"
	@echo "    MYPAINT_DEST_DIR: $(MYPAINT_DEST_DIR)"
	@echo "    MYPAINT_PDF_DENSITY: $(MYPAINT_PDF_DENSITY)"
	@echo "    MYPAINT_JPG_QUALITY: $(MYPAINT_JPG_QUALITY)"
	@echo "  Internal variables"
	@echo "    MYPAINT_ORA: $(MYPAINT_ORA)"
	@echo "    MYPAINT_ORA_PNG: $(MYPAINT_ORA_PDF)"
	@echo "    MYPAINT_ORA_PDF: $(MYPAINT_ORA_PDF)"
	@echo "    MYPAINT_ORA_JPG: $(MYPAINT_ORA_JPG)"

