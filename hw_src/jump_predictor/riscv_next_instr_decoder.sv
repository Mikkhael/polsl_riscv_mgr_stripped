import riscv_pkg::*;
import riscv_next_pkg::*;

module riscv_next_instr_decoder #(
    parameter INSTR_WIDTH = 32,
    parameter ADDR_WIDTH = 64
) (
    input [INSTR_WIDTH-1:0] i_instr,
    input                   i_flush,
    output next_instr_signals_t o_signals
);

 
    assign o_signals.jal      = !i_flush && i_instr[6:0] == JAL;
    assign o_signals.jalr     = !i_flush && i_instr[6:0] == JALR;
    assign o_signals.branch   = !i_flush && i_instr[6:0] == BEQ_BNE_BLT_BGE_BLTU_BGEU;

    assign o_signals.rs1_zero = i_instr[19:15] == 5'd0;
    assign o_signals.rs1_ra   = i_instr[19:15] == 5'd1;

    wire imm_sign_c = i_instr[31];
    wire [ADDR_WIDTH-1:0] imm_i_c = $signed({imm_sign_c,  i_instr[31:20]});
    wire [ADDR_WIDTH-1:0] imm_j_c = $signed({imm_sign_c,  i_instr[19:12], i_instr[20],    i_instr[30:21], 1'h0});
    wire [ADDR_WIDTH-1:0] imm_b_c = $signed({imm_sign_c,  i_instr[7],     i_instr[30:25], i_instr[11:8],  1'h0});
    assign o_signals.imm_sign   = imm_sign_c;
    assign o_signals.imm        = o_signals.jal  ? imm_j_c :
                                  o_signals.jalr ? imm_i_c :
                                                   imm_b_c;
  
endmodule