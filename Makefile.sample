# Usage example

##
## Local configuration
##

##
## Configuration of input variables for libraries
##
PLANTUML_SRC_DIR = $(SOURCE_DIR)/plantuml
PLANTUML_DEST_DIR = $(IMAGES_DIR)/plantuml

MOCODO_SRC_DIR = $(SOURCE_DIR)/mocodo
MOCODO_DEST_DIR = $(IMAGES_DIR)/mocodo

GRAPHVIZ_SRC_DIR = $(SOURCE_DIR)/graphviz
GRAPHVIZ_DEST_DIR = $(IMAGES_DIR)/graphviz

##
## Include libraries
##
include mocodo.mk
include dot.mk
include plantuml.mk

##
## Rules
##

.PHONY: build
build: plantuml-build mocodo-build graphviz-build

.PHONY: clean
clean: plantuml-clean mocodo-clean graphviz-clean

