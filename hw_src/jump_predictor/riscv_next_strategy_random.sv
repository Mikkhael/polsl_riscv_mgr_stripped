`ifdef USE_JUMP_PREDICTOR
module riscv_next_strategy_random # (
    parameter ADDR_WIDTH = 64,
    parameter OFFSET = 5
) (
    input clk,
    input enable,
    input nreset,
    input i_stall,

    riscv_next_strategy_from_pm_intf intf
);

    wire [31:0] rng_res;

    reg [ADDR_WIDTH-1:0] last_pm_pc;
    always @(posedge clk) begin
        if(!nreset) begin
            last_pm_pc <= 0;
        end else if(enable) begin
            last_pm_pc <= intf.i_pm_pc;
        end
    end

    // never predict itself and next instruction, predict once every 4 instructions
    assign intf.o_inject      = rng_res[OFFSET-1:0] != 0 && rng_res[OFFSET-1:0] != 1 && rng_res[31:30] == 0;
    assign intf.o_inject_addr = $signed({rng_res[OFFSET-1:0], 2'b00}) + intf.i_pm_pc;

    wire generate_new_rng = enable && (intf.i_pm_pc != last_pm_pc);

    RNG rng (
        .clk        (clk),
        .enable     (generate_new_rng),
        .nreset     (nreset),
        .res        (rng_res)
    );


endmodule

module RNG(
    input clk,
    input enable,
    input nreset,
    output wire [31:0] res
);

localparam [31:0] init_state = 32'd2463534242;
localparam [31:0] multiplier = 32'd3084775641;

reg [31:0] state;
reg [63:0] mul_res;

assign res = mul_res[63:32];

always @(posedge clk) begin
    if(!nreset) begin
        state   = init_state;
        mul_res = 0;
    end else if(enable) begin
        state ^= (state << 13);
        state ^= (state >> 17);
        state ^= (state << 5);
        mul_res = state * multiplier;
        mul_res[63:32] = state;
    end
end


endmodule
`endif