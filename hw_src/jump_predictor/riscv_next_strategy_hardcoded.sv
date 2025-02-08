`ifdef USE_JUMP_PREDICTOR
module riscv_next_strategy_hardcoded # (
    parameter ADDR_WIDTH = 64
) (
    input clk,
    input enable,
    input nreset,
    input i_stall,

    riscv_next_strategy_from_pm_intf intf
);

    `ifdef HARDCODED_FROM
    assign intf.o_inject       = intf.i_pm_pc == `HARDCODED_FROM;
    assign intf.o_inject_addr  = `HARDCODED_TO;
    `else
    assign intf.o_inject       = intf.i_pm_pc == 20;
    assign intf.o_inject_addr  = 44;
    `endif

endmodule
`endif