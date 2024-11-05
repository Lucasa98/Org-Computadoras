.data
# guarda 20 (decimal) en data segment
dato1: .word 20
# guarda -40 en data segment
dato2: .word -40
# reserva 4 bytes (una palabra) en data segment
res: .space 4

.text
	# cargar dato1 (valor) en s8
	lw s8, dato1
	# cargar dato2 (valor) en s9
	lw s9, dato2
	# t0 = 0
	and t0, t0, zero
	# t1 = 0
	and t1, t1, zero
	# if(s8 >= s9) jump(salto)
	bge s8, s9, salto
	# t1 = 1
	ori t1, t1, 1
salto:
	# t0 = t1
	or t0, t0, t1
	# almacenar t0 en res
	sw t0, res, t6
	# nada
	nop
	# nada
	nop
	
# Lo que hace el programa, de una forma rebuscada, es indicar si dato1 < dato2,
# almacenando el resultado (0 o 1) en res. Es decir:
# res = dato1 >= dato2;
