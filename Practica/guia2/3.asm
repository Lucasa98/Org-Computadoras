.text
	# Codigo 1:
	# Guardar inmediato 0x111117FF en a0
	li a0, 0x111117FF
	# Guardar inmediato 0x11111CAB en a1
	li a1, 0x11111CAB
	
	# Codigo 2:
	# Guardar 0x11111000 en a2
	lui a2, 0x11111
	# Hacer una operacion or bit a bit y almacenarla en a2
	# 0001 0001 0001 0001 0001 0000 0000 0000 or
	# 0000 0000 0000 0000 0000 0111 1111 1111 = 0x111117FF
	ori a2, a2, 0x7FF
	# Guardar 0x11112000 en a3
	lui a3, 0x11112
	# 0001 0001 0001 0001 0010 0000 0000 0000 or
	# 1111 1111 1111
	ori a3, a3, -0x355
	
	# Codigo 3:
	# Guardar 0x11111000 en a4
	lui a4, 0x11111
	# Sumarle 0x000007FF
	addi a4, a4, 0x7FF
	# Guardar 0x11111000 en a5
	lui a5, 0x11112
	# Sumarle 0xfffff355
	addi a5, a5, -0x355
	
	lui t0, 0x11111
	addi t0, t0, 0xcab
