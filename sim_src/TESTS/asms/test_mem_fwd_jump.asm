ADDI    a0,     x0,     10    ; x10 = 10
SD   	x0,     a0,     0x28    ; MEM[0x28] = 10
LD      a1,     x0,     0x28    ; x11 = MEM[0x28] (10)
JALR    x0,     a1,     0x14    ; jump to L1 (10 + 14 = 24 = L1)

ADDI    x31,    x31,     0x1    ; unreachable
ADDI    x31,    x31,     0x2    ; unreachable
L1:
ADDI    a6,     a6,     0x1
XOR     x0,     x0,     x0
