module riscv_ref (
    // input clk,
    // input en,

    output reg [63:0] pc = 0,
    input [31:0] instr,

    output reg [63:0] REGS [0:31] = '{0: 0},
    output reg [63:0] MEMORY [0:8191] = '{0: 0},
    output reg finished = 0,
    output reg invalid = 0
);
    
    `include "./riscv_instr_parse.vh"

    wire IMM_sign = instr[31];
    wire [64 - 1:0] IMM_I = {{32{IMM_sign}}, {20{IMM_sign}},  instr[31:20]};
    wire [64 - 1:0] IMM_S = {{32{IMM_sign}}, {20{IMM_sign}},  instr[31:25], instr[11:7]};
    wire [64 - 1:0] IMM_U = {{32{IMM_sign}}, instr[31:12], 12'h0};
    wire [64 - 1:0] IMM_J = {{32{IMM_sign}}, {12{IMM_sign}},  instr[19:12], instr[20],    instr[30:21], 1'h0};
    wire [64 - 1:0] IMM_B = {{32{IMM_sign}}, {20{IMM_sign}},  instr[7],     instr[30:25], instr[11:8],  1'h0};

    
    wire [4:9] RD  = instr[11:7];
    wire [4:9] RS1 = instr[19:15];
    wire [4:9] RS2 = instr[24:20];

    wire [5:0] SHIFT_AMT = instr[26:20];

    wire [63:0] LD_ADDR = REGS[RS1] + IMM_I;
    wire [63:0] ST_ADDR = REGS[RS1] + IMM_S;

    function [63:0] LOAD_MEM(input reg [63:0] addr, input [3:0] w);
        reg [63:0] mask;
        reg [63:0] val;
    begin
        mask = {64{1'b1}};
        mask >>= (8-w)*8;
        val = MEMORY[addr[63:3]];
        val >>= addr[2:0]*8;
        // $display("\nLOAD MEM addr: %0d, w: %0d, cell: 0x%0h, mask: 0x%h, data: 0x%0h", addr, w, MEMORY[addr[63:3]], mask, mask & val);
        LOAD_MEM = mask & val;
    end endfunction
    task STORE_MEM(input [63:0] addr, input integer w, input [63:0] data); 
        reg [63:0] mask;
        reg [63:0] val;
    begin
        mask = {64{1'b1}};
        mask >>= (8-w)*8;
        val = mask & data;
        mask <<= addr[2:0] * 8;
        val  <<= addr[2:0] * 8;
        // $display("\nSTORE MEM addr: %0d, w: %0d, data: 0x%0h, mask: 0x%h, val: 0x%h", addr, w, data, mask, val);
        MEMORY[addr[63:3]] &= (~mask);
        MEMORY[addr[63:3]] |= val;
    end endtask


  `ifdef RUN_FOR
    localparam run_for = `RUN_FOR;
  `else
    localparam run_for = 100;
  `endif

// localparam string REF_PREFIX = "								 [REF]";
localparam string REF_PREFIX = "[REF]";

localparam RAS_DEPTH = 16;
integer ras_size = 0;
reg [63:0] ras [0:RAS_DEPTH-1];

task automatic RAS_JUMP(input [63:0] pc, input [4:0] rs1, input [4:0] rd);
    logic rs1_link;
    logic rd_link;
    logic [63:0] new_rs1;
begin
    rs1_link = rs1 == 5'd1 || rs1 == 5'd5;
    rd_link  = rd  == 5'd1 || rd  == 5'd5;
    if(rd_link && (!rs1_link || rs1 == rd)) begin // push
        if(ras_size > RAS_DEPTH) begin
            $display (" [RAS] CALL OVERFLOW!!! %0d >> %0d ", pc >> 2, (pc+4) >> 2);
        end else begin
            // $display (" [RAS] CALL %0d >> %0d ", pc >> 2, (pc+4) >> 2);
            ras[ras_size] = pc + 4;
            ras_size += 1;
        end
    end
    if(rs1_link && !rd_link) begin // pop
        if(ras_size > 1) begin
            new_rs1 = ras[ras_size-2];
            ras_size -= 1;
        end else begin
            new_rs1 = 1'bx;
        end
        // $display (" [RAS] RET  %0d >> to %0d (set %0d)", pc >> 2, REGS[rs1] >> 2, new_rs1 >> 2);
        if(new_rs1 !== 1'bx) REGS[rs1] = new_rs1;
    end
    if(rs1_link && rd_link && rs1 == rd) begin // pop_then_push
        $display (" [RAS] CRET  %0d >> to %0d (RAS NOT IMPLEMENTED)", pc >> 2, REGS[rs1] >> 2);
    end
end endtask

integer total_cycles = 0;
reg [63:0] new_pc = 0;
reg [63:0] temp_res = 0;
reg [63:0] temp_rs1 = 0;
reg [63:0] temp_rs2 = 0;
reg is_load  = 0;
reg is_store = 0;
// always @(posedge clk) begin
task automatic STEP(output string parsed_instr); begin
    // if(!finished && en) begin
    if(!finished) begin
        is_load  = 0;
        is_store = 0;
        new_pc = pc + 4;
        temp_rs1 = REGS[RS1];
        temp_rs2 = REGS[RS2];
        casez (instr)
            LUI    : begin REGS[RD] = IMM_U;                                                         end
            AUIPC  : begin REGS[RD] = pc  + IMM_U;                                                   end
            JAL    : begin new_pc = pc        + IMM_J; RAS_JUMP(pc, 0,   RD); REGS[RD] = pc + 4;     end
            JALR   : begin new_pc = REGS[RS1] + IMM_I; RAS_JUMP(pc, RS1, RD); REGS[RD] = pc + 4;     end
            BEQ    : begin new_pc = REGS[RS1] == REGS[RS2] ? pc + IMM_B : new_pc;                    end
            BNE    : begin new_pc = REGS[RS1] != REGS[RS2] ? pc + IMM_B : new_pc;                    end
            BLT    : begin new_pc = $signed(REGS[RS1]) <  $signed(REGS[RS2]) ? pc + IMM_B : new_pc;  end
            BGE    : begin new_pc = $signed(REGS[RS1]) >= $signed(REGS[RS2]) ? pc + IMM_B : new_pc;  end
            BLTU   : begin new_pc =         REGS[RS1]  <          REGS[RS2]  ? pc + IMM_B : new_pc;  end
            BGEU   : begin new_pc =         REGS[RS1]  >=         REGS[RS2]  ? pc + IMM_B : new_pc;  end
            LB     : begin REGS[RD] = $signed(LOAD_MEM(LD_ADDR, 1)); is_load=1;                      end
            LH     : begin REGS[RD] = $signed(LOAD_MEM(LD_ADDR, 2)); is_load=1;                      end
            LW     : begin REGS[RD] = $signed(LOAD_MEM(LD_ADDR, 4)); is_load=1;                      end
            LBU    : begin REGS[RD] =         LOAD_MEM(LD_ADDR, 1);  is_load=1;                      end
            LHU    : begin REGS[RD] =         LOAD_MEM(LD_ADDR, 2);  is_load=1;                      end
            LWU    : begin REGS[RD] =         LOAD_MEM(LD_ADDR, 4);  is_load=1;                      end
            LD     : begin REGS[RD] =         LOAD_MEM(LD_ADDR, 8);  is_load=1;                      end
            SB     : begin STORE_MEM(ST_ADDR, 1, REGS[RS2]);         is_store=1;                     end
            SH     : begin STORE_MEM(ST_ADDR, 2, REGS[RS2]);         is_store=1;                     end
            SW     : begin STORE_MEM(ST_ADDR, 4, REGS[RS2]);         is_store=1;                     end
            SD     : begin STORE_MEM(ST_ADDR, 8, REGS[RS2]);         is_store=1;                     end
            ADDI   : begin REGS[RD] = REGS[RS1] +   IMM_I;                                           end
            SLTI   : begin REGS[RD] = REGS[RS1] <   $signed(IMM_I);                                  end
            SLTIU  : begin REGS[RD] = REGS[RS1] <   IMM_I;                                           end
            XORI   : begin REGS[RD] = REGS[RS1] ^   IMM_I;                                           end
            ORI    : begin REGS[RD] = REGS[RS1] |   IMM_I;                                           end
            ANDI   : begin REGS[RD] = REGS[RS1] &   IMM_I;                                           end
            SLLI   : begin REGS[RD] = REGS[RS1] <<  SHIFT_AMT;                                       end
            SRLI   : begin REGS[RD] = REGS[RS1] >>  SHIFT_AMT;                                       end
            SRAI   : begin REGS[RD] = REGS[RS1] >>> SHIFT_AMT;                                       end
            ADD    : begin REGS[RD] = REGS[RS1] +   REGS[RS2];                                       end
            SUB    : begin REGS[RD] = REGS[RS1] -   REGS[RS2];                                       end
            SLT    : begin REGS[RD] = REGS[RS1] <   $signed(REGS[RS2]);                              end
            SLTU   : begin REGS[RD] = REGS[RS1] <   REGS[RS2];                                       end
            XOR    : begin REGS[RD] = REGS[RS1] ^   REGS[RS2];                                       end
            OR     : begin REGS[RD] = REGS[RS1] |   REGS[RS2];                                       end
            AND    : begin REGS[RD] = REGS[RS1] &   REGS[RS2];                                       end
            SLL    : begin REGS[RD] = REGS[RS1] <<  REGS[RS2];                                       end
            SRL    : begin REGS[RD] = REGS[RS1] >>  REGS[RS2];                                       end
            SRA    : begin REGS[RD] = REGS[RS1] >>> REGS[RS2];                                       end
            FENCE  : begin $display(" NOT IMPLEMENTED");        end
            FENCEI : begin $display(" NOT IMPLEMENTED");        end
            ECALL  : begin $display(" NOT IMPLEMENTED");        end
            EBREAK : begin $display(" NOT IMPLEMENTED");        end
            CSRRW  : begin $display(" NOT IMPLEMENTED");        end
            CSRRS  : begin $display(" NOT IMPLEMENTED");        end
            CSRRC  : begin $display(" NOT IMPLEMENTED");        end
            CSRRWI : begin $display(" NOT IMPLEMENTED");        end
            CSRRSI : begin $display(" NOT IMPLEMENTED");        end
            CSRRCI : begin $display(" NOT IMPLEMENTED");        end
            ADDIW  : begin REGS[RD] = $signed(REGS[RS1][31:0] +   IMM_I[31:0]);                      end
            SLLIW  : begin REGS[RD] = $signed(REGS[RS1][31:0] <<  SHIFT_AMT[4:0]);                   end
            SRLIW  : begin REGS[RD] = $signed(REGS[RS1][31:0] >>  SHIFT_AMT[4:0]);                   end
            SRAIW  : begin REGS[RD] = $signed(REGS[RS1][31:0] >>> SHIFT_AMT[4:0]);                   end
            ADDW   : begin REGS[RD] = $signed(REGS[RS1][31:0] +   REGS[RS2][31:0]);                  end
            SUBW   : begin REGS[RD] = $signed(REGS[RS1][31:0] -   REGS[RS2][31:0]);                  end
            SLLW   : begin REGS[RD] = $signed(REGS[RS1][31:0] <<  REGS[RS2][4:0]);                   end
            SRLW   : begin REGS[RD] = $signed(REGS[RS1][31:0] >>  REGS[RS2][4:0]);                   end
            SRAW   : begin REGS[RD] = $signed(REGS[RS1][31:0] >>> REGS[RS2][4:0]);                   end
            default :begin invalid = 1; finished = 1; end
        endcase
        temp_res = REGS[RD];
        if(is_load)  temp_res = LD_ADDR;
        if(is_store) temp_res = ST_ADDR;
        parsed_instr = INSTR_TO_STR_EX(instr, pc, temp_rs1, temp_rs1, temp_rs2, temp_rs2, temp_res);
        REGS[0] = 0;
        pc = new_pc;
        total_cycles++;
        
        if(instr == HALT) begin
          $display("%s Halted simulation", REF_PREFIX);
          finished = 1;
        end
        if(total_cycles > run_for) begin
            $display("%s Too many instructions", REF_PREFIX);
            finished = 1;
        end
    end
end
endtask



endmodule