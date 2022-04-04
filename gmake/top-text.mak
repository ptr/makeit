# -*- makefile-gmake -*-
#
# Copyright (c) 2007-2014, 2022
# Petr Ovtchenkov
#
# Licensed under the Academic Free License version 3.0
#

.SUFFIXES:
.SCCS_GET:
.RCS_GET:

SHELL := /bin/bash

PHONY ?= all

RULESBASE := $(dir $(lastword ${MAKEFILE_LIST}))

# include file, generated by configure, if available
-include ${RULESBASE}/config.mak

ifndef PDFLATEX
# pdflatex is default text processor, others specify explicitly;
PDFLATEX := pdflatex
endif

all:
	${MAKE} ${PARALLEL} ${ALL_TAGS}

ifndef OSNAME
# identify OS and build date
include ${RULESBASE}/sysid.mak
endif
# OS-specific definitions, like ln, install, etc. (guest host)
include ${RULESBASE}/$(BUILD_OSNAME)/sys.mak
# target OS-specific definitions, like ar, etc.
include ${RULESBASE}/$(OSNAME)/targetsys.mak
# Extern projects for everyday usage and settings for ones
include ${RULESBASE}/extern.mak

# text processor, text processor options
include ${RULESBASE}/$(PDFLATEX).mak
# rules to make dirs for targets
include ${RULESBASE}/targetdirs.mak

# os-specific local rules (or other project-specific definitions)
-include specific.mak

# derive common targets (*.o, *.d),
# build rules (including output catalogs)
include ${RULESBASE}/targets.mak
# dependency
include ${RULESBASE}/depend.mak

# general clean
#include ${RULESBASE}/clean.mak

# if target is library, rules for library
#ifdef PDFNAMES
#include ${RULESBASE}/lib/top.mak
#endif

.PHONY: $(PHONY)

ifdef DEBUG_RULES
ORIGINAL_SHELL := ${SHELL}
ifeq (${DEBUG_RULES},1)
SHELL = $(warning $@: $? ($^))${ORIGINAL_SHELL}
else
SHELL = $(warning $@: $? ($^))${ORIGINAL_SHELL} -x
endif
endif

OUTPUT_DIRS := $(sort $(OUTPUT_DIRS))

ifneq ($(OUTPUT_DIRS),)
$(OUTPUT_DIRS):
	@mkdir -p $@
endif
