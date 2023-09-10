#a) t1 == t2
beq t1, t2, eq
li a0, 0	# if t1==t2
j end		# return 1
eq: li a0, 1	# if t1!=t2 return 0

#b) t1 <= t2
slt a0, t2, t1	# t1 > t2
not a0, a0	# !t1>t2 = t1<=t2

#c) t1 >= t2
slt a0, t1, t2	# t1 < t2
not a0, a0	# !t1<t2 = t1>=t2

#d) t1 != t2
slt t3, t1, t2	# t1 < t2
slt a0, t2, t1	# t2 < t1
and a0, t3, a0	# t1<t2 && t2<1 = t1!=t2

#e) t1 < t2
slt a0, t1, t2

#f) t1 > t2
slt a0, t2, t1
