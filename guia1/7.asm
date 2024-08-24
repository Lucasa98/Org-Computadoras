.data
valor: .word 0x805215C9
.text
	la s0, valor
	lhu a1, 0(s0)
	lhu a2, 2(s0)

.text
	la s0, valor
	lh a1, 0(s0)
	lh a2, 2(s0)