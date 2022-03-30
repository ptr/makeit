# -*- Makefile-gmake -*-

DESTDIR := $(CURDIR)
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

POST_INSTALL = touch $(DESTDIR)$(INSTALL_BIN_DIR)/post;

check:	install-release-shared
	[ -e $(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME} -a -e $(DESTDIR)$(INSTALL_BIN_DIR)/post ] || exit 1 \
	  && { file $(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME} | grep -q "not stripped"; } \
	  && echo release ok

clean::
	rm -f $(DESTDIR)$(INSTALL_BIN_DIR)/post
	rm -f $(DESTDIR)$(INSTALL_BIN_DIR)/${INSTALL_PRGNAME}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(INSTALL_BIN_DIR)
	rm -rf obj

PHONY += check
