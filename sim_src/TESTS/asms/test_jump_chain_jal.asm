	ADD 	x0,		x0,		x0 		; NOOP
	JAL		x0,		L4
L1:	JAL		x0,		L2
L2:	JAL		x0,		L5
L3:	JAL		x0,		L1
L4:	JAL		x0,		L3
	ADDI	x31,	x31,	1		; unreachable
L5:	XOR		x0,		x0,		x0		; HALT