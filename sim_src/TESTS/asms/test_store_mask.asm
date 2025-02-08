	ADD 	x0,		x0,		x0 		; NOOP
	; SOURCE SETUP
	LUI		x10,			0xAAAAB
	ADDI	x10, 	x10,	0xAAA
	LUI		x11,			0xBBBBC
	ADDI	x11, 	x11,	0xBBB
	LUI		x12,			0xCCCCD
	ADDI	x12, 	x12,	0xCCC
	LUI		x13,			0xDDDDE
	ADDI	x13, 	x13,	0xDDD
	LUI		x14,			0xEEEEF
	ADDI	x14, 	x14,	0xEEE
	LUI		x15,			0x00000
	ADDI	x15, 	x15,	0xFFF
	LUI		x16,			0x55555
	ADDI	x16, 	x16,	0x555
	LUI		x17,			0x11111
	ADDI	x17, 	x17,	0x111
	; BYTE
	SB		x0,		x10,	0x00
	SB		x0,		x11,	0x01
	SB		x0,		x12,	0x02
	SB		x0,		x13,	0x03
	SB		x0,		x14,	0x04
	SB		x0,		x15,	0x05
	SB		x0,		x16,	0x06
	SB		x0,		x17,	0x07
	; HALF WORD
	SH		x0,		x10,	0x10
	SH		x0,		x11,	0x12
	SH		x0,		x12,	0x14
	SH		x0,		x13,	0x16
	; WORD
	SW		x0,		x10,	0x20
	SW		x0,		x11,	0x24
	XOR		x0,		x0,		x0
