.data
V: .word 100 101 102 103 4 5 6 700 8 9 10 11 12 13 414 15 16 17 18 19
size: .word 20
result1: .space 4
result2: .space 4

.text
# ///////////////////// main /////////////////////
	# cargar direcciones
	la a0, V
	la a1, size
	
	# llamada a menor
	jal menor
	
	# guardar menor
	sw a2, result1, t6
	
	# restaurar direcciones
	la a0, V
	la a1, size
	
	# llamar a mayor
	jal mayor
	
	# gaurdar mayor
	sw a2, result2, t6
	
	addi a7, zero, 10
	ecall
# ///////////////////// ---- /////////////////////


# ///////////////////// menor /////////////////////
# a0: (referencia) vector
# a1: (referencia) size
# return a2: valor del menor
menor:
	# size
	lw t0, (a1)
	
	# valor menor
	lw a2, (a0)
	addi a0, a0, 4
	# contador
	addi t2, zero, 1

menor_ini:
	bge t2, t0, menor_end
	# valor actual
	lw t3 (a0)
	# if(t1 < t3) {continue) 
	blt a2, t3, menor_nomenor
	# else {t1 = t3}
	add a2, zero, t3
	
menor_nomenor:
	# avanzar
	addi t2, t2, 1
	addi a0, a0, 4
	j menor_ini
	
menor_end:
	
	ret
# ///////////////////// ----- /////////////////////

# ///////////////////// mayor /////////////////////
# a0: (referencia) vector
# a1: (referencia) size
# return a2: valor del mayor
mayor:
	# size
	lw t0, (a1)
	
	# valor mayor
	lw a2, (a0)
	addi a0, a0, 4
	# contador
	addi t2, zero, 1

mayor_ini:
	bge t2, t0, menor_end
	# valor actual
	lw t3 (a0)
	# if(t3 < a2) {continue)
	blt t3, a2, mayor_nomayor
	# else {a2 = t3}
	add a2, zero, t3
	
mayor_nomayor:
	# avanzar
	addi t2, t2, 1
	addi a0, a0, 4
	j mayor_ini
	
mayor_end:
	
	ret
# ///////////////////// ----- /////////////////////














