# -*- Makefile-gmake -*-

DESTDIR := $(CURDIR)
BASE_INSTALL_DIR = /opt
INSTALL_LIB_DIR = ${BASE_INSTALL_LIB_DIR}/lib

# EXTRA_POST := check
# EXTRA_POST_DBG := check
# EXTRA_POST_STLDBG := check

include Makefile.inc
include ../../gmake/top.mak

ifndef WITHOUT_STLPORT
LDFLAGS += -Wl,-rpath=${STLPORT_LIB_DIR}
endif

ifndef WITHOUT_STLPORT
STLDTAG := stldbg-shared
endif

POST_INSTALL = touch $(DESTDIR)$(INSTALL_LIB_DIR)/post;

HEADERS = test.h

check:	install-release-shared install-headers
	[ -e $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMEx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME} -a \
	  -e $(DESTDIR)$(INSTALL_LIB_DIR)/post ] || exit 1 \
	  && { file $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx} | grep -q "shared object"; } \
	  && echo release ok
	[ -d $(DESTDIR)$(INSTALL_HDR_DIR) -a \
	  -f $(DESTDIR)$(INSTALL_HDR_DIR)/test.h ] || exit 2 \
	  && grep -q TEST $(DESTDIR)$(INSTALL_HDR_DIR)/test.h \
	  && echo headers ok

clean::	uninstall
	rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/post
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(INSTALL_LIB_DIR)
	rm -rf obj
	rm -f $(DESTDIR)$(INSTALL_HDR_DIR)/test.h
	rm -p $(DESTDIR)$(INSTALL_HDR_DIR)

PHONY += check
