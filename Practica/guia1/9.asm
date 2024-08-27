.text
	# Ejercicio 8
	lui a1, 0x10010
	lui t0, 0xABCD0
	sw t0, 0(a1)
	lui t0, 0x12340
	sw t0, 4(a1)
	# Ejercicio 9
	# Guardamos la direccion del Data Segment
	lui a1, 0x10010
	# Recuperamos el valor de cada direccion
	lw t0, 0(a1)
	lw t1, 4(a1)
	# Guardamos en las direcciones opuestas
	sw t0, 4(a1)
	sw t1, 0(a1)