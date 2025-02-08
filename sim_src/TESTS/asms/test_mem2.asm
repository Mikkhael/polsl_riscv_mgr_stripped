	ADD 	x0,		x0,		x0 		; NOOP
	;LUI		x1,		0x123			; set data to x1
	ADDI	x1, x0, 0x11
	ADDI	x2, x0, 0x22
	SD		x2,		x1,		6		; store x1 (0x11) at addr 0x22 + 6 = 0x28 = 40
	SD		x1,		x2,		7		; store x2 (0x22) at addr 0x11 + 7 = 0x18 = 24
	ADDI x0,x0,0	; Padding NOOP
	ADDI x0,x0,0	; Padding NOOP
	ADDI x0,x0,0	; Padding NOOP
	LD		x3,		x0,		24		; load addr 24 to x3
	ADD x10,x3,x0
	ADD x11,x3,x0
	LD		x4,		x0,		40		; load addr 40 to x4
	ADD x12,x0,x4
	ADD x13,x0,x4
	LD		x5,		x0,		24		; load addr 24 (0x22) to x5 
	SD		x5,		x1,		0x0e    ; store x1 (0x11) at x5+0e (0x22+0e = 0x30 = 48)
	SD		x5,		x1,		0x16    ; store x1 (0x11) at x5+16 (0x22+16 = 0x38 = 56)
	ADDI x0,x0,0	; Padding NOOP
	ADDI x0,x0,0	; Padding NOOP
	ADDI x0,x0,0	; Padding NOOP
	LD		x6,		x0,		40		; load addr 24 (0x11) to x6 
	SD		x0,		x6,		0x00    ; store x6 (0x11) at 00
	SD		x0,		x6,		0x08    ; store x6 (0x11) at 08
	ADDI x0,x0,0	; Padding NOOP
	ADDI x0,x0,0	; Padding NOOP
	ADDI x0,x0,0	; Padding NOOP
	XOR x0,x0,x0    ; HALT

