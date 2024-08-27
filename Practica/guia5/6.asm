.data
V: .word 1 2 3 4 5 6 7 8 9 10

.text
	# main
	la a1, V
	addi a2, zero, 10
	jal inv2
	j end
	
	# sobre el mismo vector
	# a1: puntero al vector
	# a2: tamanio del vector
inv1:	addi t0, zero, 0	# contador c=0
	addi t6, zero, 2
	div t1, a2, t6		# n = N/2
	addi t6, zero, 4
	mul a3, t6, a2		# aux = 4*N
	add a3, a3, a1		# puntero a la direccion siguiente a la ultima palabra
	addi a3, a3, -4		# puntero a la ultima palabra a3=a1+4*(N-1)
for1:	bge t0, t1, endfor1	# if(c>=n) return
	lw s1, 0(a1)		# s1= *a1
	lw s2, 0(a3)		# s2= *a3
	sw s2, 0(a1)		# *a1 = s2
	sw s1, 0(a3)		# *a3 = s1
	addi a1, a1, 4		# a1 += 4
	addi a3, a3, -4		# a3 -= 4
	addi t0, t0, 1		# c++
	j for1
endfor1:ret

	# Utilizando la pila
	# a1: puntero al vector
	# a2: tamanio del vector
inv2:	addi t0, zero, 0	# contador c=0
	add t1, zero, a1	# copia de a1
for2:	bge t0, a2, endfor2	# if(c>=N) break
	lw s1, 0(t1)		# s1 = *a1
	addi sp, sp, 4		# sp += 4
	sw s1, 0(sp)		# *sp = s1
	addi t1, t1, 4		# t1 += 4
	addi t0, t0, 1		# c++
	j for2
endfor2:
	addi t0, zero, 0	# c=0
for3:	bge t0, a2, endfor3	# if(c>=N) return
	lw s1, 0(sp)		# s1 = *sp
	addi sp, sp, -4		# sp -= 4
	sw s1, 0(a1)		# *a1 = s1
	addi a1, a1, 4		# a1 += 4
	addi t0, t0, 1		# c++
	j for3
endfor3:
	ret

end:	nop