`ifdef USE_JUMP_PREDICTOR
`ifdef USE_BTB_COUNTER
module riscv_next_strategy_btb_counter # (
    parameter ADDR_WIDTH = 64
) (
    input clk,
    input enable,
    input nreset,
    input i_stall,

    riscv_next_strategy_from_pm_intf intf,
    riscv_next_strategy_history_intf hist
);

    localparam BTB_ADDR_WIDTH    = ADDR_WIDTH - 2;
    localparam BTB_INDEX_WIDTH   = `BTB_INDEX_WIDTH;
    localparam BTB_COUNTER_WIDTH = `BTB_COUNTER_WIDTH;
    localparam BTB_VALUE_WIDTH   = BTB_ADDR_WIDTH;

    wire [BTB_ADDR_WIDTH-1 : 0] btb_read_value_c;
    wire                        btb_read_jump_c;
    wire                        btb_read_valid_c;

    wire hist_could_jump = hist.i_signals.jal || hist.i_signals.jalr || hist.i_signals.branch;
    wire btb_write_enable = hist_could_jump && !hist.i_flush;

    BTB_COUNTER #(
        .ADDR_WIDTH     (BTB_ADDR_WIDTH),
        .INDEX_WIDTH    (BTB_INDEX_WIDTH),
        .VALUE_WDITH    (BTB_VALUE_WIDTH),
        .COUNTER_WIDTH  (BTB_COUNTER_WIDTH)
    ) btb (
        .clk    (clk),
        .nreset (nreset),
        .enable (enable),
        .i_stall (i_stall),

        .i_read_addr    (intf.i_if_pc[BTB_ADDR_WIDTH+1 : 2]),
        .o_read_value   (btb_read_value_c),
        .o_read_jump    (btb_read_jump_c),
        .o_read_valid   (btb_read_valid_c),

        .i_write_addr   (hist.i_pc[BTB_ADDR_WIDTH+1 : 2]),
        .i_write_value  (hist.i_jump_addr[BTB_ADDR_WIDTH+1 : 2]),
        .i_write_jump   (hist.i_jump_branch),
        .i_write_enable (btb_write_enable)
    );

    assign intf.o_inject       = btb_read_valid_c && btb_read_jump_c;
    assign intf.o_inject_addr  = {btb_read_value_c, 2'b00};

endmodule
`endif
`endif