.text
#cargar direccion del primer dato de el data segment
lui t0, 0x10010

#cargar datos a guardar
lui t1, 0xABCD0
lui t2, 0x12340

#almacenar datos
sw t1, 0(t0)
sw t2, 4(t0)

# ejercicio 9
# intercambiar los valores en el data segment
# (supongamos que no tenemos los valores en los registros
lw t1, 0(t0)
lw t2, 4(t0)
sw t2, 0(t0)
sw t1, 4(t0)