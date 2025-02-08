		; 0 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift

		; 1 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift

		; 2 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift

		; 3 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift

		; 4 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift
	
		; 5 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift


		; 6 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift
	
		; 7 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift
	
		; 8 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable
	SLLI	x31,	x31,	4		; shift
	SLLI	x1,		x1,		4		; shift
	
		; 9 NOOP
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	SD		x0,		x0,		0		; STORE
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	ADDI	x0,		x0,		0		; NOOP
	JAL		x0,		20			
	ADDI	x31,	x31,	0x8		; unreachable
	ADDI	x31,	x31, 	0x4		; unreachable
	ADDI	x31,	x31,	0x2		; unreachable
	ADDI	x31,	x31,	0x1		; unreachable
	ADDI	x1,		x1,		0x1		; reachable
	ADDI	x1,		x1,		0x2		; reachable
	ADDI	x1,		x1,		0x4		; reachable
	ADDI	x1,		x1,		0x8		; reachable


	XOR     x0,     x0,     x0      ; HALT