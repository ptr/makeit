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

PHONY += release-static-dep release-shared-dep dbg-static-dep dbg-shared-dep \
         depend

ifndef WITHOUT_STLPORT
PHONY += stldbg-static-dep stldbg-shared-dep
endif

release-static-dep release-shared-dep:	$(DEP)

dbg-static-dep dbg-shared-dep:	$(DEP_DBG)

#ifndef WITHOUT_STLPORT
#stldbg-static-dep stldbg-shared-dep:	$(DEP_STLDBG)
#
#_ALL_DEP := $(sort $(DEP) $(DEP_DBG) $(DEP_STLDBG))
#_DASH_DEP := release-shared-dep dbg-shared-dep stldbg-shared-dep
#else
#_ALL_DEP := $(sort $(DEP) $(DEP_DBG))
#_DASH_DEP := release-shared-dep dbg-shared-dep
#endif

define prgdep_
_ALL_DEP += $$($(1)DEP) $$($(1)DEP_DBG)
ifndef WITHOUT_STLPORT
_ALL_DEP += $$($(1)DEP_STLDBG)
endif
endef

$(if $(PRGNAME),$(eval $(call prgdep_,)))
$(if $(LIBNAME),$(eval $(call prgdep_,)))
# $(if $(PDFNAME),$(eval $(call prgdep_,)))
$(foreach n,$(PRGNAMES) $(LIBNAMES) $(PDFNAMES),$(eval $(call prgdep_,$(n)_)))

OUTPUT_DIRS += $(dir $(DEPENDS_COLLECTION))

depend::	${_ALL_DEP} | $(dir $(DEPENDS_COLLECTION))
	cat -s $(_ALL_DEP) /dev/null > $(DEPENDS_COLLECTION)

ifneq ($(OSNAME),windows)
TAGS:	${_ALL_DEP}
	@cat -s $(_ALL_DEP) /dev/null | sed -e 's/^.*://;s/^ *//;s/\\$$//;s/ $$//;s/ /\n/g' | sort | uniq | xargs etags -I --declarations

tags:	${_ALL_DEP}
	@cat -s $(_ALL_DEP) /dev/null | sed -e 's/^.*://;s/^ *//;s/\\$$//;s/ $$//;s/ /\n/g' | sort | uniq | xargs ctags -d --globals --declarations -t -T 
endif

-include $(DEPENDS_COLLECTION)
