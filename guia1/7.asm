.data
valor: .word 0x805215c9

#version 1
#.text
#la s0, valor
#lhu a1, 0(s0)
#lhu a2, 2(s0)

#version 2
.text
la s0, valor
lh a1, 0(s0)
lh a2, 2(s0)

#a)
# los registros que intervinieron para extraer un valor fueron a1 y a2

#b)
# version 1
# a1=0x000015c9
# a2=0x00008052
# Toma estos valores ya que lhu toma los primeros 16 bits desde la direccion 0(s0)
# version 2
# a1=0x000015c9
# a2=0xffff8052
# a2 tiene ffff en lugar de 0000 ya que lh toma los valores como sign-extended
# esto significa que rellena el resto de bits con el signo del mas siginificativo
