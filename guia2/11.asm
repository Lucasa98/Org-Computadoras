
# metodo rancio
.text
add a1, x0, a0		# x1
add a1, a1, a0		# x2
add a1, a1, a0		# x3
add a1, a1, a0		# x4
add a1, a1, a0		# x5
add a1, a1, a0		# x6
add a1, a1, a0		# x7
add a1, a1, a0		# x8
add a1, a1, a0		# x9
add a1, a1, a0		# x10
add a1, a1, a0		# x11
add a1, a1, a0		# x12
add a1, a1, a0		# x13
add a1, a1, a0		# x14
add a1, a1, a0		# x15
add a1, a1, a0		# x16
add a1, a1, a0		# x17

# metodo piola
slli a1, a0, 4		# desplazar 4 bits a la izquierda = multiplicar por 2^4=16
add a1, a1, a0		# sumar a0, en total a1 = a0*16 + a0 = a0*17

# x24 = x16 + x8
slli a1, a0, 4		# a0*16
slli t0, a0, 3		# a0*8
add a1, a1, t0		# a0*16 + a0*8 = a0*24