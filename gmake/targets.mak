# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002-2014
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#


# generator of rules like
#
# obj/gcc/so/test.o:	test.cc | obj/gcc/so
# 	$(COMPILE.cc) $(OUTPUT_OPTION) $<
#
# For source not from current dir (i.e. src/test.cc) generated rule will be like
#
# obj/gcc/so/ebc28af801846844e4024f299405a1c4/test.o:	src/test.cc | obj/gcc/so/ebc28af801846844e4024f299405a1c4
# 	$(COMPILE.cc) $(OUTPUT_OPTION) $<
# 
# The hash string is MD5 hash from "src/" (directory of source file)
# The usage is like:
#
# $(call derive_rule,$(OUTPUT_DIR),test.cc,.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<)
#

define derive_rule
OUTPUT_DIRS += $(1)
$(5) += $(1)$(basename $(notdir $(2)))$(3)

$(1)$(basename $(notdir $(2)))$(3):	$(2) | $(1); $(4)
endef

# C++

$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))

$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))

ifndef WITHOUT_STLPORT
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_STLDBG),$(OUTPUT_DIR_STLDBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_STLDBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_STLDBG),$(OUTPUT_DIR_STLDBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_STLDBG)))
endif

# C

$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))

$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))

# S

$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))

$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))

# spp

$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))

$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))

ifeq ($(OSNAME),windows)
# rc
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES)))
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES_DBG)))
ifndef WITHOUT_STLPORT
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_STLDBG),$(OUTPUT_DIR_STLDBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES_STLDBG)))
endif
endif

# If we have no C++ sources, let's use C compiler for linkage instead of C++.
ifeq ("$(sort ${SRC_CC} ${SRC_CPP} ${SRC_CXX})","")
NOT_USE_NOSTDLIB := 1
_C_SOURCES_ONLY := true
endif

# Rules defined in prog_ is similar to set above.
# Indeed it is enough only prog_ (call it with empty argument for
# common rules), but syntax is messy due to escape for dollars

define prog_
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))

$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))

ifndef WITHOUT_STLPORT
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_STLDBG),$$(OUTPUT_DIR_STLDBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_STLDBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_STLDBG),$$(OUTPUT_DIR_STLDBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_STLDBG)))
endif

# C

$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.c) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.c) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))

$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.c) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.c) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))

# S

$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.S) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.S) $$$$(SDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))

$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.S) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.S) $$$$(SDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))

# spp

$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.spp) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.spp) $$$$(SPPDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))

$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.o,$$$$(COMPILE.spp) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.d,@$$$$(COMPILE.spp) $$$$(SPPDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))

ifeq ($(OSNAME),windows)
# rc
$$(foreach f,$$($(1)SRC_RC),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.res,$$$$(COMPILE.rc) $$$$(RC_OUTPUT_OPTION) $$$$<,$(1)RES)))
$$(foreach f,$$($(1)SRC_RC),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.res,$$$$(COMPILE.rc) $$$$(RC_OUTPUT_OPTION) $$$$<,$(1)RES_DBG)))
ifndef WITHOUT_STLPORT
$$(foreach f,$$($(1)SRC_RC),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_STLDBG),$$(OUTPUT_DIR_STLDBG)/)$$(if $$(patsubst ./%,%,$$(dir $$(f))),$$(shell echo $$(dir $$(f)) | md5sum | cut -f1 -d' ')/),$$(f),.res,$$$$(COMPILE.rc) $$$$(RC_OUTPUT_OPTION) $$$$<,$(1)RES_STLDBG)))
endif
endif

ifeq ("$$(sort $${$(1)SRC_CC} $${$(1)SRC_CPP} $${$(1)SRC_CXX})","")
$(1)NOT_USE_NOSTDLIB := 1
_$(1)C_SOURCES_ONLY := true
endif
endef

# $(eval $(call prog_,))
$(foreach prg,$(PRGNAMES),$(eval $(call prog_,$(prg)_)))

define pdf_
${OUTPUT_DIR}/$(basename $(notdir $(firstword $($(1)_SRC_TEX)))).pdf:       $($(1)_SRC_TEX) $($(1)_MPS) $($(1)_EXTRA)
	[ -d ${OUTPUT_DIR} ] || mkdir ${OUTPUT_DIR}
	${COMPILE.latex} $$<
	grep -q "^LaTeX Warning: There were undefined references." `echo $$< | sed -e '1 s|^|${OUTPUT_DIR}/|' -e 's|\.tex$$$$|\.log|'` && biber --output_directory ${OUTPUT_DIR} `echo $$< | sed -e 's|\.tex$$$$|\.bcf|'` || true && ${COMPILE.latex} $$<
	grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." `echo $$< | sed -e '1 s|^|${OUTPUT_DIR}/|' -e 's|\.tex$$$$|\.log|'` && ${COMPILE.latex} $$< || true
	grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." `echo $$< | sed -e '1 s|^|${OUTPUT_DIR}/|' -e 's|\.tex$$$$|\.log|'` && ${COMPILE.latex} $$< || true
endef

$(foreach pdf,$(PDFNAMES),$(eval $(call pdf_,$(pdf))))

define pdfdep_
$(1)_ALLBASE := $$(basename $$(notdir $${$(1)_SRC_TEX} ) )
$(1)_ALLDEPS := $$(addsuffix .d,$${$(1)_ALLBASE})
$(1)_DEP     := $$(addprefix $$(OUTPUT_DIR)/,$${$(1)_ALLDEPS})
ALLBASE      += $${$(1)_ALLBASE}

${OUTPUT_DIR}/$(1).d:       $($(1)_SRC_TEX) $($(1)_MPS) $($(1)_EXTRA) | ${OUTPUT_DIR}
	${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$<
	grep -q "^LaTeX Warning: There were undefined references." `echo $$< | sed -e '1 s|^|${OUTPUT_DIR}/|' -e 's|\.tex$$$$|\.log|'` && biber --output_directory ${OUTPUT_DIR} `echo $$< | sed -e 's|\.tex$$$$|\.bcf|'` || true && ${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$<
	grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." `echo $$< | sed -e '1 s|^|${OUTPUT_DIR}/|' -e 's|\.tex$$$$|\.log|'` && ${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$< || true
	grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." `echo $$< | sed -e '1 s|^|${OUTPUT_DIR}/|' -e 's|\.tex$$$$|\.log|'` && ${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$< || true
	f=$(basename $(notdir $(firstword $($(1)_SRC_TEX)))).fls; if [ -e $$$$f ] ; then sort $$$$f ; rm -f $$$$f ; elif [ -e ${OUTPUT_DIR}/$$$$f ] ; then sort ${OUTPUT_DIR}/$$$$f ; else false; fi | uniq -u | sed -e '1 i $$< ${OUTPUT_DIR}/$(1).d:	  \\' -e '/^OUTPUT/ d' -e '/^PWD/ d' -e '/^INPUT.*\.aux$$$$/ d' -e '/^INPUT $$<$$$$/ d' -e '$$$$ s/^INPUT//' -e '$$$$! s/^INPUT//;s/$$$$/ \\/' | sed -e '$$$$ s/ \\$$$$//' > ${OUTPUT_DIR}/$(1).d
endef

$(foreach pdf,$(PDFNAMES),$(eval $(call pdfdep_,$(pdf))))
