.data
valor: .word 0x805215C9

#.text
la s0, valor	#asignamos a s0 la direccion de la etiqueta valor (0x10010000)
lbu a1, 0(s0)	#asignamos a a1 los primeros 8 bits en s0 (c9)
lbu a2, 1(s0)	#asignamos a a2 los primeros 8 bits en s0+1 (15)
lbu a3, 2(s0)	#asignamos a a2 los primeros 8 bits en s0+2 (52)
lbu a4, 3(s0)	#asignamos a a2 los primeros 8 bits en s0+3 (80)

.text
la s0, valor	#asignamos a s0 la direccion de la etiqueta (0x10010000)
lb a1, 0(s0)	#asignamos a a1 los primeros 8 bits en s0 (c9)
lb a2, 1(s0)	#asignamos a a1 los primeros 8 bits en s0+1 (15)
lb a3, 2(s0)	#asignamos a a1 los primeros 8 bits en s0+2 (52)
lb a4, 3(s0)	#asignamos a a1 los primeros 8 bits en s0+3 (80)
# en esta parte no entenddi por que rellena con ffffff en a1 y a4