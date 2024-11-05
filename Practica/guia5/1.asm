.text
	# carga valores en a0, a1, a2
	# a0 = 12
	ori a0, x0, 12
	# a1 = 7
	ori a1, x0, 7
	# a2 = 35
	ori a2, x0, 35
	
	# guarda los valores en el stack
	# para esto repite los siguientes pasos
	# avanzar el stack pointer (sp)
	addi sp, sp, -4
	sw a0, 0(sp)
	sw a1, -4(sp)
	sw a2, -8(sp)
	# es como hacer push en un stack de c++
	
	# modifica los valores originales en los registros
	# a0 = a1 + a2
	add a0, a1, a2
	# ai += 7
	addi a1, a1, 7
	# a2 -= 20
	addi a2, a2, -20
	
	# ahora lee los valores originales guardados en el stack
	# los pasos para esto son
	# leer dato apuntado por el stack pointer
	lw a2, (sp)
	# retroceder el stack pointer
	addi sp, sp, 4
	lw a1, (sp)
	addi sp, sp, 4
	lw a0, (sp)
	addi sp, sp, 4
	
	# return
	addi a7, x0, 10
	ecall