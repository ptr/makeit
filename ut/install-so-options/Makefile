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

POST_INSTALL_DBG = touch $(DESTDIR)$(INSTALL_LIB_DIR)/post;

# check for debug_info really for opetions passed to compiler
# via rule-dependent macros like ${OPT}:
#
#    c++ -pthread -fexceptions   -std=gnu++1z  -fPIC    -c -o obj/gcc/so/test.o test.cc
#
# is wrong, should be
#
#   c++ -pthread -fexceptions -O2 -std=gnu++1z  -fPIC    -c -o obj/gcc/so/test.o test.cc
#

check:	install-dbg-shared
	[ -e $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxxx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGx} -a \
	  -h $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBG} -a \
	  -e $(DESTDIR)$(INSTALL_LIB_DIR)/post ] || exit 1
	file $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAME_DBGxxx} | grep -q "shared object" || exit 2
	file ${OUTPUT_DIR_DBG}/test.o | grep -q "with debug_info" || exit 3
	@echo "*** No errors detected"

clean::	uninstall
	rm -f $(DESTDIR)$(INSTALL_LIB_DIR)/post
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(INSTALL_LIB_DIR)
	rm -rf obj

PHONY += check
