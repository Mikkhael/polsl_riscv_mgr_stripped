
function CHECK_REG(input integer fd, input [63:0] REGS [0:31], input [4:0] addr, input [63:0] value); begin
    if( REGS[addr] !== value ) begin
               $display     ("Expected R%0d: 0x%h %0d,got: 0x%h %0d", addr, value,value, REGS[addr],REGS[addr]);
        if(fd) $fdisplay(fd, "Expected R%0d: 0x%h %0d,got: 0x%h %0d", addr, value,value, REGS[addr],REGS[addr]);
        CHECK_REG = 0;
    end else CHECK_REG = 1;
end endfunction

function CHECK_MEM(input integer fd, input [63:0] MEMORY [0:8191], input [63:0] addr, input [63:0] value); begin
    if( MEMORY[addr[63:3]] !== value ) begin
               $display     ("Expected MEM 0x%0h: 0x%h %0d,got: 0x%h %0d", addr*4, value,value, MEMORY[addr[63:3]],MEMORY[addr[63:3]]);
        if(fd) $fdisplay(fd, "Expected MEM 0x%0h: 0x%h %0d,got: 0x%h %0d", addr*4, value,value, MEMORY[addr[63:3]],MEMORY[addr[63:3]]);
        CHECK_MEM = 0;
    end else CHECK_MEM = 1;
end endfunction 

typedef struct {
    logic [63:0] pre_reg    [int];
    logic [63:0] pre_mem    [int];
    logic [63:0] post_reg   [int];
    logic [63:0] post_mem   [int];
} ASSERTIONS_CONDITIONS;

task automatic SET_PRECONDITIONS(input ASSERTIONS_CONDITIONS conditions, ref [63:0] REGS [0:31], ref [63:0] MEMORY [0:8191]); 
    int i, empty;
begin
    empty = conditions.pre_reg.first(i);
    while(empty) begin
        REGS[i] = conditions.pre_reg[i];
        // $display("RRR %d %d", i, conditions.pre_reg[i]);
        empty = conditions.pre_reg.next(i);
    end
    empty = conditions.pre_mem.first(i);
    while(empty) begin
        MEMORY[i/8] = conditions.pre_mem[i];
        // $display("MMM %d %d", i/8, conditions.pre_mem[i]);
        empty = conditions.pre_mem.next(i);
    end
end endtask

function CHECK_POSTCONDITIONS(input integer fd, input ASSERTIONS_CONDITIONS conditions, input [63:0] REGS [0:31], input [63:0] MEMORY [0:8191]); 
    int i, empty;
begin
    CHECK_POSTCONDITIONS = 1;
    if (REGS[31] !== 0 && REGS[31] !== 1'bx) begin // Check unreachable code
               $display     ("Reached unreachable code: %b (%0d)", REGS[31],REGS[31]);
        if(fd) $fdisplay(fd, "Reached unreachable code: %b (%0d)", REGS[31],REGS[31]);
        CHECK_POSTCONDITIONS = 0;
    end

    empty = conditions.post_reg.first(i);
    while(empty) begin
        CHECK_POSTCONDITIONS &= CHECK_REG(fd, REGS,   i, conditions.post_reg[i]);
        empty = conditions.post_reg.next(i);
    end
    empty = conditions.post_mem.first(i);
    while(empty) begin
        CHECK_POSTCONDITIONS &= CHECK_MEM(fd, MEMORY, i, conditions.post_mem[i]);
        empty = conditions.post_mem.next(i);
    end

end endfunction


task GET_ASSERTIONS_CONDITIONS(input string test_name, input integer VARIANT, output ASSERTIONS_CONDITIONS res); begin

    // res.pre_reg  = '{0: 0};
    // res.pre_mem  = '{0: 0};
    // res.post_reg = '{0: 0};
    // res.post_mem = '{0: 0};

    if(test_name == "test_ras_x1") begin
        res.post_reg[5] = 'h10  + 'h20  + 1;
        res.post_reg[4] = 'h100 + 'h200 + 1;
        res.post_reg[6] = 'h7;
    end

    if(test_name == "test_branch_diff") begin
        res.post_reg[3]  = 0;
        res.post_reg[4]  = 1;
        res.post_reg[5]  = 1;
        res.post_reg[6]  = 0;
        res.post_reg[7]  = 1;
        res.post_reg[8]  = 0;
        res.post_reg[9]  = 0;
        res.post_reg[10] = 1;
    end
    if(test_name == "test_branch_neg" || test_name == "test_branch_pos") begin
        res.post_reg[3]  = 0;
        res.post_reg[4]  = 1;
        res.post_reg[5]  = 0;
        res.post_reg[6]  = 1;
        res.post_reg[7]  = 1;
        res.post_reg[8]  = 0;
        res.post_reg[9]  = 1;
        res.post_reg[10] = 0;
    end
    
    if(test_name == "fib") begin
        res.post_reg[11] = 55;
        res.post_reg[12] = 89;
    end
    
    if(test_name == "test_jump_stall") begin
        res.post_reg[1] = 'hffffffffff;
    end

    if(test_name == "mul" || test_name == "mul2") begin
        case(VARIANT)
            0: begin res.pre_mem[8] = 5;      res.pre_mem[16] = 25;     res.post_mem[24] = 5 * 25;      end
            1: begin res.pre_mem[8] = -23;    res.pre_mem[16] = 18;     res.post_mem[24] = -23 * 18;    end
            2: begin res.pre_mem[8] = 0;      res.pre_mem[16] = 234657; res.post_mem[24] = 0;           end
            3: begin res.pre_mem[8] = 234657; res.pre_mem[16] = 0;      res.post_mem[24] = 0;           end
        endcase
    end
    
    if(test_name == "mmul") begin
        res.pre_mem[8] = 3;
    end
    
    if(test_name == "vectors") begin
        case(VARIANT)
            0: res.pre_mem[8] = 3;
            1: res.pre_mem[8] = 10;
        endcase
    end

    if(test_name == "fizzbuzz" || test_name == "fizzbuzz_m") begin
        if(VARIANT == 0) res.pre_mem[8] = 100;
        else             res.pre_mem[8] = VARIANT;
    end

    if(test_name == "factorial") begin
        case(VARIANT)
            0: begin res.pre_mem[8] = 3;   res.post_mem[16] = 3*2;     end
            1: begin res.pre_mem[8] = 10;  res.post_mem[16] = 10*9*8*7*6*5*4*3*2; end
            2: begin res.pre_mem[8] = -3;  res.post_mem[16] = 1; end
        endcase
    end

    if(test_name == "test_store_mask") begin
        res.post_mem[0]  = 64'h1155FFEEDDCCBBAA;
        res.post_mem[16] = 64'hDDDDCCCCBBBBAAAA;
        res.post_mem[32] = 64'hBBBBBBBBAAAAAAAA;
    end

end endtask

