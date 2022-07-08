# -*- Makefile-gnu -*-

# Expected:
#
# bash-5.1$ make DEBUG_RULES=1
# Makefile:34: all: dummy (dummy)
# Here -j50 PARALLEL=
# Makefile:35: all: dummy (dummy)
# make -f Makefile.mk -j50 PARALLEL= all2
# make[1]: Entering directory '.../makeit/ut/debug-rules'
# /bin/bash
# Secondary
#
# make[1]: Leaving directory '.../makeit/ut/debug-rules'
#

# bash-5.1$ make DEBUG_RULES=2
# Makefile:34: all: dummy (dummy)
# + echo Here -j50 PARALLEL=
# Here -j50 PARALLEL=
# Makefile:35: all: dummy (dummy)
# make -f Makefile.mk -j50 PARALLEL= all2
# + make -f Makefile.mk -j50 PARALLEL= all2
# make[1]: Entering directory '.../makeit/ut/debug-rules'
# /bin/bash
# Secondary
#
# make[1]: Leaving directory '.../makeit/ut/debug-rules'
#

include ../../gmake/sysid.mak

all:	dummy
	@echo Here ${PARALLEL}
	${MAKE} -f Makefile.mk ${PARALLEL} all2

.PHONY:	all dummy
