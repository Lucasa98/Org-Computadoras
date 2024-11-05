.data
dato1: .word 87
dato2: .word 13
res: .space 4
mod: .space 4
.text
	# carga dato1 y dato2 en t1 y t2
	lw t1, dato1
	lw t2, dato2
	# a0 = 0; a1 = 0
	and a0, zero, zero
	and a1, zero, zero
si:
	# if(t2 == 0) jump(finsi)
	beq t2, zero, finsi
entonce:
	# a0 = t1/t2
	div a0, t1, t2
	# a1 = t1%t2 (resto de t1/t2)
	rem a1, t1, t2
finsi:
	# res = a0
	sw a0, res, t0
	# mod = a1
	sw a1, mod, t0
	nop
	
# El programa lo que hace es almacenar en res y mod el resultado
# de la division de dato1 por dato2, siempre y cuando dato2 no sea cero