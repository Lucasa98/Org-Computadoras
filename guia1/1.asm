.text
lui t0, 0x12345
lui t1, 201
lui t2, 0xABCDE

#a)
# La diferencia entre el codigo Source y Basic es que en Source se muestran las instrucciones tal cual las
# escribimos, mientras que en Basic se transforma los nombres de los registros a indices "globales" x (no se como
# llaman), ademas de convertir los valores a decimal.

#b)
# La direccion de comienzo del programa es el pc (program counter) 0x00400000 y cada instruccion tiene una longitud
# de 4 bits

#c)
# 0x123452b7 -> 00010010001101000101001010110111
# 0x000c9337 -> 00000000000011001001001100110111
# 0xabcde3b7 -> 10101011110011011110001110110111

#d)
# t0=t1=t2= 0x00000000
# pc= 0x00400000

#e)
# 0x10010000

#f)
# 0x12345000

#g)
# El registro pc aumenta en 4, para apuntar a la direccion de la siguiente instruccion, ya que cada instruccion
# tiene una longitud de 4 bytes. La funcion de pc es seguir la instruccion en la que se encuentra el
# programa (program counter).

#h)
# pc=0x00400000 t0=0x00000000 t1=0x00000000 t2=0x00000000
# pc=0x00400004 t0=0x12345000 t1=0x00000000 t2=0x00000000
# pc=0x00400008 t0=0x12345000 t1=0x000c9000 t2=0x00000000
# pc=0x0040000c t0=0x12345000 t1=0x000c9000 t2=0xabcde000
# pc=0x00400010 t0=0x12345000 t1=0x000c9000 t2=0xabcde000