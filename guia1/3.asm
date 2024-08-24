.data
valor: .word 0

.text
	lui x5, 0x00012345
	lui x6, 0x00000345
	lui x7, 5
	auipc x31, 0x0000fc10
	sw x5, 0xfffffff4(x31)
	auipc x17, 0x0000fc10
	addi x17, x17, 0xffffffec
	sw x6, 4(x17)
	sw x7, 8(x17)
