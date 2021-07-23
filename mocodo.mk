##
## MOCODO MODULE
##

##
## External variables (API)
##
MOCODO_OPT=--colors brewer-6 --shapes verdana
MOCODO_SRC_DIR=
MOCODO_DEST_DIR=

##
## Internal variables
##
MOCODO_MCD_FILES=$(shell find $(MOCODO_SRC_DIR) \( -name '*.mcd' ! -name '_*' \))
MOCODO_MCD_MLD=$(patsubst $(MOCODO_SRC_DIR)/%.mcd,$(MOCODO_DEST_DIR)/%.mcd.mld,$(MOCODO_MCD_FILES))
MOCODO_MCD_SVG=$(patsubst $(MOCODO_SRC_DIR)/%.mcd,$(MOCODO_DEST_DIR)/%.mcd.svg,$(MOCODO_MCD_FILES))
MOCODO_MCD_PDF=$(patsubst $(MOCODO_SRC_DIR)/%.mcd,$(MOCODO_DEST_DIR)/%.mcd.pdf,$(MOCODO_MCD_FILES))

MOCODO_MLD_FILES=$(shell find $(MOCODO_SRC_DIR) \( -name '*.mld' ! -name '_*' \)) $(MOCODO_MCD_MLD)
MOCODO_MLD_SVG=$(patsubst $(MOCODO_SRC_DIR)/%.mld,$(MOCODO_DEST_DIR)/%.mld.svg,$(MOCODO_MLD_FILES))
MOCODO_MLD_PDF=$(patsubst $(MOCODO_SRC_DIR)/%.mld,$(MOCODO_DEST_DIR)/%.mld.pdf,$(MOCODO_MLD_FILES))

##
## Prerequisistes (system packages)
##
MOCODO_APT_PACKAGES=ghostscript librsvg2-bin

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

mocodo-mcd-mld: $(MOCODO_MCD_MLD)

mocodo-mcd-svg: $(MOCODO_MCD_SVG)
mocodo-mld-svg: $(MOCODO_MLD_SVG)

mocodo-mcd-pdf: $(MOCODO_MCD_PDF)
mocodo-mld-pdf: $(MOCODO_MLD_PDF)

mocodo-svg: mocodo-mcd-svg mocodo-mld-svg

mocodo-pdf: mocodo-mcd-pdf mocodo-mld-pdf

mocodo-clean-mld: 
	rm -f $(MOCODO_MCD_MLD)

mocodo-clean-svg: 
	rm -f $(MOCODO_MCD_SVG) $(MOCODO_MLD_SVG)

mocodo-clean-pdf: 
	rm -f $(MOCODO_MCD_PDF) $(MOCODO_MLD_PDF)

mocodo-clean: mocodo-clean-mld mocodo-clean-svg mocodo-clean-pdf

