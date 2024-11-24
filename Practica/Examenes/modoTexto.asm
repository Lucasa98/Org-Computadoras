.data
G:		.word 0xA0000000
B:		.word 0xA0000001
R:		.word 0xA0000002
TEXT_BUFFER:	.word 0x10010000  # Dirección del buffer de texto
FONT_ROM:	.word 0x90000000  # Dirección base de la FontROM
SCREEN_WIDTH:	.word 80          # Ancho de la pantalla (caracteres)
SCREEN_HEIGHT:	.word 25          # Altura de la pantalla (caracteres)
CHAR_HEIGHT:	.word 16          # Altura del carácter en píxeles
CHAR_WIDTH:	.word 8           # Ancho del carácter en píxeles

.text
	la t0, TEXT_BUFFER      # t0 apunta al buffer de texto
	la t1, FONT_ROM         # t1 apunta a la FontROM
	li t2, 80               # t2 = ancho de la pantalla en caracteres
	li t3, 25               # t3 = altura de la pantalla en caracteres
	li t4, 16               # t4 = altura de cada carácter en píxeles
	li t5, 8                # t5 = ancho de cada carácter en píxeles

# while(fila != 25)
rows:
	li s0, 0                # contador de fila
	li s1, 0                # contador de columna
	
	# while(columna != 80)
	columns:
		# Leer el caracter del buffer de texto
		lw a0, 0(t0)            # Leer caracter (ASCII)
		addi t0, t0, 4          # Avanzar al siguiente caracter
		
		# Leer caracter en FontROM
		mul a1, a0, t4          # Desplazamiento en FontROM (ASCII * 16)
		add a1, t1, a1          # Dirección base del caracter (primer fila)
		
		# Renderizar el carácter fila por fila
		add s2, x0, a1		# Apuntar a la FontROM del carácter
		li s3, 0		# Contador de filas del carácter

		# while(char != 16)
		char:
			lbu a2, 0(s2)           # Leer fila de píxeles del carácter
			addi s2, s2, 1          # Avanzar a la siguiente fila
			add s4, x0, a2		# Guardar fila de píxeles en s4
			li s5, 0                # Contador de bits por fila

			# while(pixel != 8)
			pixel:
				andi a3, s4, 0x80       # Extraer el bit más significativo
				slli a3, a3, 7          # Ajustar el bit para RGB

				sw a3, 0(s9)		# Enviar a la señal de video (Verde)
				sw a3, 0(s10)		# Azul
				sw a3, 0(s11)           # Rojo

				slli s4, s4, 1          # Desplazar al siguiente bit (pixel)
				addi s5, s5, 1          # Incrementar contador
				bne s5, t5, pixel	# Repetir para 8 pixeles
			# endwhile pixel
			
			addi s3, s3, 1          # Incrementar fila del carácter
			bne s3, t4, char	# Repetir para 16 filas
		# endwhile char
			
		# Avanzar a la siguiente columna
		addi s1, s1, 1
		bne s1, t2, columns
	# endwhile columns
		
	# Avanzar a la siguiente fila
	addi s0, s0, 1
	bne s0, t3, rows
# endwhile rows

	# Repetir
	j rows
