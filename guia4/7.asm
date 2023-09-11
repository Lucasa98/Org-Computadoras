.data
cadena: .asciz "ORGANIZACION DE LAS COMPUTADORAS CON RISC V"
#.align 2
cant: .byte -1
#.align 2
caract: .ascii "A"

.text
	la a0, cadena
	lb t1, caract
	ori a1, zero, 0		# contador c=0
ini:	lb t0, 0(a0)		# carga la letra en t0
	bne t0, t1, distin	# if t0!=caract -> distin
	addi a1, a1, 1		# else c++
distin:	beq t0, zero, fin	# t0==0	-> fin
	addi a0, a0, 1		# incremento solamente 1 byte t0++
	j ini
fin:	sw a1, cant, t6		# guardo la cantidad contada
	la a0, cadena		# aca no se que hace
	li a7, 4		# -
	ecall			# -
	ori a7, zero, 10	# -
	ecall			# -

#a)
# En cant se almacena la cantidad de A's contadas

#b)
# El programa cuenta la cantidad de veces que se repite "caract" en "cadena"

#c)
# linea 9: la a0, cadena	[guarda en registro la direccion en memoria del primer caracter de la cadena]
# linea 10: lb t1, caract	[guarda en registro el caracter en "caract"]
# linea 12: lb t0, 0(a0)	[guarda en registro el caracter apuntado por a0]
# linea 18: sw a1, cant, t6	[guardo en la direccion de "cant" el valor del contador a1, pisando toda la PALABRA]

#d)
# La funcion de .align x es alinear el dato subsiguiente en posiciones de
# memoria multiplo de x
# Si quitamos la directiva, los datos cant y caract quedan uno seguido
# del otro, por lo que al almacenar la cantidad pisamos "caract"
# Entiendo que "alinear" memoria significa establecer una cantidad de bytes
# en los que los datos se van a almacenar

#e)
# La cadena de texto esta guardada como un vector de bytes, cada byte
# se lee como un caracter

#f)
# La direccion apuntada por cant es la de la palabra inmediatamente
# siguiente a la cadena, y la caract la de la palabra siguiente a esta ultima
