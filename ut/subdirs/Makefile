# -*- Makefile -*- Time-stamp: <2011-08-22 19:10:10 ptr>

RULESBASE := ../..

# EXTRA_POST := checks
# EXTRA_POST_DBG := checks-dbg
# EXTRA_POST_STLDBG := checks-stldbg

SUBDIRS := one two three
DESTDIR := dest

include ${RULESBASE}/gmake/subdirs.mak

check0:
	$(call doinsubdirs,${SUBDIRS})

check:	check0
	$(call doinsubdirs,${SUBDIRS},DESTDIR=${DESTDIR})

.PHONY:	check0 check

