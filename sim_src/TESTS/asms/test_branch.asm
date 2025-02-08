	ADD		x0,		x0,		x0		; NOOP
	ADDI	x1,		x0,		1
	ADDI	x2,		x0,		2
	BLT		x1,		x2,		L1		; branch if x1<x2
	ADDI	x3,		x0,		3		; should be skipped
L1: BGE		x1,		x2,		L2		; branch if x1>=x2
	ADDI	x4,		x0,		4		; should be executed
L2: ADDI	x5,		x0,		5
	XOR     x0,     x0,     x0      ; HALT	