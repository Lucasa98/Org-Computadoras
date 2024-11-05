.data
V: .word 0 1 2 3 4 5 6 7 8 9
size: .word 10

.text
# /////////////// main ///////////////
	la a0, V
	la a1, size
	
	jal invertir
	
	nop
	# restauramos los valores "destruidos" en la funcion anterior
	la a0, V
	la a1, size
	
	jal invertir_stack
	
	addi a7, zero, 10
	ecall
# /////////////// ---- ///////////////


# /////////////// invertir ///////////////
# Realiza las operaciones sobre el mismo vector
# a0: (referencia) vector
# a1: (referencia) size
invertir:
	# size
	lw t0, (a1)
	
	# a0 sera el "puntero" que recorrera desde el inicio
	# a2 sera el "puntero" que recorrera desde el final
	# a2 = a0 + 4*size - 4 = a0 + 4*(size-1)
	addi t1, zero, 4
	mul t1, t1, t0
	addi a2, t1, -4
	add a2, a2, a0
	
	# contador
	addi t2, zero, 0
	# hasta floor(size/2)
	addi t1, zero, 2
	div t1, t0, t1
	
invertir_ini:
	bge t2, t1, invertir_end
	# cargar en t3 y t4
	lw t3, (a0)
	lw t4, (a2)
	# swap
	sw t3, (a2)
	sw t4, (a0)
	
	# ++t1
	addi t2, t2, 1
	# ++a0
	addi a0, a0, 4
	# --a2
	addi a2, a2, -4
	j invertir_ini
	
invertir_end:
	ret
# /////////////// -------- ///////////////

# /////////////// invertir_stack ///////////////
# Invierte utilizando el stack.
# La estrategia va a ser recorrer una vez el vector guardando en el stack
# luego volver a recorrer el vector leyendo desde el stack.
# a0: (referencia) vector
# a1: (referencia) size
invertir_stack:
	# size
	lw t0, (a1)
	# copia de a0
	add a2, zero, a0
	
	# contador
	addi t1, zero, 0
	
	# guardamos en orden el stack
invertir_stack_for1:
	bge t1, t0, invertir_stack_end1
	# leer la memoria
	lw t2, (a2)
	# escribir en el stack
	addi sp, sp, -4
	sw t2, (sp)
	
	# avanzar
	addi a2, a2, 4
	addi t1, t1, 1
	j invertir_stack_for1
	
invertir_stack_end1:
	
	# leemos en orden pero guardamos invertido en V
	add a2, zero, a0
	# contador
	addi t1, zero, 0
invertir_stack_for2:
	bge t1, t0, invertir_stack_end2
	# leer del stack
	lw t2, (sp)
	addi sp, sp, 4
	# escribir en V
	sw t2, (a2)
	
	# avanzar
	addi a2, a2, 4
	addi t1, t1, 1
	j invertir_stack_for2
	
invertir_stack_end2:
	
	ret
# /////////////// -------------- ///////////////













