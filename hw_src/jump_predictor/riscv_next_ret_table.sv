`ifdef USE_JUMP_PREDICTOR
import riscv_next_pkg::*;

module RET_TABLE #(
    parameter ADDR_WIDTH = 64,
    parameter INDEX_WIDTH = 3
)(
    input clk,
    input nreset,
    input enable,

    input i_stall,

    input  [ADDR_WIDTH-1  : 0] i_read_addr,
    output                     o_read_valid,

    input  [ADDR_WIDTH-1  : 0] i_write_addr,
    input                      i_write_enable
);

localparam KEY_WIDTH   = ADDR_WIDTH - INDEX_WIDTH;
localparam ENTRIES_COUNT = 2**INDEX_WIDTH;

typedef struct packed {
    logic                    valid;
    logic [KEY_WIDTH-1:0]    key;
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

wire read_key_matches_c = read_entry_c.valid && 
                          read_entry_c.key   == read_key_c;

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
        read_valid_r <= read_key_matches_c;

        // write
        if(i_write_enable) begin
            `ifdef SIMULATION
            evicts += write_entry_c.valid && write_entry_c.key != write_key_c;
            // $display(" ---- RET PUSH ar addr %h (idx %h, key %h) -> was %b", i_write_addr, write_index_c, write_key_c, write_entry_c.valid)
            `endif
            entries[write_index_c] <= '{
                valid: 1'd1,
                key:   write_key_c
            };
        end
    end
end

assign o_read_valid = read_valid_r;

endmodule
`endif