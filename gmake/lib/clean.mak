# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2007, 2018
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

define lib_clean
clean::
	@-rm -f $${$(1)_SO_NAME_OUT}
	@-rm -f $${$(1)_SO_NAME_OUTx}
	@-rm -f $${$(1)_SO_NAME_OUTxx}
	@-rm -f $${$(1)_SO_NAME_OUTxxx}
	@-rm -f $${$(1)_SO_NAME_OUT_DBG}
	@-rm -f $${$(1)_SO_NAME_OUT_DBGx}
	@-rm -f $${$(1)_SO_NAME_OUT_DBGxx}
	@-rm -f $${$(1)_SO_NAME_OUT_DBGxxx}
ifndef WITHOUT_STLPORT
	@-rm -f $${$(1)_SO_NAME_OUT_STLDBG}
	@-rm -f $${$(1)_SO_NAME_OUT_STLDBGx}
	@-rm -f $${$(1)_SO_NAME_OUT_STLDBGxx}
	@-rm -f $${$(1)_SO_NAME_OUT_STLDBGxxx}
endif
	@-if [ -f $${$(1)_A_NAME_OUT} ]; then rm -f $${$(1)_A_NAME_OUT}; else true; fi
	@-if [ -f $${$(1)_A_NAME_OUT_DBG} ]; then rm -f $${$(1)_A_NAME_OUT_DBG}; else true; fi
ifndef WITHOUT_STLPORT
	@-rm -f $${$(1)_A_NAME_OUT_STLDBG}
endif
ifeq ($(OSNAME), windows)
	@-rm -f $${$(1)_LIB_NAME_OUT}
	@-rm -f $${$(1)_LIB_NAME_OUT_DBG}
ifndef WITHOUT_STLPORT
	@-rm -f $${$(1)_LIB_NAME_OUT_STLDBG}
endif
	@-rm -f $${$(1)_RES}
	@-rm -f $${$(1)_RES_DBG}
ifndef WITHOUT_STLPORT
	@-rm -f $${$(1)_RES_STLDBG}
endif
endif

uninstall::
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR)/$$($(1)_SO_NAME)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR)/$$($(1)_SO_NAMEx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR)/$$($(1)_SO_NAMExx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR)/$$($(1)_SO_NAMExxx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$$($(1)_SO_NAME_DBG)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$$($(1)_SO_NAME_DBGx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$$($(1)_SO_NAME_DBGxx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$$($(1)_SO_NAME_DBGxxx)
ifndef WITHOUT_STLPORT
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_STLDBG)/$$($(1)_SO_NAME_STLDBG)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_STLDBG)/$$($(1)_SO_NAME_STLDBGx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_STLDBG)/$$($(1)_SO_NAME_STLDBGxx)
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_STLDBG)/$$($(1)_SO_NAME_STLDBGxxx)
endif
	-if [ -f $$(DESTDIR)$$(INSTALL_LIB_DIR)/$${$(1)_A_NAME_OUT} ]; then rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR)/$${$(1)_A_NAME_OUT}; else true; fi
	-if [ -f $$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$${$(1)_A_NAME_OUT_DBG} ]; then rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$${$(1)_A_NAME_OUT_DBG}; else true; fi
ifndef WITHOUT_STLPORT
	@-rm -f $$(DESTDIR)$$(INSTALL_LIB_DIR_STLDBG)/$${$(1)_A_NAME_OUT_STLDBG}
endif
	-rmdir -p $$(patsubst %,$$(DESTDIR)%,$$(INSTALL_LIB_DIRS)) 2>/dev/null
endef

$(foreach nm,$(LIBNAMES),$(eval $(call lib_clean,$(nm))))

ifdef LIBNAME
clean::
	@-rm -f ${SO_NAME_OUT}
	@-rm -f ${SO_NAME_OUTx}
	@-rm -f ${SO_NAME_OUTxx}
	@-rm -f ${SO_NAME_OUTxxx}
	@-rm -f ${SO_NAME_OUT_DBG}
	@-rm -f ${SO_NAME_OUT_DBGx}
	@-rm -f ${SO_NAME_OUT_DBGxx}
	@-rm -f ${SO_NAME_OUT_DBGxxx}
ifndef WITHOUT_STLPORT
	@-rm -f ${SO_NAME_OUT_STLDBG}
	@-rm -f ${SO_NAME_OUT_STLDBGx}
	@-rm -f ${SO_NAME_OUT_STLDBGxx}
	@-rm -f ${SO_NAME_OUT_STLDBGxxx}
endif
	@-if [ -f ${A_NAME_OUT} ]; then rm -f ${A_NAME_OUT}; else true; fi
	@-if [ -f ${A_NAME_OUT_DBG} ]; then rm -f ${A_NAME_OUT_DBG}; else true; fi
ifndef WITHOUT_STLPORT
	@-rm -f ${A_NAME_OUT_STLDBG}
endif
ifeq ($(OSNAME), windows)
	@-rm -f ${LIB_NAME_OUT}
	@-rm -f ${LIB_NAME_OUT_DBG}
ifndef WITHOUT_STLPORT
	@-rm -f ${LIB_NAME_OUT_STLDBG}
endif
	@-rm -f ${RES}
	@-rm -f ${RES_DBG}
ifndef WITHOUT_STLPORT
	@-rm -f ${RES_STLDBG}
endif
endif
endif

distclean::
	@-rm -f $(DEPENDS_COLLECTION)
	@-rmdir -p $(AUX_DIR) ${OUTPUT_DIR} ${OUTPUT_DIR_DBG} ${OUTPUT_DIR_STLDBG} 2>/dev/null

ifdef LIBNAME
uninstall::
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/$(SO_NAME)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/$(SO_NAMEx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/$(SO_NAMExx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/$(SO_NAMExxx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/$(SO_NAME_DBG)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/$(SO_NAME_DBGx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/$(SO_NAME_DBGxx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/$(SO_NAME_DBGxxx)
ifndef WITHOUT_STLPORT
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/$(SO_NAME_STLDBG)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/$(SO_NAME_STLDBGx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/$(SO_NAME_STLDBGxx)
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/$(SO_NAME_STLDBGxxx)
endif
	@-if [ -f $(DESTDIR)$(INSTALL_LIB_DIR)/${A_NAME_OUT} ]; then rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/${A_NAME_OUT}; else true; fi
	@-if [ -f $(DESTDIR)$(INSTALL_LIB_DIR)/${A_NAME_OUT} ]; then rm -f $(DESTDIR)$(INSTALL_LIB_DIR_DBG)/${A_NAME_OUT_DBG}; else true; fi
ifndef WITHOUT_STLPORT
	@-rm -f $(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/${A_NAME_OUT_STLDBG}
endif
	-rmdir -p $(patsubst %,$(DESTDIR)%,$(INSTALL_LIB_DIRS)) 2>/dev/null
endif
