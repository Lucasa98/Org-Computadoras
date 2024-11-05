.data
V: .word 100 101 102 103 104 105 106 107 108 109

.text
	# it = V.begin()
	la a0, V
	# t0 = 0
	addi t0, zero, 0
	# t1 = 8
	addi t1, zero, 8
	# size = 10
	addi s0, zero, 10
	
	# while(i<10)
while:
	bge t0, s0, endwhile
	
	# *it *= 8
	lw t2, 0(a0)
	mul t2, t2, t1
	sw t2, 0(a0)
	
	# ++it
	addi a0, a0, 4
	# ++t0
	addi t0, t0, 1
	j while
endwhile:
	# return
	addi a7, zero, 10
	ecall