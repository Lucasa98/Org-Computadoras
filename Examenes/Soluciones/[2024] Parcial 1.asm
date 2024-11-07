.data
# cant empleados
empleados: .word 6
# Sueldo maximo para percepcion
sMax: .word 0x001B7635
# Arreglo de sueldos por empleado
sueldos: .word 1000000 1500000 2000000 2500000 1900000 1700000
# Arreglo de cantidad de hijos por empleado
hijos: .word 1 2 3 4 5 2

.text
#//////////// main ////////////#
	# cantidad empleados
	lw s0, empleados
	# importe por hijo
	lui s1, 0x00ABE
	srli s1, s1, 8

	# salario maximo para percepcion
	lw s2, sMax
	
	# arreglo sueldos
	la a0, sueldos
	# arreglo hijos
	la a1, hijos
	
	# indice
	addi t0, x0, 0

for:	
	bge t0, s0, finfor
	
	# cargar salario
	lw t1, 0(a0)
# if([a0] > sMax) no percibe
	bgt t1, s2, finsi
# else
	# cargar hijos
	lw t2, 0(a1)
	# calcular aumento
	mul t3, t2, s1
	add t1, t1, t3
	# guardar nuevo salario
	sw t1, 0(a0)
finsi:
	
	addi a0, a0, 4
	addi a1, a1, 4
	addi t0, t0, 1
	j for

finfor:
	# llamar a subrutina
	la a0, sueldos
	lw a1, empleados
	jal dos_mayores
	
	addi a7, x0, 10
	ecall


#//////////// dos_mayores ////////////#
# a0: direccion de los empleados
# a1: cant de empleados
# a2: DEVUELVE primer mayor
# a3: DEVUELVE segundo mayor
dos_mayores:
	# t0: mayor1
	addi a2, x0, 0
	# t1: mayor2
	addi a3, x0, 0
	
	# indice
	addi t2, x0, 0
	# for
	dos_mayores_for:
	bge t2, a1, dos_mayores_finfor
		# cargar sueldo
		lw t3, 0(a0)
		# if(sueldo >= mayor1)
		blt t3, a2, dos_mayores_menor1
			add a3, x0, a2
			add a2, x0, t3
			j dos_mayores_menor2
		
		# else if(sueldo >= mayor2)
		dos_mayores_menor1:
		blt t3, a3, dos_mayores_menor2
			add a3, x0, t3
		dos_mayores_menor2:
		#endif
		
		addi a0, a0, 4
		addi t2, t2, 1
	j dos_mayores_for
	dos_mayores_finfor:
	# endfor
	
	ret