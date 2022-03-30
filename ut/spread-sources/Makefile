# -*- Makefile-gmake -*-

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

check:	release-shared dbg-shared ${STLDTAG}
	@[ $$(${PRG}) = "src/test.cc:test2.cc:" ] || echo primary release FAIL && echo primary release PASSED
	@[ $$(${PRG_DBG}) = "src/test.cc:test2.cc:" ] || primary debug FAIL && echo primary debug PASSED
ifndef WITHOUT_STLPORT
	@[ $$(${PRG_STLDBG}) = "src/test.cc:test2.cc:" ] || echo primary stldbg FAIL && echo primary stldbg PASSED
endif
	@[ $$(${test3_PRG}) = "src/test3.cc:" ] || echo secondary release FAIL 1 && echo secondary release PASSED
	@[ $$(${test3_PRG_DBG}) = "src/test3.cc:" ] || echo secondary debug FAIL && echo secondary debug PASSED
ifndef WITHOUT_STLPORT
	@[ $$(${test3_PRG_STLDBG}) = "src/test3.cc:" ] || echo secondary stldbg FAIL && echo secondary stldbg PASSED
endif

PHONY += check
