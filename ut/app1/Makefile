# -*- Makefile -*- Time-stamp: <2011-08-22 19:21:53 ptr>

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
	${PRG} || exit 1 && echo release ok
	${PRG_DBG} || exit 1 && echo dbg ok
ifndef WITHOUT_STLPORT
	${PRG_STLDBG} || exit 1 && echo stldbg ok
endif

PHONY += check
