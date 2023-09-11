.data
data1: .word 3
data2: .word 61
.text
# multiplicar data1 por data2
	lw t1, data1
	lw t2, data2

# Con ciclos
	addi a0, zero, 0
	addi t0, zero, 0	# contador c=0
while:	blt t0, t2, do		# if c<data2 -> do
	j end			# else return
do:	add a0, a0, t1		#do: a0+=t1
	addi t0, t0, 1		#    c++
	j while
end:	nop

# Con desplazamientos
	slli a0, t1, 6		# a0 = t1*64
	sub a0, a0, t1		# a0 -= t1
	sub a0, a0, t1		# a0 -= t1
	sub a0, a0, t1		# a0 -= t1
	