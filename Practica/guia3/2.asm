.text
	addi t1, x0, 5
	addi t2, x0, 10

	# a0 = t1 == t2 === a0 = (t1 - t2) == 0
	sub t6, t1, t2
	seqz a0, t6
	
	# a1 = t1 <= t2 === a1 != t1 > t2
	slt t6, t2, t1
	xori a1, t6, 0x1
	
	# a2 = t1 >= t2 === a2 != t1 < t2
	slt t6, t1, t2
	xori a2, t6, 0x1
	
	# a3 = t1 != t2 === a3 = (t1 - t2) != 0
	sub t6, t1, t2
	snez a3, t6
	
	# a4 = t1 < t2
	slt a4, t1, t2
	
	# a5 = t1 > t2 === a5 = t2 < t1
	slt a5, t2, t1
	