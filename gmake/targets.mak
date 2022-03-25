# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002-2014, 2017, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#


# generator of rules like
#
# obj/gcc/so/test.o:	test.cc | obj/gcc/so
# 	$(COMPILE.cc) $(OUTPUT_OPTION) $<
#
# For source not from current dir (i.e. src/test.cc) generated rule will be like
#
# obj/gcc/so/ebc28af801846844e4024f299405a1c4/test.o:	src/test.cc | obj/gcc/so/ebc28af801846844e4024f299405a1c4
# 	$(COMPILE.cc) $(OUTPUT_OPTION) $<
#
# Each rule will be generated only once (for first target).
# This allow avoid overriding recipes. Reciept is treated as unique
# if make variable with name expressed as MD5 hash of target
# (obj/gcc/so/ebc28af801846844e4024f299405a1c4/test.o),
# was not defined before.
# 
# The hash string is MD5 hash from "src/" (directory of source file)
# The usage is like:
#
# $(call derive_rule,$(OUTPUT_DIR),test.cc,.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<)
#

define out_dir_hash
$(if $(patsubst ./%,%,$(dir $(1))),$(shell echo $(dir $(1)) | md5sum | cut -f1 -d' ')/)
endef

define out_dot_
$(call out_dir_hash,$(1))$(basename $(notdir $(1)))$(2)
endef

define derive_rule
OUTPUT_DIRS += $(1)
$(5) += $(1)$(basename $(notdir $(2)))$(3)

ifndef $(shell echo "$(1)$(basename $(notdir $(2)))$(3)" | md5sum | cut -f1 -d ' ' | tr -d '\n\r')
$(1)$(basename $(notdir $(2)))$(3):	$(2) | $(1); $(4)
endif
$(shell echo "$(1)$(basename $(notdir $(2)))$(3)" | md5sum | cut -f1 -d ' ' | tr -d '\n\r') := 1
endef

define derive_rule_clean
undefine $(shell echo "$(1)$(basename $(notdir $(2)))$(3)" | md5sum | cut -f1 -d ' ' | tr -d '\n\r')
endef
# C++

$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.d,$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.d,$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))

$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))

ifndef WITHOUT_STLPORT
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_STLDBG),$(OUTPUT_DIR_STLDBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_STLDBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_STLDBG),$(OUTPUT_DIR_A_STLDBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_A_STLDBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_STLDBG),$(OUTPUT_DIR_STLDBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_STLDBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_STLDBG),$(OUTPUT_DIR_A_STLDBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_STLDBG)))
endif

# C

$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))

$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))

# S

$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))

$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))

# spp

$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))

$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ_DBG)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_DBG)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))

ifeq ($(OSNAME),windows)
# rc
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES)))
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES_DBG)))
ifndef WITHOUT_STLPORT
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_STLDBG),$(OUTPUT_DIR_STLDBG)/)$(call out_dir_hash,$(f)),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES_STLDBG)))
endif
endif

# If we have no C++ sources, let's use C compiler for linkage instead of C++.
ifeq ("$(sort ${SRC_CC} ${SRC_CPP} ${SRC_CXX})","")
NOT_USE_NOSTDLIB := 1
_C_SOURCES_ONLY := true
endif

# Rules defined in prog_ is similar to set above.
# Indeed it is enough only prog_ (call it with empty argument for
# common rules), but syntax is messy due to escape for dollars

define prog_
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A),$$(OUTPUT_DIR_A)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A),$$(OUTPUT_DIR_A)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A)))

$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A_DBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A_DBG)))

ifndef WITHOUT_STLPORT
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_STLDBG),$$(OUTPUT_DIR_STLDBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_STLDBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_STLDBG),$$(OUTPUT_DIR_A_STLDBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.cc) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A_STLDBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_STLDBG),$$(OUTPUT_DIR_STLDBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_STLDBG)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_STLDBG),$$(OUTPUT_DIR_A_STLDBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.cc) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A_STLDBG)))
endif

# C

$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.c) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A),$$(OUTPUT_DIR_A)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.c) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.c) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A),$$(OUTPUT_DIR_A)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.c) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A)))

$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.c) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.c) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A_DBG)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.c) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))
$$(foreach f,$$($(1)SRC_C),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.c) $$$$(CCDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A_DBG)))

# S

$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.S) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_A_DIR),$$(OUTPUT_A_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.S) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.S) $$$$(SDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A),$$(OUTPUT_DIR_A)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.S) $$$$(SDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A)))

$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.S) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.S) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A_DBG)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.S) $$$$(SDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))
$$(foreach f,$$($(1)SRC_S),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.S) $$$$(SDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A_DBG)))

# spp

$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.spp) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_A_DIR),$$(OUTPUT_A_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.spp) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.spp) $$$$(SPPDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_A_DIR),$$(OUTPUT_A_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.spp) $$$$(SPPDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A)))

$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.spp) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_DBG)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o,$$$$(COMPILE.spp) $$$$(OUTPUT_OPTION) $$$$<,$(1)OBJ_A_DBG)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.spp) $$$$(SPPDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_DBG)))
$$(foreach f,$$($(1)SRC_SPP),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.d,@$$$$(COMPILE.spp) $$$$(SPPDEPFLAGS) $$$$< $$$$(DP_OUTPUT_DIR),$(1)DEP_A_DBG)))

ifeq ($(OSNAME),windows)
# rc
$$(foreach f,$$($(1)SRC_RC),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.res,$$$$(COMPILE.rc) $$$$(RC_OUTPUT_OPTION) $$$$<,$(1)RES)))
$$(foreach f,$$($(1)SRC_RC),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.res,$$$$(COMPILE.rc) $$$$(RC_OUTPUT_OPTION) $$$$<,$(1)RES_DBG)))
ifndef WITHOUT_STLPORT
$$(foreach f,$$($(1)SRC_RC),$$(eval $$(call derive_rule,$$(if $$(OUTPUT_DIR_STLDBG),$$(OUTPUT_DIR_STLDBG)/)$$(call out_dir_hash,$$(f)),$$(f),.res,$$$$(COMPILE.rc) $$$$(RC_OUTPUT_OPTION) $$$$<,$(1)RES_STLDBG)))
endif
endif

ifeq ("$$(sort $${$(1)SRC_CC} $${$(1)SRC_CPP} $${$(1)SRC_CXX})","")
$(1)NOT_USE_NOSTDLIB := 1
_$(1)C_SOURCES_ONLY := true
endif
endef

define prog_clean_
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX) $$($(1)SRC_C) $$($(1)SRC_S) $$($(1)SRC_SPP),$$(eval $$(call derive_rule_clean,$$(if $$(OUTPUT_DIR),$$(OUTPUT_DIR)/)$$(call out_dir_hash,$$(f)),$$(f),.o)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX) $$($(1)SRC_C) $$($(1)SRC_S) $$($(1)SRC_SPP),$$(eval $$(call derive_rule_clean,$$(if $$(OUTPUT_DIR_DBG),$$(OUTPUT_DIR_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX) $$($(1)SRC_C) $$($(1)SRC_S) $$($(1)SRC_SPP),$$(eval $$(call derive_rule_clean,$$(if $$(OUTPUT_DIR_A),$$(OUTPUT_DIR_A)/)$$(call out_dir_hash,$$(f)),$$(f),.o)))
$$(foreach f,$$($(1)SRC_CC) $$($(1)SRC_CPP) $$($(1)SRC_CXX) $$($(1)SRC_C) $$($(1)SRC_S) $$($(1)SRC_SPP),$$(eval $$(call derive_rule_clean,$$(if $$(OUTPUT_DIR_A_DBG),$$(OUTPUT_DIR_A_DBG)/)$$(call out_dir_hash,$$(f)),$$(f),.o)))
endef

# $(eval $(call prog_,))
$(foreach prg,$(PRGNAMES) $(LIBNAMES),$(eval $(call prog_,$(prg)_)))

$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX) $(SRC_C) $(SRC_S) $(SRC_SPP),$(eval $(call derive_rule_clean,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(call out_dir_hash,$(f)),$(f),.o)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX) $(SRC_C) $(SRC_S) $(SRC_SPP),$(eval $(call derive_rule_clean,$(if $(OUTPUT_DIR_DBG),$(OUTPUT_DIR_DBG)/)$(call out_dir_hash,$(f)),$(f),.o)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX) $(SRC_C) $(SRC_S) $(SRC_SPP),$(eval $(call derive_rule_clean,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(call out_dir_hash,$(f)),$(f),.o)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX) $(SRC_C) $(SRC_S) $(SRC_SPP),$(eval $(call derive_rule_clean,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(call out_dir_hash,$(f)),$(f),.o)))
$(foreach prg,$(PRGNAMES) $(LIBNAMES),$(eval $(call prog_clean_,$(prg)_)))

define pdf_
OUTPUT_DIRS += ${OUTPUT_DIR}

${OUTPUT_DIR}/$(basename $(notdir $(firstword $($(1)_SRC_TEX)))).pdf:       $($(1)_SRC_TEX) $($(1)_MPS) $($(1)_EXTRA) | ${OUTPUT_DIR}
	${COMPILE.latex} $$<
	if grep -q "^LaTeX Warning: There were undefined references." ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then \
	  biber --output_directory ${OUTPUT_DIR} $$(notdir $$(basename $$<)).bcf; \
	  ${COMPILE.latex} $$<; \
	fi
	if grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then \
	  ${COMPILE.latex} $$<; \
	  if grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then \
	    ${COMPILE.latex} $$<; \
	  fi \
	fi
endef

$(foreach pdf,$(PDFNAMES),$(eval $(call pdf_,$(pdf))))

define pdfdep_
$(1)_DEP += ${OUTPUT_DIR}/$(1).d

${OUTPUT_DIR}/$(1).d:       $($(1)_SRC_TEX) $($(1)_MPS) $($(1)_EXTRA) | ${OUTPUT_DIR}
	${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$<
	if grep -q "^LaTeX Warning: There were undefined references." ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then \
	  biber --output_directory ${OUTPUT_DIR} $$(notdir $$(basename $$<)).bcf; \
	  ${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$<; \
	fi
	if grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then \
	  ${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$<; \
	  if grep -q "^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right." ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then \
	    ${COMPILE.latex} $(PDFLATEXDEPFLAGS) $$<; \
	  fi \
	fi
	BCF=${OUTPUT_DIR}/$$(notdir $$(basename $$<)).bcf; \
	if [ -e $$$$BCF ]; then \
	  SCR='$$$$ a\'; \
	  SCR2=" $$$$BCF\\n\\n$$$$BCF:\\t$$$$(grep bcf:datasource $$$$BCF | sed -e 's|</.*>||' -e 's| *<.*>|  |')\\n\\tbiber --output_directory ${OUTPUT_DIR} $$(notdir $$(basename $$<)).bcf\\n\\t$${COMPILE.latex} $$<\\n\\tif grep -q \"^LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right.\" ${OUTPUT_DIR}/$$(notdir $$(basename $$<)).log; then $${COMPILE.latex} $$<; fi"; \
	else \
	  SCR='$$$$ s/ \\$$$$//'; \
	  SCR2=;\
	fi; \
	f=$(basename $(notdir $(firstword $($(1)_SRC_TEX)))).fls; \
	if [ -e $$$$f ] ; then \
	  sort -u $$$$f; \
	  rm -f $$$$f; \
	elif [ -e ${OUTPUT_DIR}/$$$$f ] ; then \
	  sort -u ${OUTPUT_DIR}/$$$$f; \
	else \
	  false; \
	fi | \
	sed -e '1 i ${OUTPUT_DIR}/$(basename $(notdir $(firstword $($(1)_SRC_TEX)))).pdf ${OUTPUT_DIR}/$(1).d:	  \\' -e '/^OUTPUT/ d' -e '/^PWD/ d' -e '/^INPUT.*\.aux$$$$/ d' -e '$$$$ s/^INPUT//' -e '$$$$! s/^INPUT//;s/$$$$/ \\/' | sed -e "$$$$SCR" -e "$$$$SCR2" > $$@
endef

$(foreach pdf,$(PDFNAMES),$(eval $(call pdfdep_,$(pdf))))
