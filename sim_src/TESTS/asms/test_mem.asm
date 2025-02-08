	ADD 	x0,		x0,		x0 		; NOOP
	;LUI		x1,		0x123			; set data to x1
	ADDI	x1, x0, 0x11
	ADDI	x2, x0, 0x22
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	SD		x2,		x1,		6		; store x1 (0x11) at addr 0x22 + 6 = 0x28 = 40
	SD		x1,		x2,		7		; store x2 (0x22) at addr 0x11 + 7 = 0x18 = 24
	LD		x3,		x0,		24		; load addr 24 to x3
	ADD x0,x0,x0					; NOOP
	LD		x3,		x0,		24		; load addr 24 to x3
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	LD		x4,		x0,		40		; load addr 40 to x4
	ADD x0,x0,x0					; NOOP
	LD		x4,		x0,		40		; load addr 40 to x4
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	ADD x0,x0,x0	; Padding NOOP
	XOR x0,x0,x0    ; HALT

