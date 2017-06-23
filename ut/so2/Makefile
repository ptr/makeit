# -*- Makefile-gmake -*-

RULESBASE := ../..

# EXTRA_POST := check-release-shared
# EXTRA_POST_DBG := check-dbg-shared
# EXTRA_POST_STLDBG := check-stldbg-shared

include Makefile.inc
include ${RULESBASE}/gmake/top.mak

ifndef WITHOUT_STLPORT
LDFLAGS += -Wl,-rpath=${STLPORT_LIB_DIR}
endif

check:	check-release-shared check-dbg-shared check-stldbg-shared

check-release-shared:	release-shared
	@echo Running 2 test cases...
	@file ${test2_SO_NAME_OUTxxx} | grep ELF >/dev/null || exit 1
	@file ${test3_SO_NAME_OUTxxx} | grep ELF >/dev/null || exit 1
	@echo "*** No errors detected"

check-dbg-shared:	dbg-shared
	@echo Running 2 test cases...
	@file ${test2_SO_NAME_OUT_DBGxxx} | grep ELF >/dev/null || exit 1
	@file ${test3_SO_NAME_OUT_DBGxxx} | grep ELF >/dev/null || exit 1
	@echo "*** No errors detected"

ifndef WITHOUT_STLPORT
check-stldbg-shared:	stldbg-shared
	@echo Running 2 test cases...
	@file ${test2_SO_NAME_OUT_STLDBGxxx} | grep ELF >/dev/null || exit 1
	@file ${test3_SO_NAME_OUT_STLDBGxxx} | grep ELF >/dev/null || exit 1
	@echo "*** No errors detected"
endif

PHONY += check check-release-shared check-dbg-shared check-stldbg-shared
