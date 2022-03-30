# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2007
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

LDFLAGS ?= 

ifneq ("$(findstring $(OSNAME),darwin windows)","")
include ${RULESBASE}/${OSNAME}/lib.mak
else
include ${RULESBASE}/unix/lib.mak
endif

include ${RULESBASE}/lib/${COMPILER_NAME}.mak

ifneq ("$(findstring $(OSNAME),windows)","")
include ${RULESBASE}/${OSNAME}/rules-so.mak
else
include ${RULESBASE}/unix/rules-so.mak
endif

include ${RULESBASE}/lib/rules-a.mak

ifneq ("$(findstring $(OSNAME),windows)","")
include ${RULESBASE}/${OSNAME}/rules-install-so.mak
else
include ${RULESBASE}/unix/rules-install-so.mak
endif

include ${RULESBASE}/lib/rules-install-a.mak
include ${RULESBASE}/lib/clean.mak
