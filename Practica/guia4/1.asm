.data
val: .word 24
.text
	# cargar val en a0
	lw a0,val
	# t0 = 2
	addi t0, zero, 2
	# t1 = a0%t0
	rem t1, a0, t0
	# s1 = 10
	addi s1, zero, 10
if:
	# if(t1 == 0) jump(fin)
	beq t1, zero, fin
impar:
	# s1 = 20
	addi s1, zero, 20
fin:
	# return
	addi a7, zero, 10
	ecall
	
	
