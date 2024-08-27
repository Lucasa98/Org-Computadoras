.data
V: .word 1 2 3 4 5 6 7 8 9 10

.text
	la a0, V		# puntero a V
	addi a1, zero, 40	# tamaño
	addi t0, zero, 0	# contador i=0
for:	add t1, a0, t0		# puntero a V[i]
	lw t2, (t1)		# cargar V[i]
	addi t3, zero, 8
	mul t2, t2, t3		# V[i]*=8
	sw t2, (t1)		# guardar V[i]*8
	addi t0, t0, 4		# ++i
	slt t2, a1, t0		# i < tamaño
	beqz t2, for		# if i<tamaño -> for
end:	nop			# else end
	