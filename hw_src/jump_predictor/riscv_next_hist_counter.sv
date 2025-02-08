`ifdef USE_JUMP_PREDICTOR
import riscv_next_pkg::*;

module HIST_COUNTER #(
    parameter ADDR_WIDTH = 64,
    parameter HIST_WIDTH = 10,
    parameter COUNTER_WIDTH = 2,

    parameter WRITE_CYCLES_OFFSET = 2
)(
    input clk,
    input nreset,
    input enable,

    input i_stall,

    input                      i_flush_read_hisotry,
    input                      i_shift_read_history,
    input  [ADDR_WIDTH-1  : 0] i_read_addr,
    output                     o_read_jump,
    output                     o_read_valid,

    input  [ADDR_WIDTH-1  : 0] i_write_addr,
    input                      i_write_jump,
    input                      i_write_enable
);

localparam INDEX_WIDTH   = HIST_WIDTH;
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
    logic                     valid;
    logic [COUNTER_WIDTH-1:0] cnt;
} entry_t;

var  entry_t entries [0:ENTRIES_COUNT-1];

localparam EXT_HIST_WIDTH = HIST_WIDTH > WRITE_CYCLES_OFFSET ? HIST_WIDTH : WRITE_CYCLES_OFFSET;

reg  [EXT_HIST_WIDTH - 1 : 0] read_history_r;
reg  [HIST_WIDTH - 1 : 0]     write_history_r;
reg  [$clog2(WRITE_CYCLES_OFFSET) - 1 : 0] speculative_offset_r;

wire expected_write_jump_c = {read_history_r, 1'b0} >> speculative_offset_r;
wire was_last_prediction_wrong_c = (speculative_offset_r == 0 || expected_write_jump_c != i_write_jump) && i_write_enable;

wire [INDEX_WIDTH-1:0] read_index_c  = i_read_addr [INDEX_WIDTH-1:0] ^ read_history_r[HIST_WIDTH-1:0];
wire [INDEX_WIDTH-1:0] write_index_c = i_write_addr[INDEX_WIDTH-1:0] ^ write_history_r;

// wire [KEY_WIDTH-1:0]   read_key_c  = i_read_addr [ADDR_WIDTH-1:INDEX_WIDTH];
// wire [KEY_WIDTH-1:0]   write_key_c = i_write_addr[ADDR_WIDTH-1:INDEX_WIDTH];

entry_t read_entry_c;
entry_t write_entry_c;

assign read_entry_c  = entries[ read_index_c];
assign write_entry_c = entries[write_index_c];

// wire          read_key_matches_c =  read_entry_c.valid && 
//                                     read_entry_c.key   == read_key_c;
// wire write_key_and_val_matches_c = write_entry_c.valid && 
//                                    write_entry_c.key   == write_key_c && 
//                                    write_entry_c.value == i_write_value;
wire          read_key_matches_c =  read_entry_c.valid;
wire write_key_and_val_matches_c = write_entry_c.valid;
wire write_counter_is_max_c = write_entry_c.cnt == COUNTER_MAX;
wire write_counter_is_min_c = write_entry_c.cnt == COUNTER_MIN;

wire [COUNTER_WIDTH-1:0] write_next_counter_c =  i_write_jump && (write_entry_c.cnt != COUNTER_MAX) ? write_entry_c.cnt + 1'd1 :
                                                !i_write_jump && (write_entry_c.cnt != COUNTER_MIN) ? write_entry_c.cnt - 1'd1 :
                                                                                                      write_entry_c.cnt;
// reg  [VALUE_WDITH-1:0]   read_value_r;
reg read_jump_r;
reg read_valid_r;

wire [EXT_HIST_WIDTH-1 : 0] shifted_read_history_c  = {read_history_r , read_jump_r};
wire [HIST_WIDTH-1 : 0]     shifted_write_history_c = {write_history_r, i_write_jump};
wire [HIST_WIDTH-1 : 0]     next_write_history_c = i_write_enable ? shifted_write_history_c : write_history_r;

`ifdef SIMULATION
    integer evicts = 0;
`endif
integer i;

always @(posedge clk) begin
    if(!nreset) begin
        for(i=0; i<ENTRIES_COUNT; i++) begin
            entries[i].valid <= 1'd0;
        end
        read_valid_r <= 1'd0;
        read_jump_r  <= 1'd0;
        read_history_r       <= 0;
        write_history_r      <= 0;
        speculative_offset_r <= 0;
    end else if(enable && !i_stall) begin
        
        // read
        // read_value_r <= read_entry_c.value;
        read_jump_r  <= read_entry_c.cnt[COUNTER_WIDTH-1];
        read_valid_r <= read_key_matches_c;

        // update read history and speculative offset
        if(was_last_prediction_wrong_c || i_flush_read_hisotry) begin // czy był źle przewidziany skok
            read_history_r       <= next_write_history_c;
            speculative_offset_r <= 0;
        end else begin
            if( (i_shift_read_history) && (!i_write_enable))
                speculative_offset_r <= speculative_offset_r + 1'd1;
            if((!i_shift_read_history) &&  (i_write_enable))
                speculative_offset_r <= speculative_offset_r - 1'd1;
            if(i_shift_read_history)
                read_history_r <= shifted_read_history_c;
        end

        // write
        write_history_r <= next_write_history_c;
        if(i_write_enable) begin
            if(write_key_and_val_matches_c) begin
                entries[write_index_c].cnt <= write_next_counter_c;
            end else begin
                `ifdef SIMULATION
                evicts += write_entry_c.valid;
                `endif
                entries[write_index_c] <= '{
                    valid: 1'd1,
                    cnt:   i_write_jump ? COUNTER_HALF_1 : COUNTER_HALF_0
                };
            end
        end
    end
end

assign o_read_valid = read_valid_r;
assign o_read_jump  = read_jump_r;

endmodule
`endif