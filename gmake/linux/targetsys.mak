# -*- Makefile -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

SO := so

ARCH := a

ifndef _FORCE_STRIP
STRIP := strip
else
STRIP := ${_FORCE_STRIP}
endif

ifndef _FORCE_LD
LD := ld
else
LD := ${_FORCE_LD}
endif

ifndef _FORCE_AR
AR := ar
else
AR := ${_FORCE_AR}
endif

ifdef TARGET_OS
ifndef _FORCE_AR
AR := ${TARGET_OS}-ar
endif
ifndef _FORCE_LD
LD := ${TARGET_OS}-ld
endif
ifndef _FORCE_STRIP
STRIP := ${TARGET_OS}-strip
endif
endif

AR_INS_R := -rs
AR_EXTR := -x
AR_OUT = $@
