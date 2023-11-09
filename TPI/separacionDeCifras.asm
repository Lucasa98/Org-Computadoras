.text
	#Multiplicacion de xx*yy y separacion del resultado
	#en cifras decimales
	#xx en x5
	#yy en x6
	#xx*yy en x20
	#cifras en x21 a x24
	mul x20,x5,x6	#x20 = xx*yy
	addi x7,x0,10	#auxiliar con valor 10
	add x21,x20,x0	#copio xx*yy en x21
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
fin3:	ecall