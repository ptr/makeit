# -*- Makefile-gmake -*-
#
# Copyright (c) 2006-2008, 2022
# Petr Ovtchenkov
#
# Licensed under the Academic Free License version 3.0
#

ifeq ($(origin NOPARALLEL),undefined) # 3
ifeq ($(origin PARALLEL),undefined) # 2
PARALLEL := -j$(shell echo $$((`nproc` + 2))) PARALLEL=
endif # 2
endif # 3

# Do the same target in all catalogs specified in arg
define doinsubdirs
$(foreach d,$(1),${MAKE} -C ${d} ${PARALLEL} $(2) $@;)
endef

# Do specified target (first arg) in all catalogs specified by second arg
define dotaginsubdirs
$(foreach d,$(2),${MAKE} -C ${d} ${PARALLEL} $(3) $(1);)
endef
