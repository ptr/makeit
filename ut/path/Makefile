# -*- Makefile-gmake -*-

include ../../gmake/top.mak

.PHONY:	check real-check should-fail

M1=$(shell my_echo)

M2=$(shell PATH=${PATH} my_echo)

check:
	${MAKE} PATH=$(CURDIR):${PATH} real-check

should-fail:
	${MAKE} real-check

real-check:
	my_echo
	@echo A: ${M2}
	@echo B: ${M1}
