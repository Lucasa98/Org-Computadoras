.data
V: .word 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
size: .word 15
V2: .space 60

.text
	la a0, V
	la a1, V2
	lw t0, size
	
	# i = 0
	addi t1, zero, 0
for:	# for(i=0; i<size; ++i)
	bge t1, t0, endfor
	
	# *(V2+i) = *(V+i)
	lw t2, (a0)
	sw t2, (a1)
	addi a0, a0, 4
	addi a1, a1, 4
	
	# ++i
	addi t1, t1, 1
	j for
endfor:
	addi a7, zero, 10
	ecall