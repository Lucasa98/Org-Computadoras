.text
	# carga 0x00000476 en t0
	ori t0, zero, 0x476
	# carga 0x00000552 en t1
	ori t1, zero, 0x552
	# carga 0x00000022 en t2
	ori t2, zero, 0x22
	
	# if(t1 >= t0) jump(no1)
	bge t1, t0, no1
	# if(t2 >= t0) jump(no2)
	bge t2, t0, no2
	# a0 = t0
	or a0, zero, t0
	# jump(fin)
	j fin
no2:
	# a0 = t2
	or a0, zero, t2
	# jump(fin)
	j fin
no1:
	# if(t2 >= t1) jump(no2)
	bge t2, t1, no2
	# a0 = t1
	or a0, zero, t1
fin:
	ori a7, x0, 10
	ecall

# El programa busca el mayor entre t0, t1 y t2 y lo guarda en a0

# Podemos cambiar las lineas 6 y 7, 8 y 9 y 14 y 15, respectivamente, por
# bge t1, t0, no1
# bge t2, t0, no2
# bge t2, t1, no2
