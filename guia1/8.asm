.text
#cargar direccion del primer dato de el data segment
lui t0, 0x10010

#cargar datos a guardar
lui t1, 0xABCD0
lui t2, 0x12340

#almacenar datos
sw t1, 0(t0)
sw t2, 4(t0)
