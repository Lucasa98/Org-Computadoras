.text
ori t0, zero, 0x465	# guarda 0x00000465 en t0
ori t1, zero, 0x0ff	# guarda 0x000000ff en t1
ori t2, zero, 0x123	# guarda 0x00000123 en t2
and a0, t0, t2		# guarda 0x00000021 en a0 (and bit a bit)
andi a1, t1, 0x35	# guarda 0x00000035 en a1 (and bit a bit con inmediato)
or a2, t1, t0		# guarda 0x000004ff en a2 (or bit a bit)
ori a3, t1, 1		# guarda 0x000000ff en a3 (or bit a bit con inmediato)
addi a4, t1, 1		# guarda 0x00000100 en a4 (suma con inmediato)
xor a5, t0, t0		# guarda 0x00000000 en a5 (xor bit a bit)
xori a6, t0, 0x371	# guarda 0x00000714 en a6 (xor bit a bit con inmediato)
xori a7, a6, 0x371	# guarda 0x00000465 en a7 (xor bit a bit con inmediato)
not s1, a0		# guarda 0xffffffde rn s1 (not bit a bit)