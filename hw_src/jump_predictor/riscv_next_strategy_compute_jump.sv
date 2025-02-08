`ifdef USE_JUMP_PREDICTOR
import riscv_next_pkg::*;

module riscv_next_strategy_compute_jump # (
    parameter ADDR_WIDTH = 64,
    parameter INSTR_WIDTH = 64
) (
    input clk,
    input enable,
    input nreset,

    riscv_next_strategy_from_id_intf intf
);

    wire relative_jump_c = intf.i_id_signals.jal;
    wire absolute_jump_c = intf.i_id_signals.jalr && intf.i_id_signals.rs1_zero;

    wire [ADDR_WIDTH-1:0] relative_jump_addr_c = $signed(intf.i_id_signals.imm) + $signed(intf.i_id_pc);
    wire [ADDR_WIDTH-1:0] absolute_jump_addr_c = $signed(intf.i_id_signals.imm);

    assign intf.o_inject        = (relative_jump_c || absolute_jump_c) && !intf.i_id_flush;
    assign intf.o_inject_addr   = relative_jump_c ? relative_jump_addr_c : absolute_jump_addr_c;

endmodule
`endif