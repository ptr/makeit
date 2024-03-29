# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2016, 2017, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

.SUFFIXES:
.SCCS_GET:
.RCS_GET:

PHONY ?=

RULESBASE := $(dir $(lastword ${MAKEFILE_LIST}))

# include file, generated by configure, if available
-include ${RULESBASE}/config.mak
-include .config.mk

ifndef COMPILER_NAME
# gcc is default compiler, others specify explicitly;
COMPILER_NAME := gcc
endif

ifndef LDFLAGS
LDFLAGS :=
endif

ifndef ALL_TAGS

ifndef _NO_SHARED_BUILD
ALL_TAGS := release-shared
else
ALL_TAGS :=
endif

ifdef _STATIC_BUILD
ALL_TAGS += release-static
endif

ifndef _NO_DBG_BUILD
ifndef _NO_SHARED_BUILD
ALL_TAGS += dbg-shared
endif
ifdef _STATIC_BUILD
ALL_TAGS += dbg-static
endif
endif

endif

all:	$(ALL_TAGS)

ifndef OSNAME
# identify OS and build date
include ${RULESBASE}/sysid.mak
else
SHELL := /bin/bash
ifeq ($(origin NOPARALLEL),undefined)
ifeq ($(origin PARALLEL),undefined)
PARALLEL := -j${NPROC} PARALLEL=
else
PARALLEL := PARALLEL=
endif
endif
endif
# OS-specific definitions, like ln, install, etc. (guest host)
include ${RULESBASE}/$(BUILD_OSNAME)/sys.mak
# target OS-specific definitions, like ar, etc.
include ${RULESBASE}/$(OSNAME)/targetsys.mak
# Extern projects for everyday usage and settings for ones
include ${RULESBASE}/extern.mak

ifdef WITHOUT_STLPORT
NOT_USE_NOSTDLIB := 1
endif

ifndef _NO_STLDBG_BUILD
ifndef WITHOUT_STLPORT
ifndef _NO_SHARED_BUILD
ALL_TAGS += stldbg-shared
endif
ifdef _STATIC_BUILD
ALL_TAGS += stldbg-static
endif
endif
endif

ifndef WITHOUT_STLPORT
all-static:	release-static dbg-static stldbg-static
all-shared:	release-shared dbg-shared stldbg-shared
else
all-static:	release-static dbg-static
all-shared:	release-shared dbg-shared
endif

# compiler, compiler options
include ${RULESBASE}/$(COMPILER_NAME).mak

# os-specific local rules (or other project-specific definitions)
-include specific.mak

LDFLAGS += ${EXTRA_LDFLAGS}

# rules to make dirs for targets
include ${RULESBASE}/targetdirs.mak

# derive common targets (*.o, *.d),
# build rules (including output catalogs)
include ${RULESBASE}/targets.mak
# dependency
include ${RULESBASE}/depend.mak

# general clean
include ${RULESBASE}/clean.mak

# if target is library, rules for library
ifdef LIBNAME
include ${RULESBASE}/lib/top.mak
else
ifdef LIBNAMES
include ${RULESBASE}/lib/top.mak
endif
endif

# if target is program, rules for executable
ifdef PRGNAME
include ${RULESBASE}/app/top.mak
else
ifdef PRGNAMES
include ${RULESBASE}/app/top.mak
endif
endif

.PHONY: $(PHONY)

OUTPUT_DIRS := $(sort $(OUTPUT_DIRS))

ifneq ($(OUTPUT_DIRS),)
$(OUTPUT_DIRS):
	@mkdir -p $@
endif

define config_cache
# -*- Makefile -*-
# Generated configuration
# ${BUILD_SYSTEM}
# ${BUILD_DATE}

# sysid
OSNAME := ${OSNAME}
OSREALNAME := ${OSREALNAME}
OSREL := ${OSREL}
M_ARCH := ${M_ARCH}
P_ARCH := ${P_ARCH}
NODENAME := ${NODENAME}
# SYSVER := ${SYSVER}
USER := ${USER}
OSREL_MAJOR := ${OSREL_MAJOR}
OSREL_MINOR := ${OSREL_MINOR}
BUILD_OSNAME := ${BUILD_OSNAME}
BUILD_OSREALNAME := ${BUILD_OSREALNAME}
BUILD_OSREL := ${BUILD_OSREL}
BUILD_M_ARCH := ${BUILD_M_ARCH}
BUILD_P_ARCH := ${BUILD_P_ARCH}
SU := ${SU}

# $(BUILD_OSNAME)/sys.mak

INSTALL := ${INSTALL}

# top.mak

COMPILER_NAME := ${COMPILER_NAME}

# ${COMPILER_NAME}.mak

CXX_VERSION := ${CXX_VERSION}
CXX_VERSION_MAJOR := ${CXX_VERSION_MAJOR}
CXX_VERSION_MINOR := ${CXX_VERSION_MINOR}
CXX_VERSION_PATCH := ${CXX_VERSION_PATCH}

_CXA_ATEXIT := ${_CXA_ATEXIT}

# app/gcc.mak

_LGCC_EH := ${_LGCC_EH}
_LGCC_S := ${_LGCC_S}
_LSUPCPP := ${_LSUPCPP}

NPROC := $(shell echo $$((`nproc` + 2)))
endef

.config.mk:
	@$(call multiline_echo,${config_cache}) > $@


ifndef ORIGINAL_SHELL
export ORIGINAL_SHELL := ${SHELL}
endif

ifdef DEBUG_RULES
ifeq (${DEBUG_RULES},1)
SHELL = $(warning $@: $? ($^))${ORIGINAL_SHELL}
else
SHELL = $(warning $@: $? ($^))${ORIGINAL_SHELL} -x
endif
endif
