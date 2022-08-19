# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

# Static libraries tags

PHONY += release-static dbg-static stldbg-static

release-static: $(EXTRA_PRE) ${ALLSTLIBS} $(EXTRA_POST)

ifdef EXTRA_PRE
ifdef ALLSTLIBS
${ALLSTLIBS}:	$(EXTRA_PRE)
endif
endif

ifdef EXTRA_POST
$(EXTRA_POST):	$(EXTRA_PRE) ${ALLSTLIBS}
endif

dbg-static:	$(EXTRA_PRE_DBG) ${ALLSTLIBS_DBG} $(EXTRA_POST_DBG)

ifdef EXTRA_PRE_DBG
ifdef ALLSTLIBS_DBG
${ALLSTLIBS_DBG}:	$(EXTRA_PRE_DBG)
endif
endif

ifdef EXTRA_POST_DBG
$(EXTRA_POST_DBG):	$(EXTRA_PRE_DBG) ${ALLSTLIBS_DBG}
endif

ifndef WITHOUT_STLPORT
stldbg-static:	$(EXTRA_PRE_STLDBG) ${ALLSTLIBS_STLDBG} $(EXTRA_POST_STLDBG)
endif

define do_a_libs
$${A_NAME_OUT$(1)}:	$$(OBJ_A$(1)) | $$(OUTPUT_DIR_A$(1))
	rm -f $$@
	$$(AR) $$(AR_INS_R) $$(AR_OUT) $$(OBJ_A$(1))

$${A_NAME_OUT$(1)}:	OPT += ${OPT_LEVEL$(1)}
ifeq ($(1),_DBG)
$${A_NAME_OUT$(1)}:	OPT += -g
endif
endef

define do_a_libs_m
$${$(2)_A_NAME_OUT$(1)}:	$$($(2)_OBJ_A$(1)) | $$(OUTPUT_DIR_A$(1))
	rm -f $$@
	$$(AR) $$(AR_INS_R) $$(AR_OUT) $$($(2)_OBJ_A$(1))

$${$(2)_A_NAME_OUT$(1)}:	OPT += ${OPT_LEVEL$(1)}
ifeq ($(1),_DBG)
$${$(2)_A_NAME_OUT$(1)}:	OPT += -g
endif
endef

define do_a_libs_wk
# expand to nothing, if WITHOUT_STLPORT
ifndef WITHOUT_STLPORT
$(call do_a_libs,$(1))
$(foreach l,$(LIBNAMES),$(eval $(call do_a_libs_m,$(1),$(l))))
endif
endef

$(eval $(call do_a_libs,))
$(foreach l,$(LIBNAMES),$(eval $(call do_a_libs_m,,$(l))))
$(eval $(call do_a_libs,_DBG))
$(foreach l,$(LIBNAMES),$(eval $(call do_a_libs_m,_DBG,$(l))))
# ifndef WITHOUT_STLPORT
$(eval $(call do_a_libs_wk,_STLDBG))
# endif
