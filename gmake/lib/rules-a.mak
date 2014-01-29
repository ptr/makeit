# -*- Makefile -*-
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
