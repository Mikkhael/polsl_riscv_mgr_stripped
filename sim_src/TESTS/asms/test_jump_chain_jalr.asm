	ADD 	x0,		x0,		x0 		; NOOP
	JALR	x0,		x0,		%L4
L1:	JALR	x0,		x0,		%L2
L2:	JALR	x0,		x0,		%L5
L3:	JALR	x0,		x0,		%L1
L4:	JALR	x0,		x0,		%L3
	ADDI	x31,	x31,	1		; unreachable
L5:	XOR		x0,		x0,		x0		; HALT