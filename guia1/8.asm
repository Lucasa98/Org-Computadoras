.text
	# Guardamos la direccion del Data Segment
	lui a1, 0x10010
	# Guardamos 0xABCD0000 en t0
	lui t0, 0xABCD0
	# Almacenamos el valor de t0 en (a1)
	sw t0, 0(a1)
	# Guardamos 0x12340000 en t0
	lui t0, 0x12340
	# Almacenamos el valor de t0 en (a1)+4
	sw t0, 4(a1)
