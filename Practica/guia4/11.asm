.data
V: .word 1 2 3 0 0 6 7 8 9 10 11 12 13 14 0
n: .byte 15
total: .byte 0

.text
	la a1, V		# puntero a V[0]
	lb s1, n		# tamanio de V
	
	add t0, zero, zero	# i=0
	add a0, zero, zero	# c=0
	
for:	bge t0, s1, end		# if i>=tam -> return
	lw t1, 0(a1)		# aux=V[i]
	bnez t1, nocero		# if aux!=0 -> nocero
	addi a0, a0, 1		# else c++
nocero:	addi a1, a1, 4
	addi t0, t0, 1
	j for
end:	sb a0, total, t6