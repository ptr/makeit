# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2010, 2016
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

ifndef BUILD_DATE

ifndef TARGET_OS
ifndef OSNAME
OSNAME := $(shell uname -s | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif

ifeq ($(OSNAME),darwin)
ifndef OSREALNAME
OSREALNAME := $(shell sw_vers -productName | tr '[A-Z]' '[a-z]' | tr -d ', /\\()"')
endif
endif

# RedHat use nonstandard options for uname at least in cygwin,
# macro should be overwritten:
ifeq (cygwin,$(findstring cygwin,$(OSNAME)))
OSNAME    := windows
ifndef OSREALNAME
OSREALNAME := $(shell uname -o | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
endif

ifeq (mingw,$(findstring mingw,$(OSNAME)))
OSNAME    := windows
ifndef OSREALNAME
OSREALNAME := mingw
endif
endif

ifndef OSREL
ifneq ($(OSNAME),darwin)
OSREL  := $(shell uname -r | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
else
OSREL  := $(shell sw_vers -productVersion | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
endif

ifndef M_ARCH
M_ARCH := $(shell uname -m | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
ifeq ($(M_ARCH),power-macintosh)
M_ARCH := ppc
endif
endif

ifndef P_ARCH
ifeq ($(OSNAME),hp-ux)
P_ARCH := unknown
else
P_ARCH := $(shell uname -p | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
endif

else
ifneq ($(TARGET_OS),arm-eabi)
ifndef OSNAME
OSNAME := $(shell echo ${TARGET_OS} | sed -e 's/^[a-z0-9_]\+-[a-z0-9]\+-\([a-z]\+\).*/\1/' -e 's/^[a-z0-9_]\+-\([a-z]\+\).*/\1/' )
endif
ifndef OSREL
OSREL  := $(shell echo ${TARGET_OS} | sed -e 's/^[[:alnum:]_]\+-[a-z0-9]\+-[a-z]\+\([a-zA-Z.0-9]*\).*/\1/' -e 's/^[a-z0-9_]\+-[a-z]\+\([a-zA-Z.0-9]*\).*/\1/' )
endif
ifndef M_ARCH
M_ARCH := $(shell echo ${TARGET_OS} | sed 's/^\([a-z0-9_]\+\)-.*/\1/' )
endif
ifndef P_ARCH
P_ARCH := unknown
endif
else
# Assume android NDK 1.5 r1
ifndef OSNAME
OSNAME := android
endif
# don't know, what OS release
# Known at this time:
#   Android 2.1 Release 1
#   Android 1.6 Release 2
#   Android 1.5 Release 3
# Older:
#   Android 2.0.1 Release 1
#   Android 2.0 Release 1
#   Android 1.1
ifndef OSREL
OSREL  :=
endif
ifndef M_ARCH
M_ARCH := arm
endif
ifndef P_ARCH
# ARM v5TE
P_ARCH := ARM_5TE
endif
endif
# TARGET_OS
endif

ifndef NODENAME
NODENAME := $(shell uname -n | tr '[A-Z]' '[a-z]' )
endif
ifndef SYSVER
SYSVER := $(shell uname -v )
endif
ifndef USER
USER := $(shell id -un )
endif

ifeq ($(OSNAME),freebsd)
ifndef OSREL_MAJOR
OSREL_MAJOR := $(shell echo ${OSREL} | tr '.-' ' ' | awk '{print $$1;}')
endif
ifndef OSREL_MINOR
OSREL_MINOR := $(shell echo ${OSREL} | tr '.-' ' ' | awk '{print $$2;}')
endif
endif

ifeq ($(OSNAME),darwin)
ifndef OSREL_MAJOR
OSREL_MAJOR := $(shell echo ${OSREL} | tr '.-' ' ' | awk '{print $$1;}')
endif
ifndef OSREL_MINOR
OSREL_MINOR := $(shell echo ${OSREL} | tr '.-' ' ' | awk '{print $$2;}')
endif
ifndef MACOSX_TEN_FIVE
MACOSX_TEN_FIVE := $(shell if [ ${OSREL_MAJOR} -lt 10 ]; then echo false; else if [ ${OSREL_MAJOR} -gt 10 ] ; then echo true; else if [ ${OSREL_MINOR} -lt 5 ]; then echo false; else echo true; fi; fi; fi)
endif
endif

# OS_VER := $(shell uname -s | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',_')

BUILD_SYSTEM := $(shell { uname -n; uname -s; uname -r; uname -v; uname -m; id -un; } | tr '\n' ' ' )
BUILD_DATE := $(shell date +'%Y/%m/%d %T %Z')

ifndef BUILD_OSNAME
BUILD_OSNAME := $(shell uname -s | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif

# RedHat use nonstandard options for uname at least in cygwin,
# macro should be overwritten:
ifeq (cygwin,$(findstring cygwin,$(BUILD_OSNAME)))
BUILD_OSNAME    := windows
ifndef BUILD_OSREALNAME
BUILD_OSREALNAME := $(shell uname -o | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
endif

ifeq (mingw,$(findstring mingw,$(BUILD_OSNAME)))
BUILD_OSNAME    := windows
ifndef BUILD_OSREALNAME
BUILD_OSREALNAME := mingw
endif
endif

ifndef BUILD_OSREL
BUILD_OSREL  := $(shell uname -r | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
ifndef BUILD_M_ARCH
BUILD_M_ARCH := $(shell uname -m | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
ifeq ($(OSNAME),hp-ux)
ifndef BUILD_P_ARCH
BUILD_P_ARCH := unknown
endif
else
ifndef BUILD_P_ARCH
BUILD_P_ARCH := $(shell uname -p | tr '[A-Z]' '[a-z]' | tr ', /\\()"' ',//////' | tr ',/' ',-')
endif
endif

# end of BUILD_DATE not defined
endif
