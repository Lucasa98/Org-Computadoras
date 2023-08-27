.text
ori t0, zero, 476	# guarda 0x000001dc en t0
ori t1, zero, 0xFF	# guarda 0x000000ff en t1
lui t2, 1		# guarda 0x00001000 en t2
ori t3, zero, 4		# guarda 0x00000004 en t3
lui t4 0xC3010		# guarda 0xc3010000 en t4
slli s0, t0, 16		# guarda 0x01dc0000 en s0 (desplazamiento de 16 bits)
srai s1, t1, 1		# guarda 0x0000007f en s1 (desplzamiento de 1 bit)
srl s2, t4, t3		# guarda 0x0c301000 en s2
sra s3, t4, t3		# guarda 0xfc301000 en s3
slli s4, t3, 1		# guarda 0x00000008 en s4
add s4, s4, t3		# guarda 0x0000000c en s4 (suma)
sll s5, t0, s4		# guarda 0x001dc000 en s5 (desplazamiento de 12 bits)
