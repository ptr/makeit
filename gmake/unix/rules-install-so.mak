# -*- Makefile-gmake -*-
#
# Copyright (c) 1997-1999, 2002, 2003, 2005-2007, 2018, 2022
# Petr Ovtchenkov
#
# Portion Copyright (c) 1999-2001
# Parallel Graphics Ltd.
#
# Licensed under the Academic Free License version 3.0
#

ifndef INSTALL_TAGS

ifndef _NO_SHARED_BUILD
INSTALL_TAGS := install-release-shared
else
INSTALL_TAGS := 
endif

ifdef _STATIC_BUILD
INSTALL_TAGS += install-release-static
endif

ifndef _NO_DBG_BUILD
ifndef _NO_SHARED_BUILD
INSTALL_TAGS += install-dbg-shared
endif
ifdef _STATIC_BUILD
INSTALL_TAGS += install-dbg-static
endif
endif

ifndef _NO_STLDBG_BUILD
ifndef WITHOUT_STLPORT
ifndef _NO_SHARED_BUILD
INSTALL_TAGS += install-stldbg-shared
endif
ifdef _STATIC_BUILD
INSTALL_TAGS += install-stldbg-static
endif
endif
endif

endif


ifndef INSTALL_STRIP_TAGS

ifndef _NO_SHARED_BUILD
INSTALL_STRIP_TAGS := install-strip-shared
else
INSTALL_STRIP_TAGS := 
endif

ifdef _STATIC_BUILD
INSTALL_STRIP_TAGS += install-release-static
endif

ifndef _NO_DBG_BUILD
ifndef _NO_SHARED_BUILD
INSTALL_STRIP_TAGS += install-dbg-shared
endif
ifdef _STATIC_BUILD
INSTALL_STRIP_TAGS += install-dbg-static
endif
endif

ifndef _NO_STLDBG_BUILD
ifndef WITHOUT_STLPORT
ifndef _NO_SHARED_BUILD
INSTALL_STRIP_TAGS += install-stldbg-shared
endif
ifdef _STATIC_BUILD
INSTALL_STRIP_TAGS += install-stldbg-static
endif
endif
endif

endif


PHONY += install install-strip install-headers $(INSTALL_TAGS) $(INSTALL_STRIP_TAGS)

install:	$(INSTALL_TAGS)

install-strip:	$(INSTALL_STRIP_TAGS)

# Workaround for GNU make 3.80; see comments in rules-so.mak
define do_install_so_links
$$(DESTDIR)$${INSTALL_LIB_DIR$(1)}/$${SO_NAME$(1)xxx}:	$${SO_NAME_OUT$(1)xxx} | $$(DESTDIR)$${INSTALL_LIB_DIR$(1)}
	$$(INSTALL_SO) $${SO_NAME_OUT$(1)xxx} $$(DESTDIR)$$(INSTALL_LIB_DIR$(1))
ifneq ($${SO_NAME$(1)xx},$${SO_NAME$(1)xxx})
	@$(call do_so_links_1,$$(DESTDIR)$$(INSTALL_LIB_DIR$(1)),$${SO_NAME$(1)xx},$${SO_NAME$(1)xxx})
endif
ifneq ($${SO_NAME$(1)x},$${SO_NAME$(1)xx})
	@$(call do_so_links_1,$$(DESTDIR)$$(INSTALL_LIB_DIR$(1)),$${SO_NAME$(1)x},$${SO_NAME$(1)xx})
endif
ifneq ($${SO_NAME$(1)},$${SO_NAME$(1)x})
	@$(call do_so_links_1,$$(DESTDIR)$$(INSTALL_LIB_DIR$(1)),$${SO_NAME$(1)},$${SO_NAME$(1)x})
endif
endef

define do_install_so_links_m
ifdef INSTALL_LIB_DIR$(1)
$$(DESTDIR)$${INSTALL_LIB_DIR$(1)}/$${$(2)_SO_NAME$(1)xxx}:	$${$(2)_SO_NAME_OUT$(1)xxx} | $$(DESTDIR)$${INSTALL_LIB_DIR$(1)}
	$$(INSTALL_SO) $${$(2)_SO_NAME_OUT$(1)xxx} $$(DESTDIR)$$(INSTALL_LIB_DIR$(1))
ifneq ($${$(2)_SO_NAME$(1)xx},$${$(2)_SO_NAME$(1)xxx})
	@$(call do_so_links_1,$$(DESTDIR)$$(INSTALL_LIB_DIR$(1)),$${$(2)_SO_NAME$(1)xx},$${$(2)_SO_NAME$(1)xxx})
endif
ifneq ($${$(2)_SO_NAME$(1)x},$${$(2)_SO_NAME$(1)xx})
	@$(call do_so_links_1,$$(DESTDIR)$$(INSTALL_LIB_DIR$(1)),$${$(2)_SO_NAME$(1)x},$${$(2)_SO_NAME$(1)xx})
endif
ifneq ($${$(2)_SO_NAME$(1)},$${$(2)_SO_NAME$(1)x})
	@$(call do_so_links_1,$$(DESTDIR)$$(INSTALL_LIB_DIR$(1)),$${$(2)_SO_NAME$(1)},$${$(2)_SO_NAME$(1)x})
endif
endif
endef

define do_install_so_links_m_wk2
ifneq ($${INSTALL_LIB_DIR$(1)}/$${$(2)_SO_NAME$(1)xxx},$${INSTALL_LIB_DIR}/$${$(2)_SO_NAMExxx})
$(call do_install_so_links_m,$(1),$(2))
else
ifdef _PREFER_DBG_INSTALL
$(call do_install_so_links_m,$(1),$(2))
endif
endif
endef

# Workaround for GNU make 3.80; see comments in rules-so.mak
define do_install_so_links_wk
# expand to nothing, if equal
ifneq (${INSTALL_LIB_DIR}/${SO_NAMExxx},${INSTALL_LIB_DIR_STLDBG}/${SO_NAME_STLDBGxxx})
# expand to nothing, if WITHOUT_STLPORT
ifndef WITHOUT_STLPORT
$(call do_install_so_links,$(1))
endif
else
ifdef _PREFER_DBG_INSTALL
ifndef WITHOUT_STLPORT
$(call do_install_so_links,$(1))
endif
endif
endif
ifndef WITHOUT_STLPORT
$(foreach l,$(LIBNAMES),$(eval $(call do_install_so_links_m_wk2,$(1),$(l))))
endif
endef

# Workaround for GNU make 3.80; see comments in rules-so.mak
define do_install_so_links_wk2
# expand to nothing, if equal
ifneq (${INSTALL_LIB_DIR}/${SO_NAMExxx},${INSTALL_LIB_DIR_DBG}/${SO_NAME_DBGxxx})
$(call do_install_so_links,$(1))
else
ifdef _PREFER_DBG_INSTALL
$(call do_install_so_links,$(1))
endif
endif
$(foreach l,$(LIBNAMES),$(eval $(call do_install_so_links_m_wk2,$(1),$(l))))
endef

ifneq (${INSTALL_LIB_DIR}/${SO_NAMExxx},${INSTALL_LIB_DIR_DBG}/${SO_NAME_DBGxxx})
$(eval $(call do_install_so_links,))
else
ifndef _PREFER_DBG_INSTALL
$(eval $(call do_install_so_links,))
endif
endif
$(foreach l,$(LIBNAMES),$(eval $(call do_install_so_links_m,,$(l))))

# ifneq (${INSTALL_LIB_DIR}/${SO_NAMExxx},${INSTALL_LIB_DIR_DBG}/${SO_NAME_DBGxxx})
# $(eval $(call do_install_so_links,_DBG))
$(eval $(call do_install_so_links_wk2,_DBG))
# endif
# ifneq (${INSTALL_LIB_DIR}/${SO_NAMExxx},${INSTALL_LIB_DIR_STLDBG}/${SO_NAME_STLDBGxxx})
# ifndef WITHOUT_STLPORT
$(eval $(call do_install_so_links_wk,_STLDBG))
# endif
# endif

define install_shared_rules
install-release-shared::	$$(DESTDIR)$$(INSTALL_LIB_DIR)/$${$(1)_SO_NAMExxx}
	$${POST_INSTALL}

install-strip-shared::	$$(DESTDIR)$$(INSTALL_LIB_DIR)/$${$(1)_SO_NAMExxx}
	${STRIP} ${_SO_STRIP_OPTION} $$(DESTDIR)$$(INSTALL_LIB_DIR)/$${$(1)_SO_NAMExxx}
	$${POST_INSTALL}

install-dbg-shared::	$$(DESTDIR)$$(INSTALL_LIB_DIR_DBG)/$${$(1)_SO_NAME_DBGxxx}
	$${POST_INSTALL_DBG}

ifndef WITHOUT_STLPORT
install-stldbg-shared::	$$(DESTDIR)$$(INSTALL_LIB_DIR_STLDBG)/$${$(1)_SO_NAME_STLDBGxxx}
	$${POST_INSTALL_STLDBG}
endif
endef

ifneq (${LIBNAME},)
install-release-shared::	$(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx}
	${POST_INSTALL}

install-strip-shared::	$(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx}
	${STRIP} ${_SO_STRIP_OPTION} $(DESTDIR)$(INSTALL_LIB_DIR)/${SO_NAMExxx}
	${POST_INSTALL}

install-dbg-shared::	$(DESTDIR)$(INSTALL_LIB_DIR_DBG)/${SO_NAME_DBGxxx}
	${POST_INSTALL_DBG}

ifndef WITHOUT_STLPORT
install-stldbg-shared::	$(DESTDIR)$(INSTALL_LIB_DIR_STLDBG)/${SO_NAME_STLDBGxxx}
	${POST_INSTALL_STLDBG}
endif
endif

$(DESTDIR)$(INSTALL_LIB_DIR):
	${INSTALL} -d -m 0755 $@

ifneq ($(INSTALL_LIB_DIR),$(INSTALL_LIB_DIR_DBG))
$(DESTDIR)$(INSTALL_LIB_DIR_DBG):
	${INSTALL} -d -m 0755 $@
endif

ifeq ($(INSTALL_LIB_DIR),$(INSTALL_LIB_DIR_DBG))
install-dbg-shared:	INSTALL_DBG := 1
endif

install-strip:	INSTALL_STRIP = 1

install-strip-shared:	INSTALL_STRIP = 1

$(foreach l,$(LIBNAMES),$(eval $(call install_shared_rules,$(l))))

define do_install_headers
if [ ! -d $(DESTDIR)$(INSTALL_HDR_DIR) ]; then \
  $(INSTALL_D) $(DESTDIR)$(INSTALL_HDR_DIR) || { echo "Can't create $(DESTDIR)$(INSTALL_HDR_DIR)"; exit 1; }; \
fi; \
for dd in $(HEADERS_BASE); do \
  d=`dirname $$dd`; \
  h=`basename $$dd`; \
  f=`cd $$d; find $$h \( -wholename "*/.svn" -prune \) -o \( -type d -print \)`; \
  for ddd in $$f; do \
    if [ ! -d $(DESTDIR)$(INSTALL_HDR_DIR)/$$ddd ]; then \
      $(INSTALL_D) $(DESTDIR)$(INSTALL_HDR_DIR)/$$ddd || { echo "Can't create $(DESTDIR)$(INSTALL_HDR_DIR)/$$ddd"; exit 1; }; \
    fi; \
  done; \
  f=`find $$dd \( -wholename "*/.svn*" -o -name "*~" -o -name "*.bak" \) -prune -o \( -type f -print \)`; \
  for ff in $$f; do \
    h=`echo $$ff | sed -e "s|$$d|$(DESTDIR)$(INSTALL_HDR_DIR)|"`; \
    if [ ! -e $$h ] || ! cmp -s $$ff $$h; then \
      $(INSTALL_F) $$ff $$h; \
    fi \
  done; \
done; \
for f in $(HEADERS); do \
  h=`basename $$f`; \
  if [ ! -e $(DESTDIR)$(INSTALL_HDR_DIR)/$$h ] || ! cmp -s $$f $(DESTDIR)$(INSTALL_HDR_DIR)/$$h; then \
    $(INSTALL_F) $$f $(DESTDIR)$(INSTALL_HDR_DIR)/$$h || { echo "Can't install $(DESTDIR)$(INSTALL_HDR_DIR)/$$h"; exit 1; }; \
  fi \
done
endef

# find $$dd \( -type f \( \! \( -wholename "*/.svn*" -o -name "*~" -o -name "*.bak" \) \) \) -print
# _HEADERS_FROM = $(shell for dd in $(HEADERS_BASE); do find $$dd \( -type f \( \! \( -wholename "*/.svn/*" -o -name "*~" -o -name "*.bak" \) \) \) -print ; done )
# _HEADERS_TO = $(foreach d,$(HEADERS_BASE),$(patsubst $(d)/%,$(BASE_INSTALL_DIR)include/%,$(_HEADERS_FROM)))

install-headers:
	@$(do_install_headers)
