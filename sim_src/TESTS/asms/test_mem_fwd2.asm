ADDI    a0,     x0,     0x70    ; x10 = 0x70
ADDI    a5,     x0,     0x21    ; x15 = 0x21
SD   	x0,     a0,     0x28    ; MEM[0x28] = 0x70
SD   	x0,     a5,     0x10    ; MEM[0x10] = 0x21
LD      a1,     x0,     0x10    ; x11 = MEM[0x10] (0x21)
LD      a2,     a1,     0x07    ; x12 = MEM[0x21+0x07 (0x28)] (0x70)
ADDI    a3,     a2,     0x22    ; x13 = x12 + 0x22 (0x92)
ADDI    a6,     a6,     0x1
ADDI    a6,     a6,     0x2
ADDI    a6,     a6,     0x3
ADDI    a6,     a6,     0x4
XOR     x0,     x0,     x0