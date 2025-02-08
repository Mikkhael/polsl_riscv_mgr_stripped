	ADD 	x0,		x0,		x0 		; NOOP
	JAL		x0,		L1				; Jump at PC=4
	ADDI	x1,		x0,		0x1		; Padding, should not be executed
	ADDI	x1,		x0,		0x2		; Padding, should not be executed
	ADDI	x1,		x0,		0x3		; Padding, should not be executed
L1: ADDI	x2,		x0,		0x1
	ADDI	x3,		x0,		0x1
	ADDI	x4,		x0,		0x1
	XOR     x0,     x0,     x0      ; HALT
