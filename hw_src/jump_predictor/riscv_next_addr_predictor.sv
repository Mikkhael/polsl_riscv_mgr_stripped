
`ifdef USE_JUMP_PREDICTOR
import riscv_next_pkg::*;

module riscv_next_addr_predictor # (
    parameter ADDR_WIDTH = 64,
    parameter INSTR_WIDTH = 32
)(
    input clk,
    input enable,
    input nreset,

    input i_stall,

    // input                   i_ex_jump, 
    input [ADDR_WIDTH-1:0]  i_if_pc,            // address at which to make the next prediction

    input                   i_pm_flush,
    input                   i_id_flush,

    input [INSTR_WIDTH-1:0] i_id_inst,
    // input                   i_id_jump,
    // input                   i_id_branch,

    // Output of EX stage
    input                   i_ex_jump_branch,   // jump should occur now
    input [ADDR_WIDTH-1:0]  i_ex_jump_addr,     // address to possibly jump to now
    input                   i_ex_o_flush,

    input [ADDR_WIDTH-1:0]  i_ra_data,

    output                  o_discard_jump,
    output                  o_rollback_jump,
    output                  o_pm_flush,
    output                  o_if_inject,
    output [ADDR_WIDTH-1:0] o_if_inject_addr,
    output [ADDR_WIDTH-1:0] o_rollback_jump_addr

);
    wire predictor_enable_c = enable && !i_stall;

    next_instr_signals_t id_signals_c;
    riscv_next_instr_decoder #(
        .INSTR_WIDTH(INSTR_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) riscv_next_instr_decoder (
        .i_instr    (i_id_inst),
        .i_flush    (i_id_flush),
        .o_signals  (id_signals_c)
    );

    // Controlled signals
    wire                    discard_jump_c;
    wire                    rollback_jump_c;
    wire                    pm_inject_flush_c;
    wire [ADDR_WIDTH-1:0]   rollback_jump_addr_c;
    wire                    if_inject_c;
    wire [ADDR_WIDTH-1:0]   if_inject_addr_c;
    
    
    wire                    inject_from_pm_c;
    wire [ADDR_WIDTH-1:0]   inject_from_pm_addr_c;
    wire                    inject_from_id_c;
    wire [ADDR_WIDTH-1:0]   inject_from_id_addr_c;

    // Pipelining made predictions from IF to EX
    reg                     pm_inject_r;
    reg                     id_inject_r;
    reg                     ex_inject_r;
    // reg                     old_inject_r;
    reg [ADDR_WIDTH-1:0]    pm_inject_addr_r;
    reg [ADDR_WIDTH-1:0]    id_inject_addr_r;
    reg [ADDR_WIDTH-1:0]    ex_inject_addr_r;
    // reg [ADDR_WIDTH-1:0]    old_inject_addr_r;
    reg [ADDR_WIDTH-1:0]    pm_pc_r;
    reg [ADDR_WIDTH-1:0]    id_pc_r;
    reg [ADDR_WIDTH-1:0]    ex_pc_r;
    reg [ADDR_WIDTH-1:0]    old_pc_r;
    var next_instr_signals_t ex_signals_r;
    var next_instr_signals_t old_signals_r;
    
    // DEBUG and STATICSTICS
    reg                     ex_jump_r;
    reg                     old_jump_r;
    reg                     ex_branch_r;
    reg                     old_branch_r;
    reg                     id_pm_inject_flush_r;
    reg                     ex_pm_inject_flush_r;
    
    riscv_next_strategy_from_pm_intf #(
        .ADDR_WIDTH (ADDR_WIDTH)
    ) riscv_next_strategy_from_pm_intf_c(
        .i_if_pc       (i_if_pc),
        .i_pm_pc       (pm_pc_r),
        .i_pm_flush    (i_pm_flush),
        .i_ra_data     (i_ra_data),
        .o_inject      (inject_from_pm_c),
        .o_inject_addr (inject_from_pm_addr_c)
    );

    riscv_next_strategy_from_id_intf #(
        .ADDR_WIDTH (ADDR_WIDTH)
    ) riscv_next_strategy_from_id_intf_c(
        .i_id_pc       (id_pc_r),
        .i_id_flush    (i_id_flush),
        .i_id_signals  (id_signals_c),
        .i_ra_data     (i_ra_data),
        .o_inject      (inject_from_id_c),
        .o_inject_addr (inject_from_id_addr_c)
    );

    riscv_next_strategy_history_intf #(
        .ADDR_WIDTH (ADDR_WIDTH)
    ) riscv_next_strategy_history_intf_c(
        .i_pc           (old_pc_r),
        .i_flush        (i_ex_o_flush),
        .i_jump_branch  (i_ex_jump_branch),
        .i_jump_addr    (i_ex_jump_addr),
        .i_signals      (old_signals_r)
    );
    
    // assign inject_from_pm_c         = riscv_next_strategy_intf_c.o_inject_from_pm;
    // assign inject_from_pm_addr_c    = riscv_next_strategy_intf_c.o_inject_from_pm_addr;
    // assign inject_from_id_c         = riscv_next_strategy_intf_c.o_inject_from_id;
    // assign inject_from_id_addr_c    = riscv_next_strategy_intf_c.o_inject_from_id_addr;

    `ifndef SIMULATION 
    generate
    `endif
    
    if(`JUMP_PREDICTOR_FROM_PM == "random") begin : pm_strategy_generate
        riscv_next_strategy_random          #(.ADDR_WIDTH(ADDR_WIDTH)) riscv_next_strategy_pm (.clk(clk), .enable(enable), .nreset(nreset), .i_stall(i_stall), .intf(riscv_next_strategy_from_pm_intf_c));
    end else if(`JUMP_PREDICTOR_FROM_PM == "hardcoded") begin : pm_strategy_generate
        riscv_next_strategy_hardcoded       #(.ADDR_WIDTH(ADDR_WIDTH)) riscv_next_strategy_pm (.clk(clk), .enable(enable), .nreset(nreset), .i_stall(i_stall), .intf(riscv_next_strategy_from_pm_intf_c));
    end else if(`JUMP_PREDICTOR_FROM_PM == "btb") begin : pm_strategy_generate
        riscv_next_strategy_btb_counter     #(.ADDR_WIDTH(ADDR_WIDTH)) riscv_next_strategy_pm (.clk(clk), .enable(enable), .nreset(nreset), .i_stall(i_stall), .intf(riscv_next_strategy_from_pm_intf_c), .hist(riscv_next_strategy_history_intf_c));
    end else if(`JUMP_PREDICTOR_FROM_PM == "bht") begin : pm_strategy_generate
        riscv_next_strategy_bht_counter     #(.ADDR_WIDTH(ADDR_WIDTH)) riscv_next_strategy_pm (.clk(clk), .enable(enable), .nreset(nreset), .i_stall(i_stall), .intf(riscv_next_strategy_from_pm_intf_c), .hist(riscv_next_strategy_history_intf_c));
    end else if(`JUMP_PREDICTOR_FROM_PM == "bhtret") begin : pm_strategy_generate
        riscv_next_strategy_bhtret_counter  #(.ADDR_WIDTH(ADDR_WIDTH)) riscv_next_strategy_pm (.clk(clk), .enable(enable), .nreset(nreset), .i_stall(i_stall), .intf(riscv_next_strategy_from_pm_intf_c), .hist(riscv_next_strategy_history_intf_c));
    end else begin : pm_strategy_generate
        assign inject_from_pm_c = 1'b0;
    end

    if(`JUMP_PREDICTOR_FROM_ID == "jump") begin : id_strategy_generate
        riscv_next_strategy_compute_jump     #(.ADDR_WIDTH(ADDR_WIDTH), .INSTR_WIDTH(INSTR_WIDTH)) riscv_next_strategy_id (.clk(clk), .enable(enable), .nreset(nreset), .intf(riscv_next_strategy_from_id_intf_c));
    end else if(`JUMP_PREDICTOR_FROM_ID == "jumpret") begin : id_strategy_generate
        riscv_next_strategy_compute_jump_ret #(.ADDR_WIDTH(ADDR_WIDTH), .INSTR_WIDTH(INSTR_WIDTH)) riscv_next_strategy_id (.clk(clk), .enable(enable), .nreset(nreset), .intf(riscv_next_strategy_from_id_intf_c));
    end else begin : id_strategy_generate
        assign inject_from_id_c = 1'b0;
    end
    
    `ifndef SIMULATION 
    endgenerate
    `endif

    // During RTL simulation, assume that if the injection was dependent on an 'x' value, the injection happened, but at a wrong address
    // The 'x' state can appear, if we predicted the inject based on an out-of-bound fetched instruction in 'id'
    // Checking for flushed 'id' could also help
    // Otherwise, the pipeline will be floded with PC=X, because the predictor doesn't know, if it should rollback, or what to do with accual jumps
    // We have to assure, all the propagated X'es will be flushed, either by an accual jump, or by a rollback
    `ifdef SIMULATION
        wire                  true_ex_inject_r      = $isunknown(ex_inject_r)      ?               1'd1 : ex_inject_r;
        wire [ADDR_WIDTH-1:0] true_ex_inject_addr_r = $isunknown(ex_inject_addr_r) ?  (~i_ex_jump_addr) : ex_inject_addr_r;
    `else
        wire                  true_ex_inject_r      = ex_inject_r;
        wire [ADDR_WIDTH-1:0] true_ex_inject_addr_r = ex_inject_addr_r;
    `endif
    
    // Automatic rollabck and discarding
    wire was_prediction_flushed = i_ex_o_flush;
    assign discard_jump_c   =  i_ex_jump_branch && !was_prediction_flushed && true_ex_inject_r && (i_ex_jump_addr == true_ex_inject_addr_r); // Correctly predicted executed jump
    assign rollback_jump_c  = !i_ex_jump_branch && !was_prediction_flushed && true_ex_inject_r; // Incorrectly predicted no-jump

    assign rollback_jump_addr_c = old_pc_r + 3'd4;

    // Pipelining made predictions from IF to EX
    always @(posedge clk) begin
        if(!nreset) begin
            pm_inject_r         <= 1'd0;
            id_inject_r         <= 1'd0;
            ex_inject_r         <= 1'd0;
            // old_inject_r        <= 1'd0;
            pm_inject_addr_r    <= 0;
            id_inject_addr_r    <= 0;
            ex_inject_addr_r    <= 0;
            // old_inject_addr_r   <= 0;
            pm_pc_r  <= 0;
            id_pc_r  <= 0;
            ex_pc_r  <= 0;
            old_pc_r <= 0;
            ex_signals_r  <= '{default:0};
            old_signals_r <= '{default:0};
            `ifdef SIMULATION
            ex_jump_r  <= 1'b0;
            old_jump_r <= 1'b0;
            ex_branch_r  <= 1'b0;
            old_branch_r <= 1'b0;
            id_pm_inject_flush_r  <= 1'b0;
            ex_pm_inject_flush_r  <= 1'b0;
            `endif
        end
        else if(predictor_enable_c) begin
            pm_inject_r         <= pm_inject_flush_c ? 1'd0        : if_inject_c;
            id_inject_r         <= pm_inject_flush_c ? if_inject_c : pm_inject_r;
            ex_inject_r         <= id_inject_r;
            // old_inject_r        <= ex_inject_r;
            pm_inject_addr_r    <= if_inject_addr_c;
            id_inject_addr_r    <= pm_inject_flush_c ? if_inject_addr_c : pm_inject_addr_r;
            ex_inject_addr_r    <= id_inject_addr_r;
            // old_inject_addr_r   <= ex_inject_addr_r;
            pm_pc_r  <= i_if_pc;
            id_pc_r  <= pm_pc_r; // pm_inject_flush_c ? i_if_pc : pm_pc_r;
            ex_pc_r  <= id_pc_r;
            old_pc_r <= ex_pc_r;
            ex_signals_r  <= id_signals_c;
            old_signals_r <= ex_signals_r;
            `ifdef SIMULATION
            // DEBUG and STATISCITS
            ex_jump_r  <= id_signals_c.jal || id_signals_c.jalr;
            old_jump_r <= ex_jump_r;
            ex_branch_r  <= id_signals_c.branch;
            old_branch_r <= ex_branch_r;
            id_pm_inject_flush_r  <= pm_inject_flush_c;
            ex_pm_inject_flush_r  <= id_pm_inject_flush_r;
            `endif
        end
    end
    
    wire inject_from_id_matches_pm_c = pm_inject_r && (inject_from_id_addr_c == pm_inject_addr_r); // last prediction from pm gave the same prediction as current from id
    assign pm_inject_flush_c         = inject_from_id_c && !inject_from_id_matches_pm_c;
    assign if_inject_c               = inject_from_pm_c || pm_inject_flush_c;
    assign if_inject_addr_c          = pm_inject_flush_c ? inject_from_id_addr_c :
                                                           inject_from_pm_addr_c;
    

    assign o_discard_jump          = (enable && nreset)                     ? discard_jump_c        : 1'd0;
    assign o_rollback_jump         = (enable && nreset)                     ? rollback_jump_c       : 1'd0;
    assign o_rollback_jump_addr    = (enable && nreset)                     ? rollback_jump_addr_c  : 0;
    assign o_pm_flush              = (enable && nreset && !rollback_jump_c) ? pm_inject_flush_c     : 1'd0;
    assign o_if_inject             = (enable && nreset && !rollback_jump_c) ? if_inject_c           : 1'd0;
    assign o_if_inject_addr        = (enable && nreset && !rollback_jump_c) ? if_inject_addr_c      : 0;


endmodule
    

`endif