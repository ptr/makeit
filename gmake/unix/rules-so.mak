# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2014, 2017-2018, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

# Shared libraries tags

PHONY += release-shared dbg-shared stldbg-shared

release-shared:	$(EXTRA_PRE) ${ALLLIBS} $(EXTRA_POST)

ifdef EXTRA_PRE
ifdef ALLLIBS
${ALLLIBS}:	$(EXTRA_PRE)
endif
endif

ifdef EXTRA_POST
$(EXTRA_POST):	$(EXTRA_PRE) ${ALLLIBS}
endif

dbg-shared:	$(EXTRA_PRE_DBG) ${ALLLIBS_DBG} $(EXTRA_POST_DBG)

ifdef EXTRA_PRE_DBG
ifdef ALLLIBS_DBG
${ALLLIBS_DBG}:	$(EXTRA_PRE_DBG)
endif
endif

ifdef EXTRA_POST_DBG
$(EXTRA_POST_DBG):	$(EXTRA_PRE_DBG) ${ALLLIBS_DBG}
endif

ifndef WITHOUT_STLPORT
stldbg-shared:	$(EXTRA_PRE_STLDBG) ${ALLLIBS_STLDBG} $(EXTRA_POST_STLDBG)
endif

define do_so_links_1
if [ -h $(1)/$(2) ]; then \
  if [ `readlink $(1)/$(2)` != "$(3)" ]; then \
    rm $(1)/$(2); \
    ln -s $(3) $(1)/$(2); \
  fi; \
else \
  ln -s $(3) $(1)/$(2); \
fi;
endef

# Workaround for GNU make 3.80: it fail on 'eval' within 'if'
# directive after some level of complexity, i.e. after complex
# rules it fails on code:
#
# $(eval $(call do_so_links,cc,))
# $(eval $(call do_so_links,cc,_DBG))
# ifndef WITHOUT_STLPORT
# $(eval $(call do_so_links,cc,_STLDBG))
# endif
#
# Put 'if' logic into defined macro looks as workaround.
#
# The GNU make 3.81 free from this problem, but it new...

define do_so_links
OUTPUT_DIRS += $$(OUTPUT_DIR$(1))

$${SO_NAME_OUT$(1)xxx}:	$$(OBJ$(1)) $${START_OBJ$(1)} $${END_OBJ$(1)} $$(LIBSDEP$(1)) | $$(OUTPUT_DIR$(1))
ifeq ("${_C_SOURCES_ONLY}","")
	$$(LINK.cc) $(call so_name,$${SO_NAME$(1)xx}) $$(LINK_OUTPUT_OPTION) $${START_OBJ$(1)} $$(OBJ$(1)) $$(LDLIBS$(1)) $${STDLIBS} $${END_OBJ$(1)}
else
	$$(LINK.c) $(call so_name,$${SO_NAME$(1)xx}) $$(LINK_OUTPUT_OPTION) $${START_OBJ$(1)} $$(OBJ$(1)) $$(LDLIBS$(1)) $${STDLIBS} $${END_OBJ$(1)}
endif
ifneq ($${SO_NAME$(1)xx},$${SO_NAME$(1)xxx})
	@$(call do_so_links_1,$$(OUTPUT_DIR$(1)),$${SO_NAME$(1)xx},$${SO_NAME$(1)xxx})
endif
ifneq ($${SO_NAME$(1)x},$${SO_NAME$(1)xx})
	@$(call do_so_links_1,$$(OUTPUT_DIR$(1)),$${SO_NAME$(1)x},$${SO_NAME$(1)xx})
endif
ifneq ($${SO_NAME$(1)},$${SO_NAME$(1)x})
	@$(call do_so_links_1,$$(OUTPUT_DIR$(1)),$${SO_NAME$(1)},$${SO_NAME$(1)x})
endif

$${SO_NAME_OUT$(1)xxx}:	OPT += $${OPT_LEVEL$(1)}
ifeq ($(1),)
$${SO_NAME_OUT$(1)xxx}:	LDFLAGS += -shared $${NOSTDLIB} -Wl,-S
endif
ifeq ($(1),_DBG)
$${SO_NAME_OUT$(1)xxx}:	OPT += -ggdb
$${SO_NAME_OUT$(1)xxx}:	LDFLAGS += -shared $${NOSTDLIB}
endif
endef

define do_so_links_m
OUTPUT_DIRS += $$(OUTPUT_DIR$(1))

$${$(2)_SO_NAME_OUT$(1)xxx}:	$$($(2)_OBJ$(1)) $${$(2)_START_OBJ$(1)} $${$(2)_END_OBJ$(1)} $$(LIBSDEP$(1)) | $$(OUTPUT_DIR$(1))
ifeq ("$${_$(2)_C_SOURCES_ONLY}","")
	$$(LINK.cc) $(call so_name,$${$(2)_SO_NAME$(1)xx}) $$(LINK_OUTPUT_OPTION) $${$(2)_START_OBJ$(1)} $$($(2)_OBJ$(1)) $$($(2)_LDLIBS$(1)) $${STDLIBS} $${$(2)_END_OBJ$(1)}
else
	$$(LINK.c) $(call so_name,$${$(2)_SO_NAME$(1)xx}) $$(LINK_OUTPUT_OPTION) $${$(2)_START_OBJ$(1)} $$($(2)_OBJ$(1)) $$($(2)_LDLIBS$(1)) $${STDLIBS} $${$(2)_END_OBJ$(1)}
endif
ifneq ($${$(2)_SO_NAME$(1)xx},$${$(2)_SO_NAME$(1)xxx})
	@$(call do_so_links_1,$$(OUTPUT_DIR$(1)),$${$(2)_SO_NAME$(1)xx},$${$(2)_SO_NAME$(1)xxx})
endif
ifneq ($${$(2)_SO_NAME$(1)x},$${$(2)_SO_NAME$(1)xx})
	@$(call do_so_links_1,$$(OUTPUT_DIR$(1)),$${$(2)_SO_NAME$(1)x},$${$(2)_SO_NAME$(1)xx})
endif
ifneq ($${$(2)_SO_NAME$(1)},$${$(2)_SO_NAME$(1)x})
	@$(call do_so_links_1,$$(OUTPUT_DIR$(1)),$${$(2)_SO_NAME$(1)},$${$(2)_SO_NAME$(1)x})
endif

$${$(2)_SO_NAME_OUT$(1)xxx}:	OPT += $${OPT_LEVEL$(1)}
ifeq ($(1),)
$${$(2)_SO_NAME_OUT$(1)xxx}:	LDFLAGS += -shared $${NOSTDLIB} -Wl,-S
endif
ifeq ($(1),_DBG)
$${$(2)_SO_NAME_OUT$(1)xxx}:	OPT += -ggdb
$${$(2)_SO_NAME_OUT$(1)xxx}:	LDFLAGS += -shared $${NOSTDLIB}
endif
endef

define do_so_links_wk
# expand to nothing, if WITHOUT_STLPORT
ifndef WITHOUT_STLPORT
$(call do_so_links,$(1))
$(foreach l,$(LIBNAMES),$(eval $(call do_so_links_m,$(1),$(l))))
endif
endef

$(eval $(call do_so_links,))
$(foreach l,$(LIBNAMES),$(eval $(call do_so_links_m,,$(l))))
$(eval $(call do_so_links,_DBG))
$(foreach l,$(LIBNAMES),$(eval $(call do_so_links_m,_DBG,$(l))))
# ifndef WITHOUT_STLPORT
$(eval $(call do_so_links_wk,_STLDBG))
# endif
