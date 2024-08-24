.text
	# Cargar 0x10010 en el registro a1
	lui a1, 0x10010

	# Load Word
	# lw rd, rs1, imm
	# rd: registro destino
	# rs1: registro fuente (source)
	# imm: bits de desplazamiento desde el valor guardado en rs1

	# cargar en t0 el valor guardado en 0x10010000=(a1)
	lw t0, 0(a1)
	# cargar en t1 el valor guardado en 0x10010004=(a1)+4
	lw t1, 4(a1)
	# cargar en t2 el valor guardado en 0x10010004=(a1)+8
	lw t2, 8(a1)
