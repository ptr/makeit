# -*- Makefile -*- Time-stamp: <2013-02-07 05:48:47 ptr>
#
# Copyright (c) 2005-2013
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
#ALL_TAGS = $(addprefix $(OUTPUT_DIR)/,$(addsuffix .pdf,$(PDFNAMES)))
ALL_TAGS = $(foreach pdf,$(PDFNAMES),${OUTPUT_DIR}/$(basename $(notdir $(firstword $($(pdf)_SRC_TEX)))).pdf)
endif

ALLBASE := $(basename $(notdir $(addsuffix .pdf,$(PDFNAMES))))
