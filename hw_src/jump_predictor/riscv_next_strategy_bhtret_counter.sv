`ifdef USE_JUMP_PREDICTOR
`ifdef USE_BTB_COUNTER
`ifdef BHT_HIST_WIDTH
`ifdef RET_INDEX_WIDTH
module riscv_next_strategy_bhtret_counter # (
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
    localparam BTB_VALUE_WIDTH   = BTB_ADDR_WIDTH + 1;

    wire [BTB_VALUE_WIDTH-1 : 0] btb_read_value_c;
    wire                         btb_read_value_branch_c = btb_read_value_c[BTB_VALUE_WIDTH-1];
    wire [BTB_ADDR_WIDTH-1  : 0] btb_read_value_addr_c   = btb_read_value_c[BTB_VALUE_WIDTH-2 : 0];
    wire                         btb_read_jump_c;
    wire                         btb_read_valid_c;

    wire  [BTB_VALUE_WIDTH-1 : 0] btb_write_value_c = { 
        hist.i_signals.branch, 
        hist.i_jump_addr[BTB_ADDR_WIDTH+1 : 2]
    };

    wire hist_could_jump = hist.i_signals.jal || hist.i_signals.jalr || hist.i_signals.branch;
    wire hist_was_branch = hist.i_signals.branch;
    wire hist_was_ret    = hist.i_signals.jalr && hist.i_signals.rs1_ra;

    wire btb_write_enable = hist_could_jump && !hist_was_ret && !hist.i_flush;

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
        .i_write_value  (btb_write_value_c),
        .i_write_jump   (hist.i_jump_branch),
        .i_write_enable (btb_write_enable)
    );

    localparam BHT_ADDR_WIDTH    = ADDR_WIDTH - 2;
    localparam BHT_HIST_WIDTH    = `BHT_HIST_WIDTH;
    localparam BHT_COUNTER_WIDTH = `BHT_COUNTER_WIDTH;

    wire bht_read_jump_c;
    wire bht_read_valid_c;

    wire bht_shift_read   = btb_read_value_branch_c && bht_read_valid_c && btb_read_valid_c && !intf.i_pm_flush;
    wire bht_write_enable = hist_was_branch && !hist.i_flush;

    HIST_COUNTER #(
        .ADDR_WIDTH     (BHT_ADDR_WIDTH),
        .HIST_WIDTH     (BHT_HIST_WIDTH),
        .COUNTER_WIDTH  (BHT_COUNTER_WIDTH)
    ) bht (
        .clk    (clk),
        .nreset (nreset),
        .enable (enable),
        .i_stall (i_stall),

        .i_flush_read_hisotry (intf.i_pm_flush),
        .i_shift_read_history (bht_shift_read),
        .i_read_addr    (intf.i_if_pc[BHT_ADDR_WIDTH+1 : 2]),
        .o_read_jump    (bht_read_jump_c),
        .o_read_valid   (bht_read_valid_c),

        .i_write_addr   (hist.i_pc[BHT_ADDR_WIDTH+1 : 2]),
        .i_write_jump   (hist.i_jump_branch),
        .i_write_enable (bht_write_enable)
    );


    localparam RET_ADDR_WIDTH    = ADDR_WIDTH - 2;
    localparam RET_INDEX_WIDTH   = `RET_INDEX_WIDTH;

    wire ret_table_read_valid_c;

    wire ret_table_write_enable_c = hist_was_ret && !hist.i_flush;

    RET_TABLE #(
        .ADDR_WIDTH     (RET_ADDR_WIDTH),
        .INDEX_WIDTH    (RET_INDEX_WIDTH)
    ) ret_table (
        .clk    (clk),
        .nreset (nreset),
        .enable (enable),
        .i_stall (i_stall),

        .i_read_addr    (intf.i_if_pc[BHT_ADDR_WIDTH+1 : 2]),
        .o_read_valid   (ret_table_read_valid_c),

        .i_write_addr   (hist.i_pc[BHT_ADDR_WIDTH+1 : 2]),
        .i_write_enable (ret_table_write_enable_c)
    );

    assign intf.o_inject = ret_table_read_valid_c || (btb_read_valid_c && (
        (btb_read_value_branch_c && bht_read_valid_c) ? bht_read_jump_c :
                                                        btb_read_jump_c ));
    assign intf.o_inject_addr  = ret_table_read_valid_c ? intf.i_ra_data : {btb_read_value_addr_c, 2'b00};

endmodule
`endif
`endif
`endif
`endif