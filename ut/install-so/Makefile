# -*- Makefile -*-

RULESBASE := ../..

DESTDIR := $(CURDIR)
# EXTRA_POST := check
# EXTRA_POST_DBG := check
# EXTRA_POST_STLDBG := check

include Makefile.inc
include ${RULESBASE}/gmake/top.mak

ifndef WITHOUT_STLPORT
LDFLAGS += -Wl,-rpath=${STLPORT_LIB_DIR}
endif

ifndef WITHOUT_STLPORT
STLDTAG := stldbg-shared
endif

POST_INSTALL = touch $(DESTDIR)$(INSTALL_LIB_DIR)/post;

check:	install-release-shared
	[ -e $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMEx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME} -a \
	  -e $(DESTDIR)$(INSTALL_LIB_DIR)/post ] || exit 1 \
	  && { file $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx} | grep -q "shared object"; } \
	  && echo release ok

clean::	uninstall
	rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/post
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(INSTALL_LIB_DIR)
	rm -rf obj

PHONY += check
