.text
	lui t0, 0x12345
	sw t0, (sp)
	lui a1, 0x10010
	lw t1, (sp)
	sw t1, (a1)
	li a7, 10
	ecall