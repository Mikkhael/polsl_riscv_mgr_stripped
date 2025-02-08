
BEQ     zero,   zero,   L1  ; Jump

ADDI    x31,    x31,    0x10   ; unreachable
ADDI    x31,    x31,    0x20   ; unreachable
ADDI    x31,    x31,    0x40   ; unreachable
ADDI    x31,    x31,    0x80   ; unreachable

L0:
BLT     zero,   zero,   L2  ; No Jump   ; predicted jump hardcoded 20 -> 44

ADDI    x1,     x1,    0x010
XOR     zero,    zero,    zero  ; HALT
L1:
ADDI    x1,     x1,    0x01
BEQ     zero,   zero,   L0  ; Jump
ADDI    x31,    x31,    2   ; unreachable

L2: ; addr = 44
ADDI    x31,    x31,    4   ; unreachable
ADDI    x31,    x31,    8   ; unreachable
XOR     zero,    zero,    zero  ; HALT