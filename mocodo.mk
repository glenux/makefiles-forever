
## API
MOCODO_DIRECTORIES=?.

MOCODO_OPT=--colors brewer-6 --shapes verdana

## INTERNALS
MOCODO_MCD_FILES=$(shell find $(IMAGES_DIR) \( -name '*.mcd' ! -name '_*' \))
MOCODO_MCD_MLD=$(patsubst $(IMAGES_DIR)/%.mcd,$(BUILD_IMAGES_DIR)/%.mcd.mld,$(MOCODO_MCD_FILES))
MOCODO_MCD_SVG=$(patsubst $(IMAGES_DIR)/%.mcd,$(BUILD_IMAGES_DIR)/%.mcd.svg,$(MOCODO_MCD_FILES))
MOCODO_MCD_PDF=$(patsubst $(IMAGES_DIR)/%.mcd,$(BUILD_IMAGES_DIR)/%.mcd.pdf,$(MOCODO_MCD_FILES))

MOCODO_MLD_FILES=$(shell find $(IMAGES_DIR) \( -name '*.mld' ! -name '_*' \)) $(MOCODO_MCD_MLD)
MOCODO_MLD_SVG=$(patsubst $(IMAGES_DIR)/%.mld,$(BUILD_IMAGES_DIR)/%.mld.svg,$(MOCODO_MLD_FILES))
MOCODO_MLD_PDF=$(patsubst $(IMAGES_DIR)/%.mld,$(BUILD_IMAGES_DIR)/%.mld.pdf,$(MOCODO_MLD_FILES))

%.mcd.mld: %.mcd
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

%.mcd.svg: %.mcd
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

%.mld.svg: %.mld
	tmp=$$(mktemp -d) \
	&& pipenv run mocodo \
	    $(MOCODO_OPT) \
		--input $< \
		--output $${tmp} \
	&& mv $${tmp}/*.svg $@ \
	&& rm -fr $${tmp} \
	&& touch --reference $< $@

%.mld.pdf: %.mld.svg
	inkscape \
        --export-type=pdf \
        --export-overwrite \
        --export-filename $@ \
        $<

%.mcd.pdf: %.mcd.svg
	inkscape \
        --export-type=pdf \
        --export-overwrite \
        --export-filename $@ \
        $<

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

