#include "common.h"

ENTRY() {
    RISCV_SETUP;
    long a = MEM_D(8);
    long b = MEM_D(16);
    MEM_D(24) = a * b;
    RISCV_HALT;
}