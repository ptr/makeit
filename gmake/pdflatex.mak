# -*- Makefile -*- Time-stamp: <2011-08-23 14:33:12 ptr>
#
# Copyright (c) 2005-2011
# Petr Ovtchenkov
#
# Licensed under the Academic Free License version 3.0
#

BASE_OUTPUT_DIR := .out
PRE_OUTPUT_DIR := ${BASE_OUTPUT_DIR}
OUTPUT_DIR := ${PRE_OUTPUT_DIR}
OUTPUT_DIR_DBG := ${PRE_OUTPUT_DIR}

PDFLATEXDEPFLAGS = -recorder
PDFLATEXFLAGS = -output-directory=${OUTPUT_DIR}
COMPILE.latex = ${PDFLATEX} ${PDFLATEXFLAGS}

ifndef ALL_TAGS
ALL_TAGS = $(addprefix $(OUTPUT_DIR)/,$(addsuffix .pdf,$(PDFNAMES)))
endif

ALLBASE := $(basename $(notdir $(addsuffix .pdf,$(PDFNAMES))))
