##
## PLANTUML MODULE
##

##
## External variables (API)
##
PLANTUML_SRC_DIR=
PLANTUML_DEST_DIR=

##
## Internal variables
##

## Find .uml graphs
PLANTUML_UML=$(shell find $(PLANTUML_SRC_DIR) \( -name '*.uml' ! -name '_*' \))
PLANTUML_UML_SVG=$(patsubst $(PLANTUML_SRC_DIR)/%.uml,$(PLANTUML_DEST_DIR)/%.uml.svg,$(PLANTUML_UML))


##
## Rules
##
$(PLANTUML_DEST_DIR)/%.uml.svg: $(PLANTUML_SRC_DIR)/%.uml
        plantuml -pipe -tsvg < $< > $@


plantuml-uml-svg:

plantuml-svg:

plantuml-clean-svg:

plantuml-clean:

