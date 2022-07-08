
all2:	dummy2

dummy2:
	@echo ${ORIGINAL_SHELL}
	@echo Secondary
	@echo ${PARALLEL}

.PHONY:	all2 dummy2
