# -*- Makefile-gmake -*-

# EXTRA_POST := checks
# EXTRA_POST_DBG := checks-dbg
# EXTRA_POST_STLDBG := checks-stldbg

SUBDIRS := one two three
DESTDIR := dest

include ../../gmake/subdirs.mak

check0:
	$(call doinsubdirs,${SUBDIRS})

check:	check0
	$(call doinsubdirs,${SUBDIRS},DESTDIR=${DESTDIR})

clean::

.PHONY:	check0 check clean

