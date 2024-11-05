.data
V: .word 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
size: .word 15
A: .space 60

.text
	# itV = V.begin()
	la a0, V
	# itA = A.begin()
	la a1, A
	lw t0, size
	# t3 = 2
	addi t3, zero, 2
	
	# i = 0
	addi t1, zero, 0
for:	# for(i=0; i<size; ++i)
	bge t1, t0, endfor
	
	# t2 = *itV
	lw t2, (a0)
	# t4 = t2%2
	rem t4, t2, t3
	# if(t2%2==0) *itA = t2
	beqz t4, par
	sw t2, (a1)
par:
	# ++itV
	addi a0, a0, 4
	# ++itA
	addi a1, a1, 4
	
	# ++i
	addi t1, t1, 1
	j for
endfor:
	addi a7, zero, 10
	ecall
