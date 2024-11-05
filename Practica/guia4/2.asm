.data
val: 10
mult: 61

.text
	# s0 = *val
	lw s0, val
	# s1 = *mul
	lw s1, mult
	
	# ///// version con ciclos (a0) /////
	# a0 = 0
	addi a0, zero, 0
	# i = t0 = 0
	addi t0, zero, 0
for:
	# if(i >= 61) jump(endfor)
	bge t0, s1, endfor
	
	add a0, a0, s0
	
	addi t0, t0, 1
	j for
endfor:
	# ///// version con desplazamientos (a1) /////
	# t0 = 6
	addi t0, zero, 6
	# a1 = s0<<t0 === a1 = s0*64
	sll a1, s0, t0
	# a1 = a1 - 3*s0
	sub a1, a1, s0
	sub a1, a1, s0
	sub a1, a1, s0
	
	# return
	addi a7, zero, 10
	ecall
	