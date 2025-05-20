BUILD=gh-pages
GIT_REF=$(shell git rev-parse --short HEAD)

.PHONY: all

all: $(BUILD)/resume.html $(BUILD)/resume.pdf

FONTS=$(patsubst %,$(BUILD)/%,$(wildcard dep/Font-Awesome/webfonts/*))
$(BUILD)/dep/Font-Awesome/css/all.css: $(FONTS)

$(BUILD)/resume.html: $(BUILD)/style.css $(BUILD)/dep/normalize.css/normalize.css $(BUILD)/dep/Font-Awesome/css/all.css

$(BUILD)/resume.pdf: $(BUILD)/resume.$(GIT_REF).pdf
	ln -nfs $(notdir $<) $@
$(BUILD)/resume.$(GIT_REF).pdf: $(BUILD)/resume.html
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless --disable-gpu --print-to-pdf file://$(abspath $<) && mv output.pdf $@

$(BUILD)/%: %
	@mkdir -p $(@D)
	cp $< $@
