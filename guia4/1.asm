.data
data1: .word 121
.text
	ori s1, zero, 20
	lw a0, data1
	andi t0, a0, 0x1	# Si a0 es impar, t0 sera 0x00000001
	beqz t0, par		# if t0==0
	j end			# else s1=20
par:	ori s1, zero, 10	# s1 = 10
end:	nop