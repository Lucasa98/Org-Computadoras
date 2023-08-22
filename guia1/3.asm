.data

valor: .word 0

.text

lui x5, 0x12345
lui x6, 0x345
lui x7, 0x5
sw x5, valor, x31
la x17, valor
sw x6, 4(x17)
sw x7, 8(x17)

#a)
# Las instrucciones del codigo Source equivalen a mas de una instruccion
# en el codigo Basic (instrucciones de maquina

#b)
# sw t0, valor, t6
# Store word
# t0: registro destino
# valor: direccion base (0)
# t6: puntero al offset

#d)
# 0x1001000c

#e)
# 0x12345000 en 0x10010000
# 0x00345000 en 0x10010004
# 0x00005000 en 0x10010008