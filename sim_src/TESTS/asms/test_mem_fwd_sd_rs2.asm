ADDI    a0,     x0,     0x20    ; x10 = 0x20
SD   	x0,     a0,     0x28    ; MEM[0x28] = 0x20
ADDI    zero,   zero,   0       ; NOOP
LD      a1,     x0,     0x28    ; x11 = MEM[0x28] (0x20)
SD   	a0,     a1,     0x18    ; MEM[0x20 + 0x18] = 0x20
ADDI    zero,   zero,   0       ; NOOP
XOR     x0,     x0,     x0