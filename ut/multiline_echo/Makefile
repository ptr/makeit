# -*- Makefile -*-

RULESBASE := ../..

# identify OS and build date
include ${RULESBASE}/gmake/sysid.mak
# OS-specific definitions, like ln, install, etc. (guest host)
include ${RULESBASE}/gmake/$(BUILD_OSNAME)/sys.mak

define my_config
line_one=yes
line_two=yes
endef

check:
	$(call multiline_echo,${my_config}) > my_config
	cmp my_config ref_config && rm my_config

.PHONY:	check