	ADDI	x0,		x0,		0 ; NOOP
	JAL		x1,		L1
	ADDI	a2,		a1,		1
	XOR		x0,		x0,		x0 ; HALT

L1:	
	JAL		x1,		L2
	ADDI	a2,		a2,		1
	JALR	x0,		x1,		0 ; RET
	
L2:	
	JAL		x1,		L3
	ADDI	a2,		a2,		2
	JALR	x0,		x1,		0 ; RET
	
L3:	
	JAL		x1,		L4
	ADDI	a2,		a2,		3
	JALR	x0,		x1,		0 ; RET
	
L4:	
	JAL		x1,		L5
	ADDI	a2,		a2,		4
	JALR	x0,		x1,		0 ; RET
	
L5:	
	ADDI	a1,		a1,		5
	JALR	x0,		x1,		0 ; RET