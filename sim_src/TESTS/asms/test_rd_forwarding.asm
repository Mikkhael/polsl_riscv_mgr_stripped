ADD 	x0,		x0,		x0 		; NOOP
ADDI 	x1,		x0,		0x100	; Set x1
ADDI	x2,		x1,		0x1	
ADDI 	x3,		x1,		0x2	
ADDI 	x4,		x1,		0x3	
ADDI 	x5,		x1,		0x4	
ADD 	x0,		x0,		x0 		; NOOP
ADD 	x0,		x0,		x0 		; NOOP
ADD 	x0,		x0,		x0 		; NOOP
ADDI 	x6,		x4,		0x0	
XOR     x0,     x0,     x0      ; HALT