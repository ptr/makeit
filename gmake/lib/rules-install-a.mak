# -*- makefile -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005, 2006, 2020
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

PHONY += install-release-static install-dbg-static install-stldbg-static

install-release-static:	release-static
	@if [ ! -d $(DESTDIR)$(INSTALL_LIB_DIR) ] ; then \
	  mkdir -p $(DESTDIR)$(INSTALL_LIB_DIR) ; \
	fi
	if [ ! -e $(DESTDIR)$(INSTALL_LIB_DIR)/$(notdir ${A_NAME_OUT}) ] || ! cmp -s $(DESTDIR)$(INSTALL_LIB_DIR)/$(notdir ${A_NAME_OUT}) ${A_NAME_OUT} ; then \
	  $(INSTALL_A) ${A_NAME_OUT} $(DESTDIR)$(INSTALL_LIB_DIR); \
	fi

install-dbg-static:	dbg-static
	@if [ ! -d $(DESTDIR)$(INSTALL_LIB_DIR_DBG) ] ; then \
	  mkdir -p $(DESTDIR)$(INSTALL_LIB_DIR_DBG) ; \
	fi
	if [ ! -e $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/$(notdir ${A_NAME_OUT_DBG}) ] || ! cmp -s $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/$(notdir ${A_NAME_OUT_DBG}) ${A_NAME_OUT_DBG} ; then \
	  $(INSTALL_A) ${A_NAME_OUT_DBG} $(DESTDIR)$(INSTALL_LIB_DIR_DBG); \
	fi

ifndef WITHOUT_STLPORT

install-stldbg-static:	stldbg-static
	@if [ ! -d $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG) ] ; then \
	  mkdir -p $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG) ; \
	fi
	if [ ! -e $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/$(notdir ${A_NAME_OUT_STLDBG}) ] || ! cmp -s $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/$(notdir ${A_NAME_OUT_STLDBG}) ${A_NAME_OUT_STLDBG} ; then \
	  $(INSTALL_A) ${A_NAME_OUT_STLDBG} $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG); \
	fi

endif
