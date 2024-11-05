.data
V: .word 0 1 2 3 4 5 6 7 8 9
size: .word 10
total: .space 4

.text
	# cargar direcciones de memoria para parametros
	la a0, V
	la a1, size
	la a2, total
	
	jal count_even
	
	addi a7, zero, 10
	ecall

# a0: (referencia) vector
# a1: (referencia) dimension
# return a2: (referencia) numero de pares en el vector
count_even:
	# cargar tamanio
	lw t0, (a1)
	# t1 = 2
	addi t1, zero, 2
	
	# contador de pares
	addi t2, zero, 0
	# contador para recorrer vector
	addi t3, zero, 0
	
count_even_ini:
	bge t3, t0, count_even_end
	# cargar valor 
	lw t6, (a0)
	# par?
	rem t4, t6, t1
	# if(t4 != 0) no es par
	bne t4, zero, count_even_nopar
	addi t2, t2, 1
	
count_even_nopar:
	# ++t3
	addi t3, t3, 1
	# ++a0
	addi a0, a0, 4
	j count_even_ini
	
count_even_end:
	sw t2, (a2)
	ret
	
	
	