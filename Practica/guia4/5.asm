.data
a: .word 4
b: .word 5
c: .word 3

.text
	# t0 = a
	lw t0, a
	# s0 = b
	lw s0, b
	# s1 = c
	lw s1, c
	
	# if(s0 >= t0) { // no reemplazar }
	bge s0, t0, jump1
	# else { // reemplazar }
	add t0, zero, s0
jump1:
	# if(s1 >= t0) { // no reemplazar }
	bge s1, t0, jump2
	# else { // reemplazar }
	add t0, zero, s1
jump2:
	# guardar en la posicion siguiente a c
	la a1, c
	sw t0, 4(a1)
	
	# return
	addi a7, zero, 10
	ecall