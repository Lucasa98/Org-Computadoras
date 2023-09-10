.data
dato1: .word 87
dato2: .word 13
res: .space 4
mod: .space 4
.text
	lw t1, dato1		# guarda en t1 el valor en dato1
	lw t2, dato2		# guarda en t2 el valor en dato2
	and a0, zero, zero	# guarda 0 en a0
	and a1, zero, zero	# guarda 0 en a0
si:	beq t2, zero, finsi	# if t2==zero -> finsi
entonce:			# else{
	div a0, t1, t2		# a0=t1/t2
	rem a1, t1, t2		# a1=t1%t2 }
finsi:
	sw a0, res, t0		# guarda a0 en res
	sw a1, mod, t0		# guarda a1 en mod
	nop

#a)
# Se esta comparando el denominador (dato2) con x0, para evitar la division
# por 0

#b)
# las direcciones de dato1 y dato2 se puede saber con las instrucciones
la t0, dato1	# 0x10010000
la t1, dato2	# 0x10010004

#c)
# En res y mod se guardan la division entera y el resto (modulo) de 87/13