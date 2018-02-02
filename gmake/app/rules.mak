# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2017-2018
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

dbg-shared:	$(EXTRA_PRE_DBG) ${ALLPRGS_DBG} $(EXTRA_POST_DBG)

dbg-static:	$(EXTRA_PRE_DBG) ${ALLPRGS_DBG} $(EXTRA_POST_DBG)

release-shared:	$(EXTRA_PRE) ${ALLPRGS} $(EXTRA_POST)

release-static:	$(EXTRA_PRE) ${ALLPRGS} $(EXTRA_POST)

ifndef WITHOUT_STLPORT
stldbg-shared:	$(EXTRA_PRE_STLDBG) ${ALLPRGS_STLDBG} $(EXTRA_POST_STLDBG)

stldbg-static:	$(EXTRA_PRE_STLDBG) ${ALLPRGS_STLDBG} $(EXTRA_POST_STLDBG)
endif

ifeq ("$(findstring $(COMPILER_NAME),bcc dmc)","")
define cpplnk_str
$(LINK.cc) $(LINK_OUTPUT_OPTION) $(2) $(1) $(4) ${STDLIBS} $(3)
endef
else
ifeq ($(OSNAME),windows)
define cpplnk_str
$(LINK.cc) $(subst /,\\,$(2) $(1) $(3), $(LINK_OUTPUT_OPTION), $(MAP_OUTPUT_OPTION), $(4) ${STDLIBS},,)
endef
else
define cpplnk_str
$(LINK.cc) $(2) $(1) $(3), $(LINK_OUTPUT_OPTION), $(MAP_OUTPUT_OPTION), $(4) ${STDLIBS},,
endef
endif
endif

define clnk_str
$(LINK.c) $(LINK_OUTPUT_OPTION) $(2) $(1) $(4) ${STDLIBS} $(3)
endef

define prog_lnk
OUTPUT_DIRS += $${OUTPUT_DIR} $${OUTPUT_DIR_DBG}
ifndef WITHOUT_STLPORT
OUTPUT_DIRS += $${OUTPUT_DIR_STLDBG}
endif

ifeq ($${_$(1)_C_SOURCES_ONLY},)
$${$(1)_PRG}:	$$($(1)_OBJ) $$($(1)_START_OBJ) $$($(1)_END_OBJ) $$($(1)_LIBSDEP) | $${OUTPUT_DIR}
	$$(call cpplnk_str,$$($(1)_OBJ),$$($(1)_START_OBJ),$$($(1)_END_OBJ),$$($(1)_LDLIBS))

$${$(1)_PRG_DBG}:	$$($(1)_OBJ_DBG) $$($(1)_START_OBJ_DBG) $$($(1)_END_OBJ_DBG) $$($(1)_LIBSDEP_DBG) | $${OUTPUT_DIR_DBG}
	$$(call cpplnk_str,$$($(1)_OBJ_DBG),$$($(1)_START_OBJ_DBG),$$($(1)_END_OBJ_DBG),$$($(1)_LDLIBS_DBG))

ifndef WITHOUT_STLPORT
$${$(1)_PRG_STLDBG}:	$$($(1)_OBJ_STLDBG) $$($(1)_START_OBJ_DBG) $$($(1)_END_OBJ_DBG) $$($(1)_LIBSDEP_STLDBG) | $${OUTPUT_DIR_STLDBG}
	$$(call cpplnk_str,$$($(1)_OBJ_STLDBG),$$($(1)_START_OBJ_STLDBG),$$($(1)_END_OBJ_STLDBG),$$($(1)_LDLIBS_STLDBG))
endif
else
$${$(1)_PRG}:	$$($(1)_OBJ) $$($(1)_START_OBJ) $$($(1)_END_OBJ) $$($(1)_LIBSDEP) | $${OUTPUT_DIR}
	$$(call clnk_str,$$($(1)_OBJ),$$($(1)_START_OBJ),$$($(1)_END_OBJ),$$($(1)_LDLIBS))

$${$(1)_PRG_DBG}:	$$(OBJ_DBG) $$($(1)_START_OBJ_DBG) $$($(1)_END_OBJ_DBG) $$($(1)_LIBSDEP_DBG) | $${OUTPUT_DIR_DBG}
	$$(call clnk_str,$$($(1)_OBJ_DBG),$$($(1)_START_OBJ_DBG),$$($(1)_END_OBJ_DBG),$$($(1)_LDLIBS_DBG))

ifndef WITHOUT_STLPORT
$${$(1)_PRG_STLDBG}:	$$($(1)_OBJ_STLDBG) $$($(1)_START_OBJ_STLDBG) $$($(1)_END_OBJ_STLDBG) $$($(1)_LIBSDEP_STLDBG) | $${OUTPUT_DIR_STLDBG}
	$$(call clnk_str,$$($(1)_OBJ_STLDBG),$$($(1)_START_OBJ_STLDBG),$$($(1)_END_OBJ_STLDBG),$$($(1)_LDLIBS_STLDBG))
endif
endif
endef

$(foreach prg,$(PRGNAMES),$(eval $(call prog_lnk,$(prg))))

OUTPUT_DIRS += ${OUTPUT_DIR} ${OUTPUT_DIR_DBG}
ifndef WITHOUT_STLPORT
OUTPUT_DIRS += ${OUTPUT_DIR} ${OUTPUT_DIR_DBG}
endif

ifeq ("${_C_SOURCES_ONLY}","")
${PRG}:	$(OBJ) $(START_OBJ) $(END_OBJ) $(LIBSDEP) | ${OUTPUT_DIR}
	$(call cpplnk_str,$(OBJ),$(START_OBJ),$(END_OBJ),$(LDLIBS))

${PRG_DBG}:	$(OBJ_DBG) $(START_OBJ_DBG) $(END_OBJ_DBG) $(LIBSDEP_DBG) | ${OUTPUT_DIR_DBG}
	$(call cpplnk_str,$(OBJ_DBG),$(START_OBJ_DBG),$(END_OBJ_DBG),$(LDLIBS_DBG))

ifndef WITHOUT_STLPORT
${PRG_STLDBG}:	$(OBJ_STLDBG) $(START_OBJ_STLDBG) $(END_OBJ_STLDBG) $(LIBSDEP_STLDBG) | ${OUTPUT_DIR_STLDBG}
	$(call cpplnk_str,$(OBJ_STLDBG),$(START_OBJ_STLDBG),$(END_OBJ_STLDBG),$(LDLIBS_STLDBG))
endif
else
${PRG}:	$(OBJ) $(START_OBJ) $(END_OBJ) $(LIBSDEP) | ${OUTPUT_DIR}
	$(call clnk_str,$(OBJ),$(START_OBJ),$(END_OBJ),$(LDLIBS))

${PRG_DBG}:	$(OBJ_DBG) $(START_OBJ_DBG) $(END_OBJ_DBG) $(LIBSDEP_DBG) | ${OUTPUT_DIR_DBG}
	$(call clnk_str,$(OBJ_DBG),$(START_OBJ_DBG),$(END_OBJ_DBG),$(LDLIBS_DBG))

ifndef WITHOUT_STLPORT
${PRG_STLDBG}:	$(OBJ_STLDBG) $(START_OBJ_STLDBG) $(END_OBJ_STLDBG) $(LIBSDEP_STLDBG) | ${OUTPUT_DIR_STLDBG}
	$(call clnk_str,$(OBJ_STLDBG),$(START_OBJ_STLDBG),$(END_OBJ_STLDBG),$(LDLIBS_STLDBG))
endif
endif
