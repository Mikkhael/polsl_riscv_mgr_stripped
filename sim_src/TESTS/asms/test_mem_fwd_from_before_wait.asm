ADDI    x10,    x0,     0x70   ; x10 = 0x70
SD   	x0,     x10,    0x28   ; MEM[0x28] = 0x70
ADD     x0,     x0,     x0     ; NOOP
ADD     x0,     x0,     x0     ; NOOP
ADD     x0,     x0,     x0     ; NOOP
ADD     x0,     x0,     x0     ; NOOP
ADD     x0,     x0,     x0     ; NOOP
ADDI    x11,    x0,     0x13    ; x11 = 0x13
LD      x12,    x0,     0x28   ; load (MEM[0x28] = 0x70) to x12
ADD     x13,    x12,    x11    ; x13 = x12 + x11 (forward x11, wait for LD x12)
XOR     x0,     x0,     x0

