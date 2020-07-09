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
	$(INSTALL_A) ${A_NAME_OUT} $(DESTDIR)$(INSTALL_LIB_DIR)

install-dbg-static:	dbg-static
	@if [ ! -d $(DESTDIR)$(INSTALL_LIB_DIR_DBG) ] ; then \
	  mkdir -p $(DESTDIR)$(INSTALL_LIB_DIR_DBG) ; \
	fi
	$(INSTALL_A) ${A_NAME_OUT_DBG} $(DESTDIR)$(INSTALL_LIB_DIR_DBG)

ifndef WITHOUT_STLPORT

install-stldbg-static:	stldbg-static
	@if [ ! -d $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG) ] ; then \
	  mkdir -p $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG) ; \
	fi
	$(INSTALL_A) ${A_NAME_OUT_STLDBG} $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)

endif
