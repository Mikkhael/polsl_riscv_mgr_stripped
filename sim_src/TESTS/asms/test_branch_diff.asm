	ADD		x0,		x0,		x0		; NOOP
	ADDI	x1,		x0,		1
	ADDI	x2,		x0,		-2
	
	BGE		x1,		x2,		L1		; branch if x1>=x2
	ADDI	x3,		x0,		1		; should be skipped
L1: BGE		x2,		x1,		L2		; branch if x2>=x1
	ADDI	x4,		x0,		1		; should be executed
L2: ADDI	x0,		x0,		0

	BGEU	x1,		x2,		L3		; branch if x1>=x2
	ADDI	x5,		x0,		1		; should be executed
L3: BGEU	x2,		x1,		L4		; branch if x2>=x1
	ADDI	x6,		x0,		1		; should be skipped
L4: ADDI	x0,		x0,		0


	BLT		x1,		x2,		L5		; branch if x1<x2
	ADDI	x7,		x0,		1		; should be executed
L5: BLT		x2,		x1,		L6		; branch if x2<x1
	ADDI	x8,		x0,		1		; should be skipped
L6: ADDI	x0,		x0,		0

	BLTU	x1,		x2,		L7		; branch if x1<x2
	ADDI	x9,		x0,		1		; should be skipped
L7: BLTU	x2,		x1,		L8		; branch if x2<x1
	ADDI	x10,	x0,		1		; should be executed
L8: ADDI	x0,		x0,		0

	XOR     x0,     x0,     x0      ; HALT	