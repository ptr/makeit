# -*- Makefile -*- Time-stamp: <03/07/07 12:48:35 ptr>
# $Id$

#include ${BASEDIR}/Makefiles/dparser-$(COMPILER_NAME).mak

# Rules for release output:

$(OUTPUT_DIR)/%.d:	$(WORD1)%.cpp
	@$(COMPILE.cc) $(CCDEPFLAGS) $< $(DP_OUTPUT_DIR)

$(OUTPUT_DIR)/%.d:	$(WORD1)%.cc
	@$(COMPILE.cc) $(CCDEPFLAGS) $< $(DP_OUTPUT_DIR)

$(OUTPUT_DIR)/%.d:	$(WORD1)%.c
	@$(COMPILE.c) $(CDEPFLAGS) $< $(DP_OUTPUT_DIR)

# Rules for debug output:

$(OUTPUT_DIR_DBG)/%.d:	$(WORD1)%.cpp
	@$(COMPILE.cc) $(CCDEPFLAGS) $< $(DP_OUTPUT_DIR_DBG)

$(OUTPUT_DIR_DBG)/%.d:	$(WORD1)%.cc
	@$(COMPILE.cc) $(CCDEPFLAGS) $< $(DP_OUTPUT_DIR_DBG)

$(OUTPUT_DIR_DBG)/%.d:	$(WORD1)%.c
	@$(COMPILE.c) $(CDEPFLAGS) $< $(DP_OUTPUT_DIR_DBG)

# Rules for STLport debug output:

$(OUTPUT_DIR_STLDBG)/%.d:	$(WORD1)%.cpp
	@$(COMPILE.cc) $(CCDEPFLAGS) $< $(DP_OUTPUT_DIR_STLDBG)

$(OUTPUT_DIR_STLDBG)/%.d:	$(WORD1)%.cc
	@$(COMPILE.cc) $(CCDEPFLAGS) $< $(DP_OUTPUT_DIR_STLDBG)

$(OUTPUT_DIR_STLDBG)/%.d:	$(WORD1)%.c
	@$(COMPILE.c) $(CDEPFLAGS) $< $(DP_OUTPUT_DIR_STLDBG)
