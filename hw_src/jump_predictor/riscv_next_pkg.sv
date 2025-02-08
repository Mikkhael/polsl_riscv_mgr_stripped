import riscv_pkg::*;
package riscv_next_pkg;

    typedef struct packed {
        logic jal;
        logic jalr;
        logic branch;
        logic rs1_zero;
        logic rs1_ra;
        logic imm_sign;
        logic [32-1 : 0] imm;
    } next_instr_signals_t; 

endpackage