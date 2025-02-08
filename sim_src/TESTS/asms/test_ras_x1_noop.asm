	ADD		x0,		x0,		x0		; NOOP
	ADD 	x31,	x0,		x0		; set error return
	ADDI	x2,		x0,		0x10
	ADDI	x3,		x0,		0x20
	JAL		x1,		ROUTINE1		; call ROUTINE1 with args (0x10, 0x20)
	ORI		x6,		x0,		0x1
	ADD 	x5,		x0,		x4
	ADDI	x2,		x0,		0x100
	ADDI	x3,		x0,		0x200
	JAL		x1,		ROUTINE1		; call ROUTINE1 with args (0x100, 0x200)
	ORI		x6,		x6,		0x2
	JAL		x0,		EXIT
	ORI 	x31,	x0,		0x100	; unreachable
	ORI 	x31,	x0,		0x200	; unreachable
	ORI 	x31,	x0,		0x300	; unreachable
ROUTINE1:							; x4 += (x2 + x3 + 1)
	ADD		x4,		x2,		x3		; ADD args to x4
	JAL		x1,		ROUTINE2		; call ROUTINE2 ( add 1 to x4 )
	ADDI    x0,		x0,		0		; NOOP
	JALR	x0,		x1,		0		; RET
	ORI 	x31,	x0,		0x1		; unreachable
	ORI 	x31,	x0,		0x2		; unreachable
	ORI 	x31,	x0,		0x3		; unreachable
ROUTINE2:							; x4 += 1
	ADDI	x4,		x4,		1
	JALR	x0,		x1,		0		; RET
	ORI 	x31,	x0,		0x10	; unreachable
	ORI 	x31,	x0,		0x20	; unreachable
	ORI 	x31,	x0,		0x30	; unreachable
EXIT:
	ORI		x6,		x6,		0x4
	ADD		x0,		x0,		x0		; NOOP
	ADD		x0,		x0,		x0		; NOOP
	ADD		x0,		x0,		x0		; NOOP
	XOR     x0,     x0,     x0      ; HALT
