##
## PLANTUML MODULE
##

##
## External variables (API)
##
PLANTUML_SUFFIX ?= uml
PLANTUML_SRC_DIR ?=
PLANTUML_DEST_DIR ?=

##
## Internal variables (lazy recursive evaluation)
##

## Find .uml graphs
PLANTUML_UML = $(shell find $(PLANTUML_SRC_DIR) \( -name '*.uml' ! -name '_*' \))
PLANTUML_UML_PNG = $(patsubst $(PLANTUML_SRC_DIR)/%.uml,$(PLANTUML_DEST_DIR)/%.uml.png,$(PLANTUML_UML))
PLANTUML_UML_SVG = $(patsubst $(PLANTUML_SRC_DIR)/%.uml,$(PLANTUML_DEST_DIR)/%.uml.svg,$(PLANTUML_UML))
PLANTUML_UML_PDF = $(patsubst $(PLANTUML_SRC_DIR)/%.uml,$(PLANTUML_DEST_DIR)/%.uml.pdf,$(PLANTUML_UML))


##
## Rules
##

$(PLANTUML_DEST_DIR):
	mkdir -p $(PLANTUML_DEST_DIR)

$(PLANTUML_DEST_DIR)/%.uml.png: $(PLANTUML_SRC_DIR)/%.uml | $(PLANTUML_DEST_DIR)
	podman run -i plantuml/plantuml plantuml -pipe -tpng < $< > $@

$(PLANTUML_DEST_DIR)/%.uml.svg: $(PLANTUML_SRC_DIR)/%.uml | $(PLANTUML_DEST_DIR)
	podman run -i plantuml/plantuml plantuml -pipe -tsvg < $< > $@

$(PLANTUML_DEST_DIR)/%.uml.pdf: $(PLANTUML_SRC_DIR)/%.uml.svg | $(PLANTUML_DEST_DIR)
	#podman run -i plantuml/plantuml plantuml -pipe -tpdf < $< > $@
	rsvg-convert -f pdf -o $@ $<

.PHONY: plantuml-uml-svg
plantuml-uml-svg: $(PLANTUML_UML_SVG)

.PHONY: plantuml-uml-png
plantuml-uml-png: $(PLANTUML_UML_PNG)

.PHONY: plantuml-uml-pdf
plantuml-uml-pdf: $(PLANTUML_UML_PDF)

.PHONY: plantuml-svg
plantuml-svg: plantuml-uml-svg

.PHONY: plantuml-png
plantuml-png: plantuml-uml-png

.PHONY: plantuml-pdf
plantuml-pdf: plantuml-uml-pdf

.PHONY: plantuml-clean-svg
plantuml-clean-svg:
	rm -f $(PLANTUML_UML_SVG)

.PHONY: plantuml-clean-png
plantuml-clean-png:
	rm -f $(PLANTUML_UML_PNG)

.PHONY: plantuml-clean-pdf
plantuml-clean-pdf:
	rm -f $(PLANTUML_UML_PDF)

.PHONY: plantuml-clean
plantuml-clean: plantuml-clean-pdf plantuml-clean-svg

.PHONY: plantuml-info
plantuml-info:
	@echo "PLANTUML_DEST_DIR: $(PLANTUML_DEST_DIR)"
	@echo "PLANTUML_SRC_DIR: $(PLANTUML_SRC_DIR)"
	@echo "--"
	@echo "PLANTUML_UML: $(PLANTUML_UML)"
	@echo "PLANTUML_UML_PDF: $(PLANTUML_UML_PDF)"
	@echo "PLANTUML_UML_SVG: $(PLANTUML_UML_SVG)"

.SUFFIXES:
