
ADDI    x10,    zero,   0x23
SD      zero,   x10,    0x10   ; STORE 0x23 at addr 0x10
SD      zero,   x10,    0x18   ; STORE 0x23 at addr 0x10
SD      zero,   x10,    0x20   ; STORE 0x23 at addr 0x10
SD      zero,   x10,    0x28   ; STORE 0x23 at addr 0x10

BLT     zero,   zero,   L2  ; No Jump   ; predicted jump hardcoded 20 -> 44

LD      x11,    zero,   0x10   ; LOAD addr 0x10 to x11 (x11 = 0x23) ; Jas to be executed
LD      x12,    zero,   0x18   ; LOAD addr 0x10 to x11 (x11 = 0x23) ; Jas to be executed
LD      x13,    zero,   0x20   ; LOAD addr 0x10 to x11 (x11 = 0x23) ; Jas to be executed
LD      x14,    zero,   0x28   ; LOAD addr 0x10 to x11 (x11 = 0x23) ; Jas to be executed
XOR     zero,    zero,    zero  ; HALT

L2: ; addr = 44