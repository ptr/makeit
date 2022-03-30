# -*- Makefile-gmake -*-

# EXTRA_POST := checks

include Makefile.inc
include ../../gmake/top.mak

INCLUDES += -I./include

check:	check-release-static check-dbg-static

check-release-static:	release-static
	@echo Running 1 test case...
	@file ${A_NAME_OUT} | grep "ar archive" >/dev/null || exit 1
	@echo "*** No errors detected"

check-dbg-static:	dbg-static
	@echo Running 1 test case...
	@file ${A_NAME_OUT_DBG} | grep "ar archive" >/dev/null || exit 1
	@echo "*** No errors detected"

PHONY += check check-release-static check-dbg-static


