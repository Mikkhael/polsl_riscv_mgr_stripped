#include "common.h"

typedef long v_type;


void init_vector(v_type* v, long size, long base, long off) {
    long acc = base;
    for(long i=0; i<size; i++) {
        v[i] = acc;
        acc += off;
    }
}

void vector_add(v_type* v1, v_type* v2, v_type* v_dest, long size) {
    for(long i=0; i<size; i++) {
        v_dest[i] = v1[i] + v2[i];
    }
}

void vector_mul(v_type* v1, v_type* v2, v_type* v_dest, long size) {
    for(long i=0; i<size; i++) {
        v_dest[i] = v1[i] * v2[i];
    }
}


ENTRY() {
    RISCV_SETUP;
    const long size  = MEM_D(8);
    DEF_VAR(16,                           v_type, v1);
    DEF_VAR(16 + sizeof(v_type) * size,   v_type, v2);
    DEF_VAR(16 + sizeof(v_type) * size*2, v_type, v3);
    DEF_VAR(16 + sizeof(v_type) * size*3, v_type, v4);

    init_vector(v1, size, 1, 10);
    init_vector(v2, size, 4, -3);
    init_vector(v3, size, 0, size);
    init_vector(v4, size, -size, 1);

    vector_add(v1, v2, v1, size);
    vector_add(v3, v4, v3, size);
    vector_add(v1, v3, v2, size);
    vector_add(v2, v4, v1, size);
    
    // vector_mul(v1, v2, v1, size);
    // vector_mul(v3, v4, v3, size);
    // vector_mul(v1, v3, v2, size);
    // vector_mul(v2, v4, v1, size);

    RISCV_HALT;
}
