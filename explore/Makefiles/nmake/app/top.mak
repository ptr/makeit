# -*- makefile -*- Time-stamp: <03/09/28 18:46:10 ptr>
# $Id$

!ifndef LDFLAGS
LDFLAGS = 
!endif

!include $(RULESBASE)/$(USE_MAKE)/app/macro.mak
!include $(RULESBASE)/$(USE_MAKE)/app/$(COMPILER_NAME).mak
!include $(RULESBASE)/$(USE_MAKE)/app/rules-exe-$(OSNAME).mak

#include ${RULESBASE}/lib/rules-a.mak
#include ${RULESBASE}/lib/rules-install-so-$(OSNAME).mak
#include ${RULESBASE}/lib/rules-install-a.mak
!include $(RULESBASE)/$(USE_MAKE)/app/clean.mak
