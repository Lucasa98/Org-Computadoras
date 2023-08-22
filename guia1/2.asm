.text

lui a1, 0x10010
lw t0, 0(a1)
lw t1, 4(a1)
lw t2, 8(a1)

#a)
# Para cargar manualmente los valores, editamos directamente en la ventana "Data Segment"

#b)
# La funcion de lui a1, 10010 es la de escribir en a1 (x11) el valor 0x10010000

#c)
# La instruccion lw t1, 4(a1) carga la palabra almacenada en (a1)+4=0x10010004 (data segment) en t1
# t1 es el registro de destino
# a1 es la direccion base
# 4 es el offset
# Si a1 fuera 0x10010004 no obtendriamos el mismo resultado, si no que cargariamos la palabra almacenada en
# 0x10010008, ya que la direccion base esta desplazada 4 bits

#d)
# t0=0x12345678
# t1=0x000003e8
# t2=0x12ab34cd