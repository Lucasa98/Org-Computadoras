.data
V: .word 1 2 3 4 755 6 347 8 9 10 11 512 13 14 515 16 17 918 19 20
val: .word 400

.text
	la a1, V		# puntero a V
	lw s1, val
	add a0, zero, zero	# c=0
for:	lw t1, 0(a1)
	beqz t1, end
	ble t1, s1, nomayor	# if t1<=V[i] -> nomayor
	addi a0, a0, 1		# else c++
nomayor:addi a1, a1, 4
	j for
end:	nop
