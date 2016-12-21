# -*- makefile -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005, 2006, 2016
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

ifndef WITHOUT_STLPORT
install:	install-release-shared install-dbg-shared install-stldbg-shared
else
install:	install-release-shared install-dbg-shared
endif

INSTALL_PRGNAMES =
INSTALL_PRGNAMES_DBG =
INSTALL_PRGNAMES_STLDBG =

define prog_install
INSTALL_$(1)_PRGNAME := $(1)${EXE}
INSTALL_PRGNAMES += $$(DESTDIR)$$(INSTALL_BIN_DIR)/$${INSTALL_$(1)_PRGNAME}
INSTALL_PRGNAMES_DBG += $$(DESTDIR)$$(INSTALL_BIN_DIR_DBG)/$${INSTALL_$(1)_PRGNAME}

ifndef INSTALL_DBG
ifndef INSTALL_STRIP
$$(DESTDIR)$$(INSTALL_BIN_DIR)/$${INSTALL_$(1)_PRGNAME}:	release-shared | $$(DESTDIR)$$(INSTALL_BIN_DIR)
	if [ ! -e $$@ ] || cmp $$@ $${$(1)_PRG} ; then \
	  $$(INSTALL_EXE) $${$(1)_PRG} $$@ && \
	  touch $$(PRE_OUTPUT_DIR)/.install; \
	fi
else
$$(DESTDIR)$$(INSTALL_BIN_DIR)/$${INSTALL_$(1)_PRGNAME}:	release-shared | $$(DESTDIR)$$(INSTALL_BIN_DIR)
	if [ ! -e $$@ ] || cmp $$@ $${$(1)_PRG} ; then \
	  $${STRIP} $${_INSTALL_STRIP_OPTION} $$@ && \
	  $$(INSTALL_EXE) $${$(1)_PRG} $$@ && \
	  touch $$(PRE_OUTPUT_DIR)/.install; \
	fi
endif
else
$$(DESTDIR)$$(INSTALL_BIN_DIR)/$${INSTALL_$(1)_PRGNAME}:	dbg-shared | $$(DESTDIR)$$(INSTALL_BIN_DIR)
	if [ ! -e $$@ ] || cmp $$@ $${$(1)_PRG_DBG} ; then \
	  $$(INSTALL_EXE) $${$(1)_PRG_DBG} $$@ && \
	  touch $$(PRE_OUTPUT_DIR)/.install; \
	fi
endif

ifneq ($(INSTALL_BIN_DIR),$(INSTALL_BIN_DIR_DBG))
$$(DESTDIR)$$(INSTALL_BIN_DIR_DBG)/$${INSTALL_$(1)_PRGNAME}:	dbg-shared | $$(DESTDIR)$$(INSTALL_BIN_DIR_DBG)
	if [ ! -e $$@ ] || cmp $$@ $${$(1)_PRG_DBG} ; then \
	  $$(INSTALL_EXE) $${$(1)_PRG_DBG} $$@ && \
	  touch $$(PRE_OUTPUT_DIR)/.install; \
	fi
endif

ifndef WITHOUT_STLPORT
INSTALL_$(1)_PRGNAME_STLDBG := $${INSTALL_$(1)_PRGNAME}
INSTALL_PRGNAMES_STLDBG += $$(DESTDIR)$$(INSTALL_BIN_DIR_STLDBG)/$${INSTALL_$(1)_PRGNAME_STLDBG}
endif
endef

define prog_strip_install
${STRIP} ${_INSTALL_STRIP_OPTION} $$(DESTDIR)$$(INSTALL_BIN_DIR)/$${INSTALL_$(1)_PRGNAME};
endef

ifndef INSTALL_STRIP_TAGS
INSTALL_STRIP_TAGS := install-strip-shared
endif

INSTALL_PRGNAME := ${PRGNAME}${EXE}
$(foreach prg,$(PRGNAMES),$(eval $(call prog_install,$(prg))))

INSTALL_PRGNAME_DBG := ${INSTALL_PRGNAME}

ifndef WITHOUT_STLPORT
INSTALL_PRGNAME_STLDBG := ${INSTALL_PRGNAME}
endif

$(DESTDIR)$(INSTALL_BIN_DIR):
	${INSTALL} -d -m 0755 $@

ifneq ($(INSTALL_BIN_DIR),$(INSTALL_BIN_DIR_DBG))
$(DESTDIR)$(INSTALL_BIN_DIR_DBG):
	${INSTALL} -d -m 0755 $@
endif

ifeq ($(INSTALL_BIN_DIR),$(INSTALL_BIN_DIR_DBG))
install-dbg-shared:	INSTALL_DBG := 1
endif

install-strip:	INSTALL_STRIP = 1

install-strip-shared:	INSTALL_STRIP = 1

ifdef PRGNAME
INSTALL_PRGNAMES += $(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME}
INSTALL_PRGNAMES_DBG += $(DESTDIR)$(INSTALL_BIN_DIR_DBG)/${INSTALL_PRGNAME}
ifndef INSTALL_DBG
ifndef INSTALL_STRIP
$(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME}:	release-shared | $(DESTDIR)$(INSTALL_BIN_DIR)
	if [ ! -e $@ ] || cmp $@ ${PRG} ; then \
	  $(INSTALL_EXE) ${PRG} $@ && \
	  touch $(PRE_OUTPUT_DIR)/.install; \
	fi
else
$(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME}:	release-shared | $(DESTDIR)$(INSTALL_BIN_DIR)
	if [ ! -e $@ ] || cmp $@ ${PRG} ; then \
	   ${STRIP} ${_INSTALL_STRIP_OPTION} ${PRG} && \
	   $(INSTALL_EXE) ${PRG} $@ && \
	   touch $(PRE_OUTPUT_DIR)/.install; \
	fi
endif
else
$(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME}:	dbg-shared | $(DESTDIR)$(INSTALL_BIN_DIR)
	if [ ! -e $@ ] || cmp $@ ${PRG_DBG} ; then \
	  $(INSTALL_EXE) ${PRG_DBG} $@ && \
	  touch $(PRE_OUTPUT_DIR)/.install; \
	fi
endif

ifneq ($(INSTALL_BIN_DIR),$(INSTALL_BIN_DIR_DBG))
$(DESTDIR)$(INSTALL_BIN_DIR_DBG)/${INSTALL_PRGNAME}:	dbg-shared | $(DESTDIR)$(INSTALL_BIN_DIR_DBG)
	if [ ! -e $@ ] || cmp $@ ${PRG_DBG} ; then \
	  $(INSTALL_EXE) ${PRG_DBG} $@ && \
	  touch $(PRE_OUTPUT_DIR)/.install; \
	fi
endif
endif

install-release-shared:	$(INSTALL_PRGNAMES) $(INSTALL_DEPS_EXTRA)
	if [ -e $(PRE_OUTPUT_DIR)/.install ] ; then \
	  rm $(PRE_OUTPUT_DIR)/.install; \
	  : ; $(POST_INSTALL) \
	fi

install-dbg-shared:	$(INSTALL_PRGNAMES_DBG) $(INSTALL_DEPS_DBG_EXTRA)
	if [ -e $(PRE_OUTPUT_DIR)/.install ] ; then \
	  rm $(PRE_OUTPUT_DIR)/.install; \
	  : ; $(POST_INSTALL_DBG) \
	fi

install-strip:	$(INSTALL_PRGNAMES) $(INSTALL_DEPS_EXTRA)
	if [ -e $(PRE_OUTPUT_DIR)/.install ] ; then \
	  rm $(PRE_OUTPUT_DIR)/.install; \
	  : ; $(POST_INSTALL) \
	fi

install-strip-shared:	$(INSTALL_PRGNAMES) $(INSTALL_DEPS_EXTRA)
	if [ -e $(PRE_OUTPUT_DIR)/.install ] ; then \
	  rm $(PRE_OUTPUT_DIR)/.install; \
	  : ; $(POST_INSTALL) \
	fi

clean::
	rm -f $(PRE_OUTPUT_DIR)/.install

ifndef WITHOUT_STLPORT
install-stldbg-shared: $(INSTALL_PRGNAMES_STLDBG)
	$(POST_INSTALL_STLDBG)
endif

PHONY += install-strip install-strip-shared
