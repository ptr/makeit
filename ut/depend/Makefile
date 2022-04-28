# -*- Makefile-gmake -*-

# EXTRA_POST := check
# EXTRA_POST_DBG := check
# EXTRA_POST_STLDBG := check

ALL_TAGS := check

include Makefile.inc
include ../../gmake/top.mak

ifndef WITHOUT_STLPORT
LDFLAGS += -Wl,-rpath=${STLPORT_LIB_DIR}
endif

ifndef WITHOUT_STLPORT
STLDTAG := stldbg-shared
endif

check:	depend
	@echo Running 1 test case...
	[ -f $(DEPENDS_COLLECTION) ] || exit 1
	grep -q "${OUTPUT_DIR}/test.o" $(DEPENDS_COLLECTION) || exit 1
	grep -q "${OUTPUT_DIR_DBG}/test.o" $(DEPENDS_COLLECTION) || exit 1
	grep -q "${OUTPUT_DIR}/test.d" $(DEPENDS_COLLECTION) || exit 1
	grep -q "${OUTPUT_DIR_DBG}/test.d" $(DEPENDS_COLLECTION) || exit 1
	@echo "*** No errors detected"

PHONY += check
