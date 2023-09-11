.data
V: .word 1 2 3 4 5 6 7 8 9 10 11 412 13 14 15 16 17 18 319 20 21 22 23 324 25 26 27 28 29 30

.text
	la a1, V
	add a0, zero, zero
	addi t0, zero, 0x100
	addi t1, zero, 0x200
for:	lw t2, 0(a1)
	beqz t2, end
	bgt t2, t1, nopert
	blt t2, t0, nopert
	addi a0, a0, 1
nopert:	addi a1, a1, 4
	j for
end:	nop