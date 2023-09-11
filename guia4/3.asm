.data
V: .space 60
A: .space 60

.text
	addi t3, zero, 60
	la a0, V		# puntero a V
	la a1, A		# puntero a A
	
	add t0, zero, zero	# contador
for:	add t4, a0, t0		# *V[i]
	lw t2, (t4)		# t2 = V[i]
	add t4, a1, t0		# *A[i]
	sw t2, (t4)		# A[i] = t2
	addi t0, t0, 4		# i++
	blt t0, t3, for
end:	nop
	