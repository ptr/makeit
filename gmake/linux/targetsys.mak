# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2016
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
ifdef TARGET_OS
STRIP := ${TARGET_OS}-strip
else
STRIP := strip
endif
else
STRIP := ${_FORCE_STRIP}
endif

ifndef _FORCE_LD
ifdef TARGET_OS
LD := ${TARGET_OS}-ld
else
LD := ld
endif
else
LD := ${_FORCE_LD}
endif

ifndef _FORCE_AR
ifdef TARGET_OS
AR := ${TARGET_OS}-ar
else
AR := ar
endif
else
AR := ${_FORCE_AR}
endif

ifndef _FORCE_NM
ifdef TARGET_OS
NM := ${TARGET_OS}-nm
else
NM := nm
endif
else
NM := ${_FORCE_NM}
endif

ifndef _FORCE_OBJDUMP
ifdef TARGET_OS
OBJDUMP := ${TARGET_OS}-objdump
else
OBJDUMP := objdump
endif
else
OBJDUMP := ${_FORCE_OBJDUMP}
endif

ifndef _FORCE_OBJCOPY
ifdef TARGET_OS
OBJCOPY := ${TARGET_OS}-objcopy
else
OBJCOPY := objcopy
endif
else
OBJCOPY := ${_FORCE_OBJCOPY}
endif

ifndef _FORCE_READELF
ifdef TARGET_OS
READELF := ${TARGET_OS}-readelf
else
READELF := readelf
endif
else
READELF := ${_FORCE_READELF}
endif

AR_INS_R := -rs
AR_EXTR := -x
AR_OUT = $@
