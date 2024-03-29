# -*- Makefile -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2013, 2016
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

ifdef TARGET_OS
TARGET_NAME := ${TARGET_OS}-
else
TARGET_NAME :=
endif

ifndef BASE_OUTPUT_DIR
BASE_OUTPUT_DIR        := obj
endif

ifndef PRE_OUTPUT_DIR
PRE_OUTPUT_DIR         := $(BASE_OUTPUT_DIR)/$(TARGET_NAME)$(COMPILER_NAME)
endif

ifndef OUTPUT_DIR
OUTPUT_DIR             := $(PRE_OUTPUT_DIR)/so$(EXTRA_DIRS)
endif

ifndef OUTPUT_DIR_DBG
OUTPUT_DIR_DBG         := $(PRE_OUTPUT_DIR)/so_g$(EXTRA_DIRS)
endif

ifndef WITHOUT_STLPORT
OUTPUT_DIR_STLDBG      := $(PRE_OUTPUT_DIR)/so_stlg$(EXTRA_DIRS)
endif

# file to store generated dependencies for make:
DEPENDS_COLLECTION     := $(PRE_OUTPUT_DIR)/.make.depend

# file to store project and dependencies file names

FILES_COLLECTION       := $(PRE_OUTPUT_DIR)/cscope.files

# catalog for auxilary files, if any
AUX_DIR                := $(PRE_OUTPUT_DIR)/.auxdir

# I use the same catalog, as for shared:
OUTPUT_DIR_A           := $(OUTPUT_DIR)
OUTPUT_DIR_A_DBG       := $(OUTPUT_DIR_DBG)
ifndef WITHOUT_STLPORT
OUTPUT_DIR_A_STLDBG    := $(OUTPUT_DIR_STLDBG)
endif

BASE_INSTALL_DIR       ?= /usr/local

BASE_INSTALL_LIB_DIR   ?= ${BASE_INSTALL_DIR}
BASE_INSTALL_BIN_DIR   ?= ${BASE_INSTALL_DIR}
BASE_INSTALL_HDR_DIR   ?= ${BASE_INSTALL_DIR}

INSTALL_LIB_DIR        ?= ${BASE_INSTALL_LIB_DIR}/${TARGET_NAME}lib
INSTALL_LIB_DIR_DBG    ?= ${BASE_INSTALL_LIB_DIR}/${TARGET_NAME}lib
ifndef WITHOUT_STLPORT
INSTALL_LIB_DIR_STLDBG ?= ${BASE_INSTALL_LIB_DIR}/${TARGET_NAME}lib
endif
INSTALL_BIN_DIR        ?= ${BASE_INSTALL_BIN_DIR}/${TARGET_NAME}bin
INSTALL_BIN_DIR_DBG    ?= ${INSTALL_BIN_DIR}_g
ifndef WITHOUT_STLPORT
INSTALL_BIN_DIR_STLDBG ?= ${INSTALL_BIN_DIR}_stlg
endif
INSTALL_HDR_DIR        ?= ${BASE_INSTALL_DIR}/include

ifndef WITHOUT_STLPORT
INSTALL_LIB_DIRS := $(INSTALL_LIB_DIR) $(INSTALL_LIB_DIR_DBG) $(INSTALL_LIB_DIR_STLDBG)
INSTALL_BIN_DIRS := $(INSTALL_BIN_DIR) $(INSTALL_BIN_DIR_DBG) $(INSTALL_BIN_DIR_STLDBG)
else
INSTALL_LIB_DIRS := $(INSTALL_LIB_DIR) $(INSTALL_LIB_DIR_DBG)
INSTALL_BIN_DIRS := $(INSTALL_BIN_DIR) $(INSTALL_BIN_DIR_DBG)
endif

# sort will remove duplicates:
INSTALL_LIB_DIRS := $(sort $(INSTALL_LIB_DIRS))
INSTALL_BIN_DIRS := $(sort $(INSTALL_BIN_DIRS))

define createdirs
@if [ ! -e $@ ]; then \
  mkdir -p $@ ; \
elif [ -e $@ -a -f $@ ] ; then \
  echo "ERROR: Regular file $$d present, directory instead expected" ; \
  exit 1; \
fi
endef

$(AUX_DIR):
	$(createdirs)
