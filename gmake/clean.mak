# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2016, 2017
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

PHONY += clean distclean mostlyclean maintainer-clean uninstall

define obj_clean
clean::
	@-rm -f $$($(1)_OBJ) $$($(1)_DEP)
	@-rm -f $$($(1)_OBJ_DBG) $$($(1)_DEP_DBG)
	@-rm -f $$($(1)_OBJ_STLDBG) $$($(1)_DEP_STLDBG)
endef

clean::	
	@-if [ -f core ]; then rm core; else true; fi
	@-rm -f core.*
ifdef PRGNAME
	@-rm -f $(OBJ) $(DEP)
	@-rm -f $(OBJ_DBG) $(DEP_DBG)
	@-rm -f $(OBJ_STLDBG) $(DEP_STLDBG)
endif
ifdef LIBNAME
	@-rm -f $(OBJ) $(DEP)
ifneq (${OUTPUT_DIR},${OUTPUT_DIR_A})
	@-rm -f $(OBJ_A) $(DEP_A)
endif
	@-rm -f $(OBJ_DBG) $(DEP_DBG)
ifneq (${OUTPUT_DIR_DBG},${OUTPUT_DIR_A_DBG})
	@-rm -f $(OBJ_A_DBG) $(DEP_A_DBG)
endif
	@-rm -f $(OBJ_STLDBG) $(DEP_STLDBG)
ifneq (${OUTPUT_DIR_STLDBG},${OUTPUT_DIR_A_STLDBG})
	@-rm -f $(OBJ_A_STLDBG) $(DEP_A_STLDBG)
endif
endif

$(foreach prg,$(PRGNAMES) $(LIBNAMES) $(PDFNAMES),$(eval $(call obj_clean,$(prg))))

distclean::	clean
	@-rm -f .config.mk
# $(DEPENDS_COLLECTION) removed before directory,
# see app/clean.mak and lib/clean.mak

mostlyclean::	clean
	@-rm -f $(DEPENDS_COLLECTION)
	@-rm -f TAGS tags
	@-rm -f .config.mk

maintainer-clean::	distclean
	@rm -f ${RULESBASE}/config.mak
	@-rm -f TAGS tags
