.data
cadena1: .ascii "hola que tal todo"
.align 2
cadena2: .ascii "aca andamos todo piola"
.align 2

.text
	# tamanio cadena1
	la a0, cadena1
	# a1 = cadena1.size
	jal size
	# guardamos en un registro aparte el size1
	add s0, zero, a1
	
	# tamanio cadena2
	la a0, cadena2
	# a1 = cadena2.size
	jal size
	
	addi s1, zero, 2
	# if(size1 < size2) {s1 = 2}
	blt s0, a1, menor_cadena2
	# else {s1 = 1}
	addi s1, zero, 1
	
menor_cadena2:
	addi a7, zero, 10
	ecall
	
	

# Funcion size
# a0: (referencia) cadena
# return a1: numero de caracteres de la cadena
size:
	# contador de caracteres
	addi a1, zero, 0
	# valor del caracter
	lb t1, (a0)
	
size_ini:
	beq t1, zero, size_end
	
	# ++size
	addi a1, a1, 1
	
	# ++a0
	addi a0, a0, 2
	# proximo caracter
	lb t1, (a0)
	j size_ini
	
size_end:
	ret