
ADDI    x10,    zero,   0x23
SD      zero,   x10,    0x10   ; STORE 0x23 at addr 0x10
ADDI    zero,   zero,   0 ; NOOP
ADDI    zero,   zero,   0 ; NOOP
ADDI    zero,   zero,   0 ; NOOP

BLT     zero,   zero,   L2  ; No Jump   ; predicted jump hardcoded 20 -> 44

ADDI    zero,   zero,   0 ; NOOP
ADDI    zero,   zero,   0 ; NOOP
ADDI    zero,   zero,   0 ; NOOP
ADDI    zero,   zero,   0 ; NOOP
LD      x11,    zero,   0x10   ; LOAD addr 0x10 to x11 (x11 = 0x23) ; Jas to be executed

L2: ; addr = 44
XOR     zero,   zero,   zero