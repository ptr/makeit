# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002-2014, 2017, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

PHONY += release-static-dep release-shared-dep dbg-static-dep dbg-shared-dep \
         depend depend-clean

ifndef WITHOUT_STLPORT
PHONY += stldbg-static-dep stldbg-shared-dep
endif

release-static-dep release-shared-dep:	$(DEP) | $(dir $(DEPENDS_COLLECTION))
	cat -s $(DEP) /dev/null > $(DEPENDS_COLLECTION)

dbg-static-dep dbg-shared-dep:	$(DEP_DBG) | $(dir $(DEPENDS_COLLECTION))
	cat -s $(DEP_DBG) /dev/null > $(DEPENDS_COLLECTION)

ifndef WITHOUT_STLPORT
stldbg-static-dep stldbg-shared-dep:	$(DEP_STLDBG) | $(dir $(DEPENDS_COLLECTION))
	cat -s $(DEP_STLDBG) /dev/null > $(DEPENDS_COLLECTION)
endif

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

# remove $(DEPENDS_COLLECTION) to prevent interpretation in -include $(DEPENDS_COLLECTION) below:
# old dependencies may be incorrect.

depend-clean:
	rm -f $(DEPENDS_COLLECTION)

# do not use $(DEPENDS_COLLECTION) as target in rule:
# due to -include $(DEPENDS_COLLECTION) directive, make will try
# to build $(DEPENDS_COLLECTION) target. This is not what I want here,
# because
#  - dependencies may include generated files (that not exist yet);
#  - I do not want to pay for dependencies generation in case of single build,
#    like CI do.

depend::	depend-clean ${_ALL_DEP} | $(dir $(DEPENDS_COLLECTION))
	@cat -s $(_ALL_DEP) /dev/null > $(DEPENDS_COLLECTION)

ifneq ($(OSNAME),windows)
TAGS:	${_ALL_DEP}
	@cat -s $(_ALL_DEP) /dev/null | sed -e 's/^.*://;s/^ *//;s/\\$$//;s/ $$//;s/ /\n/g' | sort -u | xargs etags -I --declarations

tags:	${_ALL_DEP}
	@cat -s $(_ALL_DEP) /dev/null | sed -e 's/^.*://;s/^ *//;s/\\$$//;s/ $$//;s/ /\n/g' | sort -u | xargs ctags --tag-relative=yes
endif

-include $(DEPENDS_COLLECTION)
