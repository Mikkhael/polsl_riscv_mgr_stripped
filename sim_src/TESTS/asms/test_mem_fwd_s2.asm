ADDI    a0,     x0,     0x70    ; x10 = 0x70
SD   	x0,     a0,     0x28    ; MEM[0x28] = 0x70
BLT     zero,   zero,   8
BLT     zero,   zero,   8
LD      a1,     x0,     0x28    ; x11 = MEM[0x28] (0x70)
; ADDI    x0,     x0,     0       ; NOOP
ADDI    a2,     a1,     0x11    ; x12 = x11 + 0x11 (0x81)
ADDI    a3,     a1,     0x22    ; x13 = x11 + 0x22 (0x92)
ADDI    a6,     a6,     0x1
ADDI    a6,     a6,     0x2
ADDI    a6,     a6,     0x3
ADDI    a6,     a6,     0x4
XOR     x0,     x0,     x0
