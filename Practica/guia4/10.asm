.data
V: .word 250 250 250 250 250 250 255 256 250 250 250 257 550 512 250 513 250 250 250 450 250 250 254 250 250 250 250 250 250 350
size: .word 30

.text
	# a1 = V.begin()
	la a1, V
	# s0 = size
	lw s0, size
	# s1 = 0x100
	addi s1, zero, 0x100
	# x2 = 0x200
	addi s2, zero, 0x200

	# contador
	addi t0, zero, 0
	# contador de valores dentro del rango [0x100,0x200]
	addi a0, zero, 0
ini:
	bge t0, s0, end
	lw t2, 0(a1)
	# if(t1 < s1) jump(fuerarango)
	blt t2, s1, continue
	# if(s2 < t1) jump(fuerarango)
	blt s2, t2, continue
	# else ++a0
	addi a0, a0, 1

continue:
	# ++a1
	addi a1, a1, 4
	# ++t0
	addi t0, t0, 1
	j ini

end:
	addi a7, zero, 10
	ecall
	