# -*- Makefile -*-

RULESBASE := ../..

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

check:	release-shared dbg-shared ${STLDTAG}
	[ -f .config.mk ] && echo ok || exit 1

PHONY += check
