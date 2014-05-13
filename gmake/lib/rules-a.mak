# -*- makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

# Static libraries tags

PHONY += release-static dbg-static stldbg-static

release-static: $(EXTRA_PRE) ${A_NAME_OUT} $(EXTRA_POST)

dbg-static:	$(EXTRA_PRE_DBG) ${A_NAME_OUT_DBG} $(EXTRA_POST_DBG)

ifndef WITHOUT_STLPORT
stldbg-static:	$(EXTRA_PRE_STLDBG) ${A_NAME_OUT_STLDBG} $(EXTRA_POST_STLDBG)
endif

# C++

ifneq (${OUTPUT_DIR},${OUTPUT_DIR_A})
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))
else
OBJ_A = $(OBJ)
DEP_A = $(DEP)
endif

ifneq (${OUTPUT_DIR_DBG},${OUTPUT_DIR_A_DBG})
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))
else
OBJ_A_DBG = $(OBJ_DBG)
DEP_A_DBG = $(DEP_DBG)
endif

ifndef WITHOUT_STLPORT
ifneq (${OUTPUT_DIR_STLDBG},${OUTPUT_DIR_A_STLDBG})
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_STLDBG),$(OUTPUT_DIR_A_STLDBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.cc) $$(OUTPUT_OPTION) $$<,OBJ_A_STLDBG)))
$(foreach f,$(SRC_CC) $(SRC_CPP) $(SRC_CXX),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_STLDBG),$(OUTPUT_DIR_A_STLDBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.cc) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_STLDBG)))
else
OBJ_A_STLDBG = $(OBJ_STLDBG)
DEP_A_STLDBG = $(DEP_STLDBG)
endif
endif

# C

ifneq (${OUTPUT_DIR},${OUTPUT_DIR_A})
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))
endif

ifneq (${OUTPUT_DIR_DBG},${OUTPUT_DIR_A_DBG})
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.c) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_C),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.c) $$(CCDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))
endif

# S

ifneq (${OUTPUT_DIR},${OUTPUT_DIR_A})
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))
endif

ifneq (${OUTPUT_DIR_DBG},${OUTPUT_DIR_A_DBG})
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.S) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_S),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.S) $$(SDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))
endif

# spp

ifneq (${OUTPUT_DIR},${OUTPUT_DIR_A})
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ_A)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR),$(OUTPUT_DIR)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A)))
endif

ifneq (${OUTPUT_DIR_DBG},${OUTPUT_DIR_A_DBG})
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.o,$$(COMPILE.spp) $$(OUTPUT_OPTION) $$<,OBJ_A_DBG)))
$(foreach f,$(SRC_SPP),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.d,@$$(COMPILE.spp) $$(SPPDEPFLAGS) $$< $$(DP_OUTPUT_DIR),DEP_A_DBG)))
endif

ifeq ($(OSNAME),windows)
# rc
ifneq (${OUTPUT_DIR},${OUTPUT_DIR_A})
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A),$(OUTPUT_DIR_A)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES)))
endif
ifneq (${OUTPUT_DIR_DBG},${OUTPUT_DIR_A_DBG})
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_DBG),$(OUTPUT_DIR_A_DBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES_DBG)))
endif
ifneq (${OUTPUT_DIR_STLDBG},${OUTPUT_DIR_A_STLDBG})
ifndef WITHOUT_STLPORT
$(foreach f,$(SRC_RC),$(eval $(call derive_rule,$(if $(OUTPUT_DIR_A_STLDBG),$(OUTPUT_DIR_A_STLDBG)/)$(if $(patsubst ./%,%,$(dir $(f))),$(shell echo $(dir $(f)) | md5sum | cut -f1 -d' ')/),$(f),.res,$$(COMPILE.rc) $$(RC_OUTPUT_OPTION) $$<,RES_STLDBG)))
endif
endif
endif


${A_NAME_OUT}:	$(OBJ_A) | ${OUTPUT_DIR_A}
	rm -f $@
	$(AR) $(AR_INS_R) $(AR_OUT) $(OBJ_A)

${A_NAME_OUT_DBG}:	$(OBJ_A_DBG) | ${OUTPUT_DIR_A_DBG}
	rm -f $@
	$(AR) $(AR_INS_R) $(AR_OUT) $(OBJ_A_DBG)

ifndef WITHOUT_STLPORT
${A_NAME_OUT_STLDBG}:	$(OBJ_A_STLDBG) | ${OUTPUT_DIR_A_STLDBG}
	rm -f $@
	$(AR) $(AR_INS_R) $(AR_OUT) $(OBJ_A_STLDBG)
endif
