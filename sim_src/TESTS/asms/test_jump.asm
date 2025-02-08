	ADD 	x0,		x0,		x0 		; NOOP
	ADD 	x0,		x0,		x0 		; NOOP
	JAL		x0,		L1
	ADDI	x1,		x0,		0x1
	ADDI	x1,		x0,		0x2
	ADDI	x1,		x0,		0x3
	ADDI	x1,		x0,		0x4
	ADDI	x1,		x0,		0x5
L1: ADDI	x2,		x0,		0xa
	ADDI	x3,		x0,		0x1
	ADDI	x3,		x0,		0x2
	ADDI	x3,		x0,		0x3
	ADDI	x3,		x0,		0x4
	ADDI	x3,		x0,		0x5
	JALR	x0,		x0,		%L2
	ADDI	x4,		x0,		0x1
	ADDI	x4,		x0,		0x2
	ADDI	x4,		x0,		0x3
	ADDI	x4,		x0,		0x4
	ADDI	x4,		x0,		0x5
L2: ADDI	x5,		x0,		0xa
	ADDI	x6,		x0,		0x1
	ADDI	x6,		x0,		0x2
	ADDI	x6,		x0,		0x3
	ADDI	x6,		x0,		0x4
	ADDI	x6,		x0,		0x5
	XOR     x0,     x0,     x0      ; HALT