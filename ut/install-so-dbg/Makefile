# -*- Makefile-gmake -*-

DESTDIR := $(CURDIR)
# EXTRA_POST := check
# EXTRA_POST_DBG := check
# EXTRA_POST_STLDBG := check

DBG_SUFFIX :=
_PREFER_DBG_INSTALL := 1

include Makefile.inc
include ../../gmake/top.mak

ifndef WITHOUT_STLPORT
LDFLAGS += -Wl,-rpath=${STLPORT_LIB_DIR}
endif

ifndef WITHOUT_STLPORT
STLDTAG := stldbg-shared
endif

check:	install-dbg-shared
	[ -e $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxxx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBG} \
	] || exit 1
	file $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxxx} | grep -q "shared object" || exit 2
	file $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxxx} | grep -q "with debug_info" || exit 3
	@echo "*** No errors detected"

clean::	uninstall
	-rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(INSTALL_LIB_DIR)
	rm -rf obj

PHONY += check
