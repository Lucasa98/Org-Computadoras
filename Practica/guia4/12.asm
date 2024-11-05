.data
V: .ascii "hola soy re ascii jaja viste como e"
.align 2
carac: .byte 'a'
.align 2
total: .word

.text
	# a0 = V.begin()
	la a0, V
	# s0 = carac
	lb s0, carac
	
	# contador de caracteres iguales a 'carac'
	addi t0, zero, 0
	# t1 = *a0
	lb t1, 0(a0)
	
ini:	# while(t1 != 0)
	beq t1, zero, end
	# if(t1 != s0) jump(diff)
	bne t1, s0, diff
	# else ++t0
	addi t0, t0, 1
	
diff:		
	# ++a0
	addi a0, a0, 1
	lb t1, 0(a0)
	j ini
	
end:
	sw t0, total, t6
	la t5, total
	
	addi a7, zero, 10
	ecall