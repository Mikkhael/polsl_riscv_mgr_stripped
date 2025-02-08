#include "common.h"

static long factorial(long x) {
    if(x <= 0) return 1;
    return x * factorial(x - 1);
}

ENTRY() {
    RISCV_SETUP;
    MEM_D(16) = factorial(MEM_D(8));
    RISCV_HALT;
}