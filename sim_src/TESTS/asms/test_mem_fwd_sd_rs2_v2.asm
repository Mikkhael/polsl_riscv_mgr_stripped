ADDI    a0,     x0,     0x20    ; x10 = 0x20
SD   	x0,     a0,     0x28    ; MEM[0x28] = 0x20
ADDI    zero,   zero,   0       ; NOOP
LD      a1,     x0,     0x28    ; x11 = MEM[0x28] (0x20)
ADD   	a2,     a0,     a1      ; x12 = x11 + x10 (0x40)
ADDI    zero,   zero,   0       ; NOOP
XOR     x0,     x0,     x0