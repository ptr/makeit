# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2016, 2017
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

SO := so

ARCH := a

ifdef TARGET_OS
_TARGET_PREFIX := ${TARGET_OS}-
endif

ifdef TARGET_CROSS
_TARGET_PREFIX := ${TARGET_CROSS}-
endif

ifndef _FORCE_STRIP
STRIP := ${_TARGET_PREFIX}strip
else
STRIP := ${_FORCE_STRIP}
endif

ifndef _FORCE_LD
LD := ${_TARGET_PREFIX}ld
else
LD := ${_FORCE_LD}
endif

ifndef _FORCE_AR
AR := ${_TARGET_PREFIX}ar
else
AR := ${_FORCE_AR}
endif

ifndef _FORCE_NM
NM := ${_TARGET_PREFIX}nm
else
NM := ${_FORCE_NM}
endif

ifndef _FORCE_OBJDUMP
OBJDUMP := ${_TARGET_PREFIX}objdump
else
OBJDUMP := ${_FORCE_OBJDUMP}
endif

ifndef _FORCE_OBJCOPY
OBJCOPY := ${_TARGET_PREFIX}objcopy
else
OBJCOPY := ${_FORCE_OBJCOPY}
endif

ifndef _FORCE_READELF
READELF := ${_TARGET_PREFIX}readelf
else
READELF := ${_FORCE_READELF}
endif

AR_INS_R := -rs
AR_EXTR := -x
AR_OUT = $@

undefine _TARGET_PREFIX
