.data
elemento: .word 0x4E1C532D
.text
lw t1, elemento

#a)
# Se general auipc t1, 0x0000fc10 y lw t1, 0(t1)

#b)
# En estas, interviene solo t1

#c)
# La etiqueta elemento es reemplazada por la direccion en memoria (0x10010000)

#d)
# La ventaja de usar etiquetas es que... no tengo que poner direcciones a
# mano...?

#e)
# En t1 queda el valor de la palabra apuntada por elemento
