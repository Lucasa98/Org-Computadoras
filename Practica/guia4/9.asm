.data
V: .word 410 49 10 29 594 10 85 439 38 49 28 85 321 93 57 519 47 85 993 19
size: .word 20

.text
	# a1 = V.begin()
	la a1, V
	# s0 = size
	lw s0, size
	# s1 = 400
	addi s1, zero, 400
	
	# contador de valores > 400
	addi a0, zero, 0
	# contador
	addi t0, zero, 0
ini:	
	bge t0, s0, end
	
	# t1 = *a1
	lw t1, 0(a1)
	# if(t1 < 400) jump(lessequal)
	blt t1, s1, lessequal
	# if(t1 == 400) jump(lessequal)
	beq t1, s1, lessequal
	addi a0, a0, 1
lessequal:
	# ++a0
	addi a1, a1, 4
	# ++t0
	addi t0, t0, 1
	j ini
end:
	addi a7, zero, 10
	ecall