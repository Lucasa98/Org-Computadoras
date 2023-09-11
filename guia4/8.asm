.data
cadena: .asciz "ORGANIZACION DE LAS COMPUTADORAS CON RISC V"
#.align 2
cant: .byte -1
#.align 2
caract: .ascii "A"
#.align 2
reemp: .ascii "x"

.text
	la a0, cadena
	lb t1, caract
	lb t2, reemp
	ori a1, zero, 0		# contador c=0
ini:	lb t0, 0(a0)		# carga la letra en t0
	bne t0, t1, distin	# if t0!=caract -> distin
	addi a1, a1, 1		# else{ c++
	sb t2, 0(a0)		# }	<============================= Ej 8
distin:	beq t0, zero, fin	# t0==0	-> fin
	addi a0, a0, 1		# incremento solamente 1 byte t0++
	j ini
fin:	sw a1, cant, t6		# guardo la cantidad contada
	la a0, cadena		# aca no se que hace
	li a7, 4		# -
	ecall			# -
	ori a7, zero, 10	# -
	ecall			# -