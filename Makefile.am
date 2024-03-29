###############################################################################
## Makefile for Faroese--Norwegian
###############################################################################

LANG1=fao
LANG2=nor
LANG2n=nno
LANG2b=nob
PREFIX1=$(LANG1)-$(LANG2)
PREFIX1n=$(LANG1)-$(LANG2n)
PREFIX1b=$(LANG1)-$(LANG2b)
PREFIX2=$(LANG2)-$(LANG1)
PREFIX2n=$(LANG2n)-$(LANG1)
PREFIX2b=$(LANG2b)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON =		\
	$(PREFIX1b).automorf.hfst \
	$(PREFIX1b).automorf-untrimmed.hfst \
	$(PREFIX1n).automorf.hfst \
	$(PREFIX1n).automorf-untrimmed.hfst \
	$(PREFIX1).rlx.bin	\
	$(PREFIX1b).autobil.bin	\
	$(PREFIX1b).autolex.bin	\
	$(PREFIX1b).autogen.bin	\
	$(PREFIX1n).autobil.bin	\
	$(PREFIX1n).autolex.bin	\
	$(PREFIX1n).autogen.bin	\
	$(PREFIX1b).t1x.bin	\
	$(PREFIX1b).t2x.bin	\
	$(PREFIX1b).t3x.bin	\
	$(PREFIX1n).t1x.bin	\
	$(PREFIX1n).t2x.bin	\
	$(PREFIX1n).t3x.bin	\
	$(PREFIX2b).automorf.bin	\
	$(PREFIX2n).automorf.bin	\
	$(PREFIX2b).automorf-untrimmed.bin	\
	$(PREFIX2n).automorf-untrimmed.bin	\
	$(PREFIX2b).prob		\
	$(PREFIX2b).rlx.bin	\
	$(PREFIX2b).autobil.bin	\
	$(PREFIX2b).autolex.bin	\
	$(PREFIX2).autogen.hfst	 \
	$(PREFIX2b).t1x.bin	\
	$(PREFIX2b).t2x.bin	\
	$(PREFIX2b).t3x.bin

# $(PREFIX1).prob

# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################
## Monolingual transducers
###############################################################################

# -------------------
# Faroese analysis:
# -------------------

.deps/$(LANG1).automorf.hfst: $(AP_SRC1)/apertium-und.$(LANG1)-und.LR.att.gz .deps/.d
	$(ZCAT) $< | hfst-txt2fst > $@

.deps/$(PREFIX1b).automorf-trimmed.hfst: .deps/$(LANG1).automorf.hfst .deps/$(PREFIX1b).autobil.prefixes
	hfst-compose-intersect -1 $< -2 .deps/$(PREFIX1b).autobil.prefixes -o $@

.deps/$(PREFIX1n).automorf-trimmed.hfst: .deps/$(LANG1).automorf.hfst .deps/$(PREFIX1n).autobil.prefixes
	hfst-compose-intersect -1 $< -2 .deps/$(PREFIX1n).autobil.prefixes -o $@

$(PREFIX1b).automorf.hfst: .deps/$(PREFIX1b).automorf-trimmed.hfst
	hfst-fst2fst -w -i $< -o $@

$(PREFIX1n).automorf.hfst: .deps/$(PREFIX1n).automorf-trimmed.hfst
	hfst-fst2fst -w -i $< -o $@

.deps/$(PREFIX1).automorf-untrimmed.hfst: .deps/$(LANG1).automorf.hfst
	hfst-fst2fst -w -i $< -o $@

$(PREFIX1b).automorf-untrimmed.hfst: .deps/$(PREFIX1).automorf-untrimmed.hfst
	cp $< $@

$(PREFIX1n).automorf-untrimmed.hfst: .deps/$(PREFIX1).automorf-untrimmed.hfst
	cp $< $@



# -------------------
# Faroese generation:
# ---------------------

.deps/$(LANG1).autogen.hfst: $(AP_SRC1)/apertium-$(LANG1).$(LANG1).RL.att.gz .deps/.d
	$(ZCAT) $< | hfst-txt2fst > $@

$(PREFIX2).autogen.hfst: .deps/$(LANG1).autogen.hfst
	hfst-fst2fst -O -i $< -o $@

# -------------------
# Norwegian analysis:
# -------------------

$(PREFIX2n).automorf.bin: $(AP_SRC2n)/$(LANG2n).automorf.bin $(PREFIX2n).autobil.bin
	lt-trim $^ $@

$(PREFIX2b).automorf.bin: $(AP_SRC2b)/$(LANG2b).automorf.bin $(PREFIX2b).autobil.bin
	lt-trim $^ $@

$(PREFIX2n).automorf-untrimmed.bin: $(AP_SRC2n)/$(LANG2n).automorf.bin
	cp $^ $@

$(PREFIX2b).automorf-untrimmed.bin: $(AP_SRC2b)/$(LANG2b).automorf.bin
	cp $^ $@

# -------------------
# Norwegian generation:
# ---------------------

$(PREFIX1b).autogen.bin: $(AP_SRC2b)/$(LANG2b).autogen.bin
	cp $< $@

$(PREFIX1n).autogen.bin: $(AP_SRC2n)/$(LANG2n).autogen.bin
	cp $< $@


###############################################################################
## Tagger models
###############################################################################

$(PREFIX1).prob: $(AP_SRC1)/$(LANG1).prob
	cp $< $@

$(PREFIX2n).prob: $(AP_SRC2n)/$(LANG2n).prob
	cp $< $@

$(PREFIX2b).prob: $(AP_SRC2b)/$(LANG2b).prob
	cp $< $@

###############################################################################
## Disambiguation rules
###############################################################################

$(PREFIX1).rlx.bin: $(AP_SRC1)/$(LANG1).mor.rlx.bin
	cp $< $@

$(PREFIX2n).rlx.bin: $(AP_SRC2n)/apertium-$(LANG2n).$(LANG2n).rlx
	cg-comp $< $@

$(PREFIX2b).rlx.bin: $(AP_SRC2b)/apertium-$(LANG2b).$(LANG2b).rlx
	cg-comp $< $@

###############################################################################
## Bilingual dictionaries
###############################################################################

$(PREFIX1b).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp --var-right=nob lr $< $@

$(PREFIX1n).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp --var-right=nno lr $< $@

$(PREFIX2n).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl $< $@

$(PREFIX2b).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl $< $@

###############################################################################
## Lexical selection rules
###############################################################################

$(PREFIX1n).autolex.bin: $(BASENAME).$(PREFIX1n).lrx
	apertium-validate-lrx $<
	lrx-comp $< $@

$(PREFIX1b).autolex.bin: $(BASENAME).$(PREFIX1b).lrx
	apertium-validate-lrx $<
	lrx-comp $< $@

$(PREFIX2n).autolex.bin: $(BASENAME).$(PREFIX2n).lrx
	apertium-validate-lrx $<
	lrx-comp $< $@

$(PREFIX2b).autolex.bin: $(BASENAME).$(PREFIX2b).lrx
	apertium-validate-lrx $<
	lrx-comp $< $@

###############################################################################
## Structural transfer rules
###############################################################################

$(PREFIX1n).t1x.bin: $(BASENAME).$(PREFIX1n).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1n).t2x.bin: $(BASENAME).$(PREFIX1n).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX1n).t3x.bin: $(BASENAME).$(PREFIX1n).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2n).t1x.bin: $(BASENAME).$(PREFIX2n).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX2n).t2x.bin: $(BASENAME).$(PREFIX2n).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2n).t3x.bin: $(BASENAME).$(PREFIX2n).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


$(PREFIX1b).t1x.bin: $(BASENAME).$(PREFIX1b).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1b).t2x.bin: $(BASENAME).$(PREFIX1b).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX1b).t3x.bin: $(BASENAME).$(PREFIX1b).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


$(PREFIX2b).t1x.bin: $(BASENAME).$(PREFIX2b).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX2b).t2x.bin: $(BASENAME).$(PREFIX2b).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2b).t3x.bin: $(BASENAME).$(PREFIX2b).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@

###############################################################################
## Postgeneration dictionaries
###############################################################################

$(PREFIX1).autopgen.bin: $(AP_SRC2)/$(LANG2).autopgen.bin
	cp $< $@

$(PREFIX2).autopgen.bin: $(AP_SRC1)/$(LANG1).autopgen.bin
	cp $< $@

###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=					\
		$(BASENAME).$(PREFIX1).lrx	\
		$(BASENAME).$(PREFIX1).dix	\
		$(BASENAME).$(PREFIX2).lrx	\
		$(BASENAME).$(PREFIX1b).t1x	\
		$(BASENAME).$(PREFIX1b).t2x	\
		$(BASENAME).$(PREFIX1b).t3x	\
		$(BASENAME).$(PREFIX2).t1x	\
		$(BASENAME).$(PREFIX2).t2x	\
		$(BASENAME).$(PREFIX2).t3x	\
		modes.xml

###############################################################################
## Installation
###############################################################################

apertium_fao_nordir=$(prefix)/share/apertium/$(BASENAME)/

# Files which should be installed to $(prefix)/share/apertium/$(BASENAME)/:
apertium_fao_nor_DATA=	\
	$(TARGETS_COMMON)				\
	$(BASENAME).$(PREFIX1b).t1x			\
	$(BASENAME).$(PREFIX1b).t2x			\
	$(BASENAME).$(PREFIX1b).t3x			\
	$(BASENAME).$(PREFIX2b).t1x			\
	$(BASENAME).$(PREFIX2b).t2x			\
	$(BASENAME).$(PREFIX2b).t3x

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1n).mode

install-data-local: install-modes

###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	apertium-regtest test
