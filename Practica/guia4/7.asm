.data
cadena: .asciz "ORGANIZACION DE LAS COMPUTADORAS EN RISC V"
.align 2
cant: .byte -1
.align 2
caract: .ascii "A"

.text
	# direccion de memoria de la cadena
	# a0 = *cadena
	la a0, cadena
	# direccion de memoria del caracter "A"
	# t1 = caract
	lb t1, caract
	# a1 = 0
	ori a1, zero, 0	# contador
ini:
	# t0 = *a0
	lb t0, 0(a0)
	# if(t0 != t1) jump(distin)
	bne t0, t1, distin
	# else ++a1
	addi a1, a1, 1
distin:
	# la unica forma de saber que termino la cadena es ver si
	# el siguiente byte es 0
	# if(t0==0) jump(fin)
	beq t0, zero, fin
	# else ++a0
	addi a0, a0, 1	# incremento solamente 1 byte
	j ini
fin:
	# cant = a1
	sw a1, cant, t6
	# a0 = *cadena
	la a0, cadena
	# a7 = 4
	li a7, 4
	ecall
	# a7 = 10
	ori a7, zero, 10
	ecall
	
# El programa cuenta la cantidad de apariciones
# de apariciones de 'caract' en 'cadena'