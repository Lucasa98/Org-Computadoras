.data
V: .word 0 1 2 3 4 5 6 0 8 9
n: .word 10
total: .space 4

.text
	# a0 = V.begin()
	la a0, V
	# a1 = *total
	la a1, total
	# s0 = n
	lw s0, n
	
	# contador de valores iguales a 0
	addi t0, zero, 0
	# contador del elementos recorridos
	addi t1, zero, 0

ini:	
	bge t1, s0, end
	# t2 = *a0
	lw t2, 0(a0)
	# if(t2 != 0) jump(nocero)
	bne t2, zero, nocero
	# else ++t0
	addi t0, t0, 1
	
nocero:
	# ++a0
	addi a0, a0 ,4
	# ++t1
	addi t1, t1, 1
	j ini
	
end:
	# almacenar t0 en 'total'
	sw t0, 0(a1)
	
	addi a7, zero, 10
	ecall