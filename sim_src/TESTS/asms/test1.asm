    ADD x0,x0,x0
    ADD x0,x0,x0
    ADDI x2,x0,2
    ADDI x1,x0,0x11
    LUI x5,1
LOOP: 
    ADD  x1,x1,x1
    ADD  x5,x5,x1
    ADDI x2, x2,-1
    BNE  x2,x0, LOOP
    ADDI x5, x0, 1
    ADDI x0, x0, 1
    ADDI x0, x0, 3
    ADDI x0, x0, 7
    SLLI x1,   x1,1
    ADDI x1,   x1,-10
    ADDI x1,   x1,-0x10
    XOR  x0, x0, x0
