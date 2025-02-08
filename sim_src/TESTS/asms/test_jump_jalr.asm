	ADDI	x10,	x0,		%L1 ; x10 = addr of L1
	ADDI	x0,		x0,		0	; NOOP
	ADDI	x0,		x0,		0	; NOOP

	ADDI 	x10,	x10,	0x8 ; Increase x10 by 2*4
	JALR	x0,		x10,	0x0	; jump to L1 + 2
	
	ADDI	x31,	x31,	4 ; should skip

L1:
	ADDI	x31,	x31,	1 ; should skip
	ADDI	x31,	x31,	2 ; should skip
	
	ADDI	x11,	x11,	1
	ADDI	x11,	x11,	2
	ADDI	x11,	x11,	4
	ADDI	x11,	x11,	8	; x11 should be 0xf

	XOR     x0,     x0,     x0      ; HALT