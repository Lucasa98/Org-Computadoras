.text
	addi x11, x0, 1024
	addi x11, x11, 1024
idle:	lw x16, 20(x11)		#vemos si esta cargado xx*yy
	beq x16, x0, idle
	#Multiplicacion de xx*yy
	lw x12, 0(x11)		#x
	lw x13, 4(x11)		#x
	lw x14, 12(x11)		#y
	lw x15, 16(x11)		#y
	#restamos 48
	addi x12, x12, -48
	addi x13, x13, -48
	addi x14, x14, -48
	addi x15, x15, -48
	#multiplicamos por 10
	addi x5, x12, 0
	addi x6, x14, 0
	addi x7, x0, 9	#contador
mul1:	beq x7, x0, finmul1
	add x12, x12, x5
	add x14, x14, x6
	addi x7, x7, -1
	jal mul1
finmul1:add x12, x12, x13
	add x14, x14, x15
	#multiplicamos xx*yy
	add x5, x0, x12
	addi x14, x14, -1
mul2:	beq x14, x0, finmul2
	add x12, x12, x5
	addi x14, x14, -1
	jal mul2
finmul2:

	#Separacion del resultado en cifras decimales
	#xx*yy en x12
	#cifras en x21 a x24
	addi x7,x0,10	#auxiliar con valor 10
	add x21,x12,x0	#copio xx*yy en x21
	addi x22, x0,0	#en x22 me va a quedar x21/10 = xx*yy/10
div1:	blt x21,x7,fin1	#while(x21 >= 10)
	sub x21,x21,x7	#x21 -= 10
	addi x22,x22,1	#x22++
	jal div1
fin1:	addi x23,x0,0	#en x23 me va a quedar x22/10 = xx*yy/100
div2:	blt x22,x7,fin2	#while(x22 >= 10)
	sub x22,x22,x7	#x22 -= 10
	addi x23,x23,1	#x23++
	jal div2
fin2:	addi x24,x0,0	#en x24 me va a quedar x23/10 = xx*yy/1000
div3:	blt x23,x7,fin3	#while(x23 >= 10)
	sub x23,x23,x7	#x23 -= 10
	addi x24,x24,1	#x24++
	jal div3
fin3:	#mandar a la uart
	nop
	sw x21, 24(x11)
	sw x22, 28(x11)
	sw x23, 32(x11)
	sw x24, 36(x11)
	jal idle
