ADDI    x11,  x0,   1
ADDI    x12,  x0,   2
ADDI    x13,  x0,   3
ADDI    x14,  x0,   4
ADDI    x15,  x0,   5

BLT     zero,   zero,   L2   ; LOAD addr 0x10 to x11 (x11 = 0x23)  ; No Jump   ; predicted jump hardcoded 20 -> 44

ADDI    x16,  x0,   6
XOR     zero,   zero,   zero  ; HALT

ADDI    x31,    x31,    1   ; unreachable
ADDI    x31,    x31,    2   ; unreachable
ADDI    x31,    x31,    4   ; unreachable
L2: ; addr = 44