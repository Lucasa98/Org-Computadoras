.data
val1: .word 10
val2: .word 33

.text
	# cargar direcciones de valores a intercambiar
	la a0, val1
	la a1, val2
	
	jal intercambiar
	
	addi a7, zero, 10
	ecall

# intercambio(a0, a1)
# a0: registro con direccion del valor a
# a1: registro con direccion del valor b
intercambiar:
	# lectura de valores
	lw t0, 0(a0)
	lw t1, 0(a1)
	
	# escritura de valores intercambiados
	sw t0, 0(a1)
	sw t1, 0(a0)
	
	ret