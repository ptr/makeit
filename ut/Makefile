# -*- Makefile-gmake -*-

RULESBASE := ..
SUBDIRS := subdirs app1 app2 app2-mult app-c so1 somodule multiline_echo
include ${RULESBASE}/gmake/subdirs.mak

check:
	$(call doinsubdirs,${SUBDIRS})
	${MAKE} -C install check
	${MAKE} -C install-so check
	${MAKE} -C install-so-alt check

clean:
	$(call doinsubdirs,${SUBDIRS})
	${MAKE} -C install clean
	${MAKE} -C install-so clean
	${MAKE} -C install-so-alt clean

.PHONY:	check clean
