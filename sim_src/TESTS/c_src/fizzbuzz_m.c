#include "common.h"

static long do_fizz(long i) {
    static long counter = 0;
    counter += 1;
    return i + counter;
}

static long do_buzz(long i) {
    static long counter = 0;
    counter += 1;
    return i - counter;
}

ENTRY() {
    RISCV_SETUP;
    const long limit = MEM_D(8);
    long mem_offset = 1024;
    int i_mod_3 = 1;
    int i_mod_5 = 1;
    for(long i = 1; i <= limit; i++) {
        if(i_mod_3 == 0 && i_mod_5 == 0) {
            MEM_D(mem_offset) = do_fizz(i);
        } else if (i_mod_3 == 0) {
            MEM_D(mem_offset) = do_buzz(i);
        } else if (i_mod_5 == 0) {
            MEM_D(mem_offset) = do_fizz(i) ^ do_buzz(i);
        } else {
            MEM_D(mem_offset) = i;
        }
        mem_offset += 8;
        i_mod_3 = i_mod_3 == 2 ? 0 : i_mod_3 + 1;
        i_mod_5 = i_mod_5 == 4 ? 0 : i_mod_5 + 1;
    }
    RISCV_HALT;
}