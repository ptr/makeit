# -*- Makefile-gmake -*-

include Makefile.inc
include ../../gmake/top.mak

check:	check-release-static check-dbg-static

check-release-static:	release-static
	@echo Running 2 test cases...
	@file ${test2_A_NAME_OUT} | grep "ar archive" >/dev/null || exit 1
	@file ${test3_A_NAME_OUT} | grep "ar archive" >/dev/null || exit 1
	@echo "*** No errors detected"

check-dbg-static:	dbg-static
	@echo Running 2 test cases...
	@file ${test2_A_NAME_OUT_DBG} | grep "ar archive" >/dev/null || exit 1
	@file ${test3_A_NAME_OUT_DBG} | grep "ar archive" >/dev/null || exit 1
	@echo "*** No errors detected"

PHONY += check check-release-static check-dbg-static
