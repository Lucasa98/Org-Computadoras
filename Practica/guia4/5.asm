.data
a: .word 9
b: .word 7
c: .word 13

.text
	lw t0, a
	lw t1, b
	lw t2, c
	add s0, zero, t0	# menor=a
	slt t3, t1, s0
	beqz t3, verif2		# if menor<b -> verif2
	add s0, zero, t1	# else menor=b
verif2: slt t3, t2, s0
	beqz t3, end		# if menor<c -> end
	add s0, zero, t2	# else menor=c
end:	la a0, c
	sw s0, 4(a0)		# guardamos el menor
	nop