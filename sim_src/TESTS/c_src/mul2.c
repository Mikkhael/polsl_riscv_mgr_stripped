#include "common.h"

ENTRY() {
    RISCV_SETUP;
    long a = MEM_D(8);
    long b = MEM_D(16);
    MEM_D(24) = a * b;
    MEM_D(32) = (a+1)  * (b-1);
    MEM_D(40) = (a+10) * (b*2);
    MEM_D(48) = (a+b)  * (a-b);
    RISCV_HALT;
}