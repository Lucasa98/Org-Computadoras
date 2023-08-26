.text
# 1
li a0, 0x111117ff
li a1, 0x11111CAB

# 2
lui a2, 0x11111
ori a2, a2, 0x7ff
lui a3, 0x11112
ori a3, a3, -0x355

#3
lui a4, 0x11111
addi a4, a4, 0x7ff
lui a5, 0x11112
addi, a5, a5, -0x355


#a)
# En el primer caso, se genera el codigo del tercer caso (lui+addi)
# Se aumenta en 1 el inmediato cargado inicialmente, para luego restar
# y asi llegar al valor deseado.
# Esto se debe a que, usando complemento a 2, el mayor valor que se puede
# sumar es 2047 (0x7ff) con los 12 bits disponibles

#b)
# a1 = 0x111117ff
# a2 = 0x11111cab
# a3 = 0x111117ff
# a4 = 0xfffffcab
# a5 = 0x111117ff
# a6 = 0x11111cab

#c)
# Hay que agregar el valor con signo '-' para que lo interprete como
# complemento a 2. Siempre necesitaremos incrementar en 1 el valor
# inicial, para luego realizar la resta

#d)
# 0xcab = 853