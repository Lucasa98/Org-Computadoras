.data
G:		.word 0xA0000000	# Verde
B:		.word 0xA0000001	# Azul
R:		.word 0xA0000002	# Rojo
VIDEO_S:	.word 0xA0000003	# Seniales de video: {HS, VS, CLK}
TEXT_BUFFER:	.word 0x10010000	# Dirección del buffer de texto
FONT_ROM:	.word 0x90000000	# Dirección base de la FontROM
WIDTH:		.word 640		# Ancho de la pantalla en pixeles
HEIGHT:		.word 400		# Altura de la pantalla en pixeles

.text
	la a0, TEXT_BUFFER      # a0 apunta al buffer de texto
	la a1, FONT_ROM         # a1 apunta a la FontROM
	la a2, VIDEO_S		# a2 apunta a las seniales de video
	la a5, G		# a5 apunta al verde
	
	lw t4, WIDTH		# t4 = ancho de la pantalla en pixeles
	lw t5, HEIGHT		# t5 = altura de la pantalla en pixeles
	
	add s0, x0, x0		# s0 = contador de filas (scan line counter)
	add s1, x0, x0		# s1 = contador de puntos (dot counter)
	
	# iniciar en el primer punto de la primer fila
	addi s2, x0, 0x3	# HS:1, VS:1, CLK:0
	sw s2, 0(a2)
	add s2, x0, x0		# HS:0, vS:0, CLK:0
	sw s2, 0(a2)

for_row:
	beq s0, t5, endfor_row
		# HS:0, VS:0, CLK: 0
		add s2, x0, x0
		sw s2, 0(a2)
		
	for_col:
		beq s1, t4, endfor_col
			# HS:0, VS:0, CLK: 0
			add s2, x0, x0
			sw s2, 0(a2)
		
			# /////////< identificar caracter ///////////
			
			# character col
			srli s3, s1, 3		# s3: char_col = dot/8 = dot >> 3
			
			# character row
			srli s4, s0, 4		# s4: char_row = line/16 = line >> 4
			
			# Posicion en el text buffer
			slli s5, s4, 6		# s5 = char_row*64 = char_row << 6
			slli s6, s4, 4		# s6 = char_row*16 = char_row << 4
			add s5, s4, s5		# s5 = char_row*64 + char_row*16 = char_row*80
			add s5, s5, s3		# char_pos = char_row*80 + char_col
			
			# Caracter
			add a3, a0, s5		# direccion
			lb s5, 0(a3)		# s5 = ASCII
			# /////////> identificar caracter ///////////
				
			# /////////< identificar punto en matriz de caracter ///////////
			# dot_row = line%16 = line - char_row << 4
			slli s6, s4, 4		# s6 = char_row << 4
			sub s6, s0, s6		# s6: dot_row
			
			# dot_col = dot%8 = dot - char_col << 3
			slli s7, s3, 3		# s7 = char_col << 3
			sub s7, s1, s7		# s7 : dot_col
			
			# /////////> identificar punto en matriz de caracter ///////////
			
			# /////////< cargar bit de punto ///////////
			# matriz = FontROM + ASCII*16
			slli a4, s5, 4		# a4 = ASCII*16 = ASCII << 4
			add a4, a4, a1		# a4: matriz
			# byte = matriz + dot_row
			add a4, a4, s6		# a4: byte
			# cargar byte
			lb s8, 0(a4)
			# pixel = byte[dot_col]
			srl s8, s8, s7
			andi s8, s8, 0x1	# s8: pixel
			# /////////> cargar bit de punto ///////////
			
			# /////////< dibujar ///////////
			add s9, x0, x0
			beqz s8, negro
			addi s9, x0, 0xff	# s9 = 1111 1111
		negro:
			sb s9, 0(a5)		# verde
			sb s9, 1(a5)		# azul
			sb s9, 2(a5)		# rojo
			# /////////> dibujar ///////////
		
			# HS:0, VS:0, CLK: 1
			addi s2, x0, 0x4
			sw s2, 0(a2)
		addi s1, s1, 1
		j for_col
	endfor_col:
		
		# VS:0, HS:1, CLK:0
		addi s2, x0, 0x2
		sw s2, 0(a2)
	
	addi s0, s0, 1
	j for_row
endfor_row:

	# VS:0, HS:0, CLK: 0
	add s2, x0, x0
	sw s2, 0(a2)

