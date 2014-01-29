# -*- Makefile -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

dbg-shared:	$(EXTRA_PRE_DBG) ${PRG_DBG} ${ALLPRGS_DBG} $(EXTRA_POST_DBG)

dbg-static:	$(EXTRA_PRE_DBG) ${PRG_DBG} ${ALLPRGS_DBG} $(EXTRA_POST_DBG)

release-shared:	$(EXTRA_PRE) ${PRG} ${ALLPRGS} $(EXTRA_POST)

release-static:	$(EXTRA_PRE) ${PRG} ${ALLPRGS} $(EXTRA_POST)

ifndef WITHOUT_STLPORT
stldbg-shared:	$(EXTRA_PRE_STLDBG) ${PRG_STLDBG} ${ALLPRGS_STLDBG} $(EXTRA_POST_STLDBG)

stldbg-static:	$(EXTRA_PRE_STLDBG) ${PRG_STLDBG} ${ALLPRGS_STLDBG} $(EXTRA_POST_STLDBG)
endif

ifeq ("$(findstring $(COMPILER_NAME),bcc dmc)","")
define cpplnk_str
$(LINK.cc) $(LINK_OUTPUT_OPTION) ${START_OBJ} $(1) $(LDLIBS) ${STDLIBS} ${END_OBJ}
endef
else
ifeq ($(OSNAME),windows)
define cpplnk_str
$(LINK.cc) $(subst /,\\,${START_OBJ} $(1) ${END_OBJ}, $(LINK_OUTPUT_OPTION), $(MAP_OUTPUT_OPTION), $(LDLIBS) ${STDLIBS},,)
endef
else
define cpplnk_str
$(LINK.cc) ${START_OBJ} $(1) ${END_OBJ}, $(LINK_OUTPUT_OPTION), $(MAP_OUTPUT_OPTION), $(LDLIBS) ${STDLIBS},,
endef
endif
endif

define prog_lnk
ifeq ($${_$(1)_C_SOURCES_ONLY},)
$${$(1)_PRG}:	$$($(1)_OBJ) $$(LIBSDEP) | $${OUTPUT_DIR}
	$$(call cpplnk_str,$$($(1)_OBJ))

$${$(1)_PRG_DBG}:	$$($(1)_OBJ_DBG) $$(LIBSDEP) | $${OUTPUT_DIR_DBG}
	$$(call cpplnk_str,$$($(1)_OBJ_DBG))

ifndef WITHOUT_STLPORT
$${$(1)_PRG_STLDBG}:	$$($(1)_OBJ_STLDBG) $$(LIBSDEP) | $${OUTPUT_DIR_STLDBG}
	$$(call cpplnk_str,$$($(1)_OBJ_STLDBG))
endif
else
$${$(1)_PRG}:	$$($(1)_OBJ) $$(LIBSDEP) | $${OUTPUT_DIR}
	$$(LINK.c) $$(LINK_OUTPUT_OPTION) $$($(1)_OBJ) $$(LDLIBS)

$${$(1)_PRG_DBG}:	$$(OBJ_DBG) $$(LIBSDEP) | $${OUTPUT_DIR_DBG}
	$$(LINK.c) $$(LINK_OUTPUT_OPTION) $$($(1)_OBJ_DBG) $$(LDLIBS)

ifndef WITHOUT_STLPORT
$${$(1)_PRG_STLDBG}:	$$($(1)_OBJ_STLDBG) $$(LIBSDEP) | $${OUTPUT_DIR_STLDBG}
	$$(LINK.c) $$(LINK_OUTPUT_OPTION) $$($(1)_OBJ_STLDBG) $$(LDLIBS)
endif
endif
endef

$(foreach prg,$(PRGNAMES),$(eval $(call prog_lnk,$(prg))))

ifeq ("${_C_SOURCES_ONLY}","")
${PRG}:	$(PRI_OBJ) $(LIBSDEP) | ${OUTPUT_DIR}
	$(call cpplnk_str,$(PRI_OBJ))

${PRG_DBG}:	$(PRI_OBJ_DBG) $(LIBSDEP) | ${OUTPUT_DIR_DBG}
	$(call cpplnk_str,$(PRI_OBJ_DBG))

ifndef WITHOUT_STLPORT
${PRG_STLDBG}:	$(PRI_OBJ_STLDBG) $(LIBSDEP) | ${OUTPUT_DIR_STLDBG}
	$(call cpplnk_str,$(PRI_OBJ_STLDBG))
endif
else
${PRG}:	$(PRI_OBJ) $(LIBSDEP) | ${OUTPUT_DIR}
	$(LINK.c) $(LINK_OUTPUT_OPTION) $(PRI_OBJ) $(LDLIBS)

${PRG_DBG}:	$(PRI_OBJ_DBG) $(LIBSDEP) | ${OUTPUT_DIR_DBG}
	$(LINK.c) $(LINK_OUTPUT_OPTION) $(PRI_OBJ_DBG) $(LDLIBS)

ifndef WITHOUT_STLPORT
${PRG_STLDBG}:	$(PRI_OBJ_STLDBG) $(LIBSDEP) | ${OUTPUT_DIR_STLDBG}
	$(LINK.c) $(LINK_OUTPUT_OPTION) $(PRI_OBJ_STLDBG) $(LDLIBS)
endif
endif
