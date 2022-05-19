# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2007, 2017, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

DBG_SUFFIX ?= g
STLDBG_SUFFIX ?= stl${DBG_SUFFIX}
LIBPREFIX ?= lib

# Shared libraries:

ifdef LIBNAME
SO_NAME        := ${LIBPREFIX}${LIBNAME}.$(SO)
ifdef MAJOR
SO_NAMEx       := ${SO_NAME}.${MAJOR}
else
SO_NAMEx       := ${SO_NAME}
endif
ifdef MINOR
SO_NAMExx      := ${SO_NAMEx}.${MINOR}
else
SO_NAMExx      := ${SO_NAMEx}
endif
ifdef PATCH
SO_NAMExxx     := ${SO_NAMExx}.${PATCH}
else
SO_NAMExxx     := ${SO_NAMExx}
endif

SO_NAME_OUT    := $(OUTPUT_DIR)/${SO_NAME}
SO_NAME_OUTx   := $(OUTPUT_DIR)/${SO_NAMEx}
SO_NAME_OUTxx  := $(OUTPUT_DIR)/${SO_NAMExx}
SO_NAME_OUTxxx := $(OUTPUT_DIR)/${SO_NAMExxx}

SO_NAME_DBG    := ${LIBPREFIX}${LIBNAME}${DBG_SUFFIX}.$(SO)
ifdef MAJOR
SO_NAME_DBGx   := ${SO_NAME_DBG}.${MAJOR}
else
SO_NAME_DBGx   := ${SO_NAME_DBG}
endif
ifdef MINOR
SO_NAME_DBGxx  := ${SO_NAME_DBGx}.${MINOR}
else
SO_NAME_DBGxx  := ${SO_NAME_DBGx}
endif
ifdef PATCH
SO_NAME_DBGxxx := ${SO_NAME_DBGxx}.${PATCH}
else
SO_NAME_DBGxxx := ${SO_NAME_DBGxx}
endif

SO_NAME_OUT_DBG    := $(OUTPUT_DIR_DBG)/${SO_NAME_DBG}
SO_NAME_OUT_DBGx   := $(OUTPUT_DIR_DBG)/${SO_NAME_DBGx}
SO_NAME_OUT_DBGxx  := $(OUTPUT_DIR_DBG)/${SO_NAME_DBGxx}
SO_NAME_OUT_DBGxxx := $(OUTPUT_DIR_DBG)/${SO_NAME_DBGxxx}

ifndef WITHOUT_STLPORT
SO_NAME_STLDBG    := ${LIBPREFIX}${LIBNAME}${STLDBG_SUFFIX}.$(SO)
SO_NAME_STLDBGx   := ${SO_NAME_STLDBG}.${MAJOR}
SO_NAME_STLDBGxx  := ${SO_NAME_STLDBGx}.${MINOR}
SO_NAME_STLDBGxxx := ${SO_NAME_STLDBGxx}.${PATCH}

SO_NAME_OUT_STLDBG    := $(OUTPUT_DIR_STLDBG)/${SO_NAME_STLDBG}
SO_NAME_OUT_STLDBGx   := $(OUTPUT_DIR_STLDBG)/${SO_NAME_STLDBGx}
SO_NAME_OUT_STLDBGxx  := $(OUTPUT_DIR_STLDBG)/${SO_NAME_STLDBGxx}
SO_NAME_OUT_STLDBGxxx := $(OUTPUT_DIR_STLDBG)/${SO_NAME_STLDBGxxx}
# WITHOUT_STLPORT
endif
endif

ALLLIBS = ${SO_NAME_OUTxxx}
ALLLIBS_DBG = ${SO_NAME_OUT_DBGxxx}
ALLLIBS_STLDBG = ${SO_NAME_OUT_STLDBGxxx}

# Static libraries:

ifdef LIBNAME
A_NAME := ${LIBPREFIX}${LIBNAME}.$(ARCH)
A_NAME_OUT := $(OUTPUT_DIR_A)/$(A_NAME)

A_NAME_DBG := ${LIBPREFIX}${LIBNAME}${DBG_SUFFIX}.$(ARCH)
A_NAME_OUT_DBG := $(OUTPUT_DIR_A_DBG)/$(A_NAME_DBG)

ifndef WITHOUT_STLPORT
A_NAME_STLDBG := ${LIBPREFIX}${LIBNAME}${STLDBG_SUFFIX}.$(ARCH)
A_NAME_OUT_STLDBG := $(OUTPUT_DIR_A_STLDBG)/$(A_NAME_STLDBG)
endif
endif

ALLSTLIBS = ${A_NAME_OUT}
ALLSTLIBS_DBG = ${A_NAME_OUT_DBG}
ALLSTLIBS_STLDBG = ${A_NAME_OUT_STLDBG}

define lib_lib
$(1)_SO_NAME        := ${LIBPREFIX}$(1).$(SO)
ifdef $(1)_MAJOR
$(1)_SO_NAMEx       := $${$(1)_SO_NAME}.$${$(1)_MAJOR}
else
$(1)_SO_NAMEx       := $${$(1)_SO_NAME}
endif
ifdef $(1)_MINOR
$(1)_SO_NAMExx      := $${$(1)_SO_NAMEx}.$${$(1)_MINOR}
else
$(1)_SO_NAMExx      := $${$(1)_SO_NAMEx}
endif
ifdef $(1)_PATCH
$(1)_SO_NAMExxx     := $${$(1)_SO_NAMExx}.$${$(1)_PATCH}
else
$(1)_SO_NAMExxx     := $${$(1)_SO_NAMExx}
endif

$(1)_SO_NAME_OUT    := $(OUTPUT_DIR)/$${$(1)_SO_NAME}
$(1)_SO_NAME_OUTx   := $(OUTPUT_DIR)/$${$(1)_SO_NAMEx}
$(1)_SO_NAME_OUTxx  := $(OUTPUT_DIR)/$${$(1)_SO_NAMExx}
$(1)_SO_NAME_OUTxxx := $(OUTPUT_DIR)/$${$(1)_SO_NAMExxx}

$(1)_SO_NAME_DBG    := ${LIBPREFIX}$(1)${DBG_SUFFIX}.$(SO)
ifdef $(1)_MAJOR
$(1)_SO_NAME_DBGx   := $${$(1)_SO_NAME_DBG}.$${$(1)_MAJOR}
else
$(1)_SO_NAME_DBGx   := $${$(1)_SO_NAME_DBG}}
endif
ifdef $(1)_MINOR
$(1)_SO_NAME_DBGxx  := $${$(1)_SO_NAME_DBGx}.$${$(1)_MINOR}
else
$(1)_SO_NAME_DBGxx  := $${$(1)_SO_NAME_DBGx}}
endif
ifdef $(1)_PATCH
$(1)_SO_NAME_DBGxxx := $${$(1)_SO_NAME_DBGxx}.$${$(1)_PATCH}
else
$(1)_SO_NAME_DBGxxx := $${$(1)_SO_NAME_DBGxx}}
endif

$(1)_SO_NAME_OUT_DBG    := $(OUTPUT_DIR_DBG)/$${$(1)_SO_NAME_DBG}
$(1)_SO_NAME_OUT_DBGx   := $(OUTPUT_DIR_DBG)/$${$(1)_SO_NAME_DBGx}
$(1)_SO_NAME_OUT_DBGxx  := $(OUTPUT_DIR_DBG)/$${$(1)_SO_NAME_DBGxx}
$(1)_SO_NAME_OUT_DBGxxx := $(OUTPUT_DIR_DBG)/$${$(1)_SO_NAME_DBGxxx}

ifndef WITHOUT_STLPORT
$(1)_SO_NAME_STLDBG    := ${LIBPREFIX}$(1)${STLDBG_SUFFIX}.$(SO)
$(1)_SO_NAME_STLDBGx   := $${$(1)_SO_NAME_STLDBG}.$${$(1)_MAJOR}
$(1)_SO_NAME_STLDBGxx  := $${$(1)_SO_NAME_STLDBGx}.$${$(1)_MINOR}
$(1)_SO_NAME_STLDBGxxx := $${$(1)_SO_NAME_STLDBGxx}.$${$(1)_PATCH}

$(1)_SO_NAME_OUT_STLDBG    := $(OUTPUT_DIR_STLDBG)/$${$(1)_SO_NAME_STLDBG}
$(1)_SO_NAME_OUT_STLDBGx   := $(OUTPUT_DIR_STLDBG)/$${$(1)_SO_NAME_STLDBGx}
$(1)_SO_NAME_OUT_STLDBGxx  := $(OUTPUT_DIR_STLDBG)/$${$(1)_SO_NAME_STLDBGxx}
$(1)_SO_NAME_OUT_STLDBGxxx := $(OUTPUT_DIR_STLDBG)/$${$(1)_SO_NAME_STLDBGxxx}
# WITHOUT_STLPORT
endif

ALLLIBS        += $${$(1)_SO_NAME_OUTxxx}
ALLLIBS_DBG    += $${$(1)_SO_NAME_OUT_DBGxxx}
ALLLIBS_STLDBG += $${$(1)_SO_NAME_OUT_STLDBGxxx}

# Static libraries:

$(1)_A_NAME     := ${LIBPREFIX}${1}.$(ARCH)
$(1)_A_NAME_OUT := $(OUTPUT_DIR_A)/$${$(1)_A_NAME}

$(1)_A_NAME_DBG     := ${LIBPREFIX}${1}${DBG_SUFFIX}.$(ARCH)
$(1)_A_NAME_OUT_DBG := $(OUTPUT_DIR_A_DBG)/$${$(1)_A_NAME_DBG}

ifndef WITHOUT_STLPORT
$(1)_A_NAME_STLDBG     := ${LIBPREFIX}${1}${STLDBG_SUFFIX}.$(ARCH)
$(1)_A_NAME_OUT_STLDBG := $(OUTPUT_DIR_A_STLDBG)/$${$(1)_A_NAME_STLDBG}
# WITHOUT_STLPORT
endif

ALLSTLIBS        += $${$(1)_A_NAME_OUT}
ALLSTLIBS_DBG    += $${$(1)_A_NAME_OUT_DBG}
ALLSTLIBS_STLDBG += $${$(1)_A_NAME_OUT_STLDBG}

endef

$(foreach l,$(LIBNAMES),$(eval $(call lib_lib,$(l))))
