.data
V: .word 10 11 12 13 14 15 16 17 18 19
size: .word 10
avg: .space 4

.text
# /////////////// main ///////////////
	# cargamos direcciones
	la a0, V
	la a1, size
	
	# llamada a funcion
	jal AVG
	sw a2, avg, t6
	
	addi a7, zero, 10
	ecall
# /////////////// ---- ///////////////
	
# /////////////// Funcion AVG ///////////////
# a0: (referencia) vector
# a1: (referencia) size del vector
# return a2: promedio de los elementos del vector
AVG:
	# size
	lw t0, (a1)
	
	# acumulador
	addi t1, zero, 0
	# contador
	addi t2, zero, 0
	
	# sumamos todos los elementos
AVG_ini:
	bge t2, t0, AVG_end
	lw t3, (a0)
	add t1, t1, t3
	
	# avanzar
	addi t2, t2, 1
	addi a0, a0, 4
	j AVG_ini
	
AVG_end:
	# dividimos el total por el numero de elementos
	div a2, t1, t0
	ret
# /////////////// ----------- ///////////////