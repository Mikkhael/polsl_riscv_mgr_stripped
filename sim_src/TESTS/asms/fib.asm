	ADD		x0,		x0,		x0		; NOOP
	ADDI	x10,	x0,		10		; set counter to 10

	ADDI	x11,	x0,		0		; set initial values
	ADDI	x12,	x0,		1		; set

LOOP:
	BEQ		x10,	x0,		EXIT
	ADDI	x10,	x10,	-1
	JAL		x1,		COMPUTE_NEXT_FIB	; CALL
	JAL		x0,		LOOP

COMPUTE_NEXT_FIB:					; (x12, x11) = (x12 + x11, x12)
	ADD 	x30,	x12,	x11		
	ADD		x11,	x0,		x12
	ADD		x12,	x0,		x30		
	JALR	x0,		x1,		0		; RET

EXIT:
	ADD		x0,		x0,		x0		; NOOP
	XOR		x0,		x0,		x0		; HALT