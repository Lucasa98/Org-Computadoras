# a0 = 1 indica que la comparacion fue verdadera, en caos contrario a0=0
# tomar cada inciso como codigo independiente (esto no ensambla por tener labels repetidos)


#a) t1 < 5
slti a0, t1, 5

#b) t1==5 && t2==t3
ori a0, zero, 0		# a0=0
ori t4, zero, 5		# t4=5
beq t1, t4, b1		# if t1==5 -> b1
j end			# else return 0
b1:	beq t2, t3, b2	# if t2==t3 -> b2
j end			# else return 0
b2:	ori a0, zero, 1	# return 1
end: ecall

#c) t1!=t2 || t1!=t3
ori a0, zero, 1		# a0=1
beq t1, t2, b1		# if t1==t2 -> b1
j end			# else return 1
b1:	beq t1, t3, b2	# if t1==t3 -> b2
j end			# else return 1
b2:	ori a0, zero, 0	# return 0
end: ecall

#d) t1 > 6
ori a0, zero, 6		# a0=6
slt a0, a0, t1		# 6<t1

#e) t1>10 && t1<30
slti a0, t1, 10
not a0, a0
slti t2, t1, 30
and a0, a0, t2