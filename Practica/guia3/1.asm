.text
ori t0, zero, 0x476	#guarda 0x00000476 en t0
ori t1, zero, 0x552	#guarda 0x00000552 en t1
ori t2, zero, 0x22	#guarda 0x00000022 en t2

slt t6, t1, t0		#guarda t1<t0 en t6 (en este caso, 0)
beq t6, zero, no1	#salta a no1 si t6 es zero
slt t6,t2,t0		#guarda t2<t0 en t6 (en este caso, 1)
beq t6, zero, no2	#salta a no2 si t6 es zero
or a0, zero, t0		#guarda t0 en a0
j fin			#salta a fin

no2:or a0, zero, t2	#guarda t2 en a0
j fin			#salta a fin
no1:slt t6, t2, t1	#guarda t2<t1 en t6
beq t6, zero, no2	#salta a no2 si t6 es zero
or a0, zero, t1		#guarda t1 en a0
fin:
ori a7, x0, 10		#guarda 0x0000000a en a7
ecall

# El codigo busca el mayor y lo guarda en a0
# Codigo equivalente en c++:
#	if(t1>=t0){
#		if(t2>=t1)
#			a0 = t2
#		else
#			a0 = t1
#	}else{
#		if(t2>=t0)
#			a0 = t2
#		else
#			a0 = t0
#	}
#	a7 = 10

#c)
# Se pueden reemplazar las lineas 6 y 7 por 
# bge t1, t0, no1
# 8 y 9 por
# bge t2, t0, no2
# 14 y 15 por
# bge t2, t1, no2