.text
	# Codigo 1:
	# Guardamos 20 en t0
	addi t0, x0, 20
	# Restamos 5 a 20 con addi
	addi t0, t0, -5
	
	# Codigo 2:
	# Guardamos 20 en t0
	addi t0, x0, 20
	# Guardamos 5 en t1
	addi t1, x0, 5
	# Restamos 5 a 20
	sub t0, t0, t1
	