`ifdef USE_JUMP_PREDICTOR
import riscv_next_pkg::*;

module BTB_COUNTER #(
    parameter ADDR_WIDTH = 64,
    parameter INDEX_WIDTH = 3,
    parameter VALUE_WDITH = 64,
    parameter COUNTER_WIDTH = 1
)(
    input clk,
    input nreset,
    input enable,

    input i_stall,

    input  [ADDR_WIDTH-1  : 0] i_read_addr,
    output [VALUE_WDITH-1 : 0] o_read_value,
    output                     o_read_jump,
    output                     o_read_valid,

    input  [ADDR_WIDTH-1  : 0] i_write_addr,
    input  [VALUE_WDITH-1 : 0] i_write_value,
    input                      i_write_jump,
    input                      i_write_enable
);

localparam KEY_WIDTH   = ADDR_WIDTH - INDEX_WIDTH;
localparam ENTRIES_COUNT = 2**INDEX_WIDTH;

// localparam COUNTER_MAX    = 2**(COUNTER_WIDTH+1'd1) - 1'd1;
// localparam COUNTER_MIN    = 0;
// localparam COUNTER_HALF_1 = COUNTER_WIDTH == 0 ? 0 : 2**(COUNTER_WIDTH - 1);
// localparam COUNTER_HALF_0 = COUNTER_HALF_1 - 1'd1;
localparam COUNTER_MAX    = {COUNTER_WIDTH{1'b1}};
localparam COUNTER_MIN    = {COUNTER_WIDTH{1'b0}};
localparam COUNTER_HALF_1 = {1'b1, {(COUNTER_WIDTH - 1){1'b0}}};
localparam COUNTER_HALF_0 = {1'b0, {(COUNTER_WIDTH - 1){1'b1}}};

typedef struct packed {
    logic                    valid;
    logic [KEY_WIDTH-1:0]    key;
    logic [VALUE_WDITH-1:0]  value;
    logic [COUNTER_WIDTH-1:0] cnt;
} entry_t;

var  entry_t entries [0:ENTRIES_COUNT-1];

wire [INDEX_WIDTH-1:0] read_index_c  = i_read_addr [INDEX_WIDTH-1:0];
wire [INDEX_WIDTH-1:0] write_index_c = i_write_addr[INDEX_WIDTH-1:0];

wire [KEY_WIDTH-1:0]   read_key_c  = i_read_addr [ADDR_WIDTH-1:INDEX_WIDTH];
wire [KEY_WIDTH-1:0]   write_key_c = i_write_addr[ADDR_WIDTH-1:INDEX_WIDTH];

entry_t read_entry_c;
entry_t write_entry_c;

assign read_entry_c  = entries[ read_index_c];
assign write_entry_c = entries[write_index_c];

wire read_key_matches_c =  read_entry_c.valid && 
                           read_entry_c.key   == read_key_c;
wire write_key_matches_c = write_entry_c.valid && 
                           write_entry_c.key   == write_key_c;
wire write_counter_is_max_c = write_entry_c.cnt == COUNTER_MAX;
wire write_counter_is_min_c = write_entry_c.cnt == COUNTER_MIN;

wire [COUNTER_WIDTH-1:0] write_next_counter_c =  i_write_jump && (write_entry_c.cnt != COUNTER_MAX) ? write_entry_c.cnt + 1'd1 :
                                                !i_write_jump && (write_entry_c.cnt != COUNTER_MIN) ? write_entry_c.cnt - 1'd1 :
                                                                                                      write_entry_c.cnt;
reg [VALUE_WDITH-1:0] read_value_r;
reg read_jump_r;
reg read_valid_r;

`ifdef SIMULATION
    integer evicts = 0;
`endif
integer i;

always @(posedge clk) begin
    if(!nreset) begin
        for(i=0; i<ENTRIES_COUNT; i++) begin
            entries[i].valid = 1'd0;
        end
        read_valid_r = 1'd0;
    end else if(enable && !i_stall) begin
        
        // read
        read_value_r <= read_entry_c.value;
        read_jump_r  <= read_entry_c.cnt[COUNTER_WIDTH-1];
        read_valid_r <= read_key_matches_c;

        // write
        if(i_write_enable) begin
            if(write_key_matches_c) begin
                entries[write_index_c].cnt   <= write_next_counter_c;
                entries[write_index_c].value <= i_write_value;
            end else begin
                `ifdef SIMULATION
                evicts += write_entry_c.valid;
                `endif
                entries[write_index_c] <= '{
                    valid: 1'd1,
                    key:   write_key_c,
                    value: i_write_value,
                    cnt:   i_write_jump ? COUNTER_HALF_1 : COUNTER_HALF_0
                };
            end

        end
    end
end

assign o_read_valid = read_valid_r;
assign o_read_jump  = read_jump_r;
assign o_read_value = read_value_r;

endmodule
`endif