# -*- Makefile -*- Time-stamp: <2016-05-13 11:30:36 ptr>

RULESBASE := ..
SUBDIRS := subdirs app1 app2 app2-mult app-c so1 somodule multiline_echo
include ${RULESBASE}/gmake/subdirs.mak

check:
	$(call doinsubdirs,${SUBDIRS})

clean:
	$(call doinsubdirs,${SUBDIRS})

.PHONY:	check clean
