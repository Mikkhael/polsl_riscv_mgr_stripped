JALR    zero,   zero,   %L1  ; Jump

ADDI    x31,    x31,    0x10   ; unreachable
ADDI    x31,    x31,    0x20   ; unreachable
ADDI    x31,    x31,    0x40   ; unreachable

L0:
JALR    zero,   zero,   %L2  ; Jump
JALR    zero,   zero,   %L2  ; Jump   ; predicted jump hardcoded 20 -> 44

ADDI    x31,    x31,    1   ; unreachable
XOR     zero,    zero,    zero  ; HALT
L1:
ADDI    x1,     x1,    0x01
JALR    zero,   zero,   %L0  ; Jump
ADDI    x31,    x31,    2    ; unreachable
ADDI    x31,    x31,    4    ; unreachable

L2: ; addr = 48
ADDI    x1,     x1,    0x010
ADDI    x1,     x1,    0x100
XOR     zero,    zero,    zero  ; HALT