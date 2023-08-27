# a = a1
# b = a2
# c = a3
# d = a4
# e = a5

.text
#a)
add a1, x0, a2

#b)
add a1, a2, a3

#c)
addi a1, a1, 1

#d)
addi a1, a3, 2

#e)
add t0, a2, a3
add a1, a4, a5
add a1, t0, a1

#f)
sub a1, a2, a3

#g)
sub a1, a2, a4
add a1, a3, a1

#h)
add t0, a2, a3
add a1, a4, a5
sub a1, t0, a1

#i)
mul a1, a2, a3

#j)
div a1, a2, a3

#k)
addi t0, x0, 3
mul a1, t0, a5

#l)
sub t0, a2, a3
sub a1, a4, a5
mul a1, t0, a1

#m)
mul a1, a2, a3
mul a1, a1, a4

#n)
add t0, a2, a3
div a1, a4, a5
mul a1, t0, a1