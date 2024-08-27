.data
dato1: .word 20
dato2: .word 10
res: .space 4
.text
	lw s8, dato1		# carga en s8 el valor de dato1
	lw s9, dato2		# carga en s9 el valor de dato2
	and t0, t0, zero	# guarda 0 en t0
	and t1, t1, zero	# guarda 0 en t1
	bge s8, s9, salto	# if s8>=s9 -> salto
	ori t1, t1, 1		# else t1=1
salto:	or t0, t0, t1		# t0 = t0 || t1, equivalente a t0 = t0 || s8<s9
	sw t0, res, t6		# guarda t0 en la memoria de res
	nop
	nop

#El programa asigna en res el resultado de s8<s9

#b) 1
#c) 0
#d) 0
#e) s8<s9