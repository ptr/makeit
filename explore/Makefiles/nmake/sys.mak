# Time-stamp: <03/09/28 18:59:23 ptr>
# $Id$

# shared library:
SO  = dll
LIB = lib
EXP = exp
# executable:
EXE = .exe

# static library extention:
ARCH = lib
AR = lib.exe
AR_INS_R = 
AR_EXTR = 
AR_OUT = /o

INSTALL = copy

INSTALL_SO = $(INSTALL)
INSTALL_A = $(INSTALL)
INSTALL_EXE = $(INSTALL)

# compiler, compiler options
!include $(RULESBASE)/$(USE_MAKE)/compiler-$(COMPILER_NAME).mak
