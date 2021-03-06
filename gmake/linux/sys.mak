# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2016, 2020
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

ifndef INSTALL
INSTALL := $(shell if [ -e /usr/bin/install ]; then echo -n "/usr/bin/install"; else if [ -e /bin/install ]; then echo -n "/bin/install"; fi fi )
endif

install-strip:	_INSTALL_STRIP_OPTION = -s

install-strip:	_SO_STRIP_OPTION = -S

install-strip-shared:	_INSTALL_STRIP_OPTION = -s

install-strip-shared:	_SO_STRIP_OPTION = -S

INSTALL_SO := ${INSTALL} -c -m 0755 ${_INSTALL_STRIP_OPTION}
INSTALL_A := ${INSTALL} -c -m 0644
INSTALL_EXE := ${INSTALL} -c -m 0755
INSTALL_D := ${INSTALL} -d -m 0755
INSTALL_F := ${INSTALL} -c -p -m 0644

# bash's built-in test is like extern
# EXT_TEST := /usr/bin/test
EXT_TEST := test

define _newline


endef

define multiline_echo
echo -e '$(call subst,',\x27,$(call subst,${_newline},\n,${1}))'
endef
