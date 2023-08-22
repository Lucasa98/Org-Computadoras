.text

lui t0, 0x12345	# guarda en t0 0x12345000
sw t0, (sp)	# guarda el contenido de t0 en la direccion guardada en sp (0x7fffeffc en mi caso)
lui a1, 0x10010	# guarda 0x10010000 en a1
lw t1, (sp)	# carga el valor guardado en la direccion contenida por sp (0x7fffeffc) en t1
sw t1, (a1)	# guarda el valor de t1 en la direccion contenida por a1 (0x10010000)
li a7, 10	# guarda 0x0000000a en a7
ecall		# no se

#b)
# El valor de t0 se almacena en la direccion indicada por sp (no en sp) (linea 4)
# Luego este valor es almacenado en t1 leyendo de la memoria anterior (linea 6)
# Y finalmente se almacena en 0x10010000

#c)
# Se asigna 0x1001 a a1 porque es la direccion de memoria (data segment) donde
# vamos a guardar t0

#d)
# La accion de sw t0,(sp) es guardar el contenido de t0 en la direccion indicada
# por sp (no en sp). Antes habia almacenado 0 y luego el valor de t0

#e)
# Al ejecutar lw t1,(sp); t1 toma el valor 0x12345000 que esta almacenado en
# la direccion indicada por sp (no la direccion de sp)

#f)
# Con sw t1,(a1) el valor de t1 se almacena en la direccion indicada por a1
# (no en a1)
