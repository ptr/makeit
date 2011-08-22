# -*- Makefile -*- Time-stamp: <2011-08-22 19:09:25 ptr>

RULESBASE := ..
SUBDIRS := subdirs app1 app2 app2-mult app-c so1 somodule
include ${RULESBASE}/gmake/subdirs.mak

check:
	$(call doinsubdirs,${SUBDIRS})

clean:
	$(call doinsubdirs,${SUBDIRS})

.PHONY:	check clean
