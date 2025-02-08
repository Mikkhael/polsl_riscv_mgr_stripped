JAL     x1,     L1              ; JUMP to L1 
XOR     zero,    zero,    zero  ; HALT

L2:
ADDI    x2,     x2,     4
ADDI    x2,     x2,     8
ADDI    x2,     x2,     16
JALR    zero,   x1,     0  ; RET   ; predicted jump hardcoded 20 -> 44

ADDI    x31,    x31,    4   ; unreachable
ADDI    x31,    x31,    8   ; unreachable

L1:
ADDI    x2,     x2,    1
ADDI    x2,     x2,    2
JAL     x1,     L2          ; CALL L2

; addr = 44
ADDI    x3,     x3,     1
ADDI    x4,     x4,     1
ADDI    x5,     x5,     1
ADDI    x6,     x6,     1
ADDI    x7,     x7,     1
JALR    zero,   x1,     0  ; RET