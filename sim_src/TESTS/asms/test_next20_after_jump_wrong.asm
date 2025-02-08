ADDI    x2,     x2,     1
ADDI    x2,     x2,     2
ADDI    x2,     x2,     4
ADDI    x2,     x2,     8

BEQ     zero,   zero,   L1  ; Jump
BLT     zero,   zero,   L2  ; No Jump   ; predicted jump hardcoded 20 -> 44
ADDI    x31,    x31,    1   ; unreachable

ADDI    x31,    x31,    2
L1:
ADDI    x1,     x1,    0x01
ADDI    x1,     x1,    0x10
XOR     zero,    zero,    zero  ; HALT

L2: ; addr = 44
ADDI    x31,     x31,     16
ADDI    x31,     x31,     32
XOR     zero,    zero,    zero  ; HALT