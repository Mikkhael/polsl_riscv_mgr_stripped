


    //RV32I Base Instruction Set
    localparam LUI    = 32'b????????????????????_?????_0110111;
    localparam AUIPC  = 32'b????????????????????_?????_0010111;
    localparam JAL    = 32'b????????????????????_?????_1101111;
    localparam JALR   = 32'b????????????_?????_000_?????_1100111;
    localparam BEQ    = 32'b???????_?????_?????_000_?????_1100011;
    localparam BNE    = 32'b???????_?????_?????_001_?????_1100011;
    localparam BLT    = 32'b???????_?????_?????_100_?????_1100011;
    localparam BGE    = 32'b???????_?????_?????_101_?????_1100011;
    localparam BLTU   = 32'b???????_?????_?????_110_?????_1100011;
    localparam BGEU   = 32'b???????_?????_?????_111_?????_1100011;
    localparam LB     = 32'b????????????_?????_000_?????_0000011;
    localparam LH     = 32'b????????????_?????_001_?????_0000011;
    localparam LW     = 32'b????????????_?????_010_?????_0000011;
    localparam LBU    = 32'b????????????_?????_100_?????_0000011;
    localparam LHU    = 32'b????????????_?????_101_?????_0000011;
    localparam SB     = 32'b???????_?????_?????_000_?????_0100011;
    localparam SH     = 32'b???????_?????_?????_001_?????_0100011;
    localparam SW     = 32'b???????_?????_?????_010_?????_0100011;
    localparam NOOP   = 32'b000000000000_00000_000_00000_0010011;
    localparam ADDI   = 32'b????????????_?????_000_?????_0010011;
    localparam SLTI   = 32'b????????????_?????_010_?????_0010011;
    localparam SLTIU  = 32'b????????????_?????_011_?????_0010011;
    localparam XORI   = 32'b????????????_?????_100_?????_0010011;
    localparam ORI    = 32'b????????????_?????_110_?????_0010011;
    localparam ANDI   = 32'b????????????_?????_111_?????_0010011;
    localparam SLLI   = 32'b000000_??????_?????_001_?????_0010011;
    localparam SRLI   = 32'b000000_??????_?????_101_?????_0010011;
    localparam SRAI   = 32'b010000_??????_?????_101_?????_0010011;
    localparam ADD    = 32'b0000000_?????_?????_000_?????_0110011;
    localparam SUB    = 32'b0100000_?????_?????_000_?????_0110011;
    localparam SLL    = 32'b0000000_?????_?????_001_?????_0110011;
    localparam SLT    = 32'b0000000_?????_?????_010_?????_0110011;
    localparam SLTU   = 32'b0000000_?????_?????_011_?????_0110011;
    localparam XOR    = 32'b0000000_?????_?????_100_?????_0110011;
    localparam SRL    = 32'b0000000_?????_?????_101_?????_0110011;
    localparam SRA    = 32'b0100000_?????_?????_101_?????_0110011;
    localparam OR     = 32'b0000000_?????_?????_110_?????_0110011;
    localparam AND    = 32'b0000000_?????_?????_111_?????_0110011;
    localparam FENCE  = 32'b0000_????_????_00000_000_00000_0001111;
    localparam FENCEI = 32'b0000_0000_0000_00000_001_00000_0001111;
    localparam ECALL  = 32'b000000000000_00000_000_00000_1110011;
    localparam EBREAK = 32'b000000000001_00000_000_00000_1110011;
    localparam CSRRW  = 32'b????????????_?????_001_?????_1110011;
    localparam CSRRS  = 32'b????????????_?????_010_?????_1110011;
    localparam CSRRC  = 32'b????????????_?????_011_?????_1110011;
    localparam CSRRWI = 32'b????????????_?????_101_?????_1110011;
    localparam CSRRSI = 32'b????????????_?????_110_?????_1110011;
    localparam CSRRCI = 32'b????????????_?????_111_?????_1110011;
    //RV64I Base Instruction Set (in addition to RV32I)
    localparam LWU    = 32'b????????????_?????_110_?????_0000011;
    localparam LD     = 32'b????????????_?????_011_?????_0000011;
    localparam SD     = 32'b???????_?????_?????_011_?????_0100011;
    localparam ADDIW  = 32'b????????????_?????_000_?????_0011011;
    localparam SLLIW  = 32'b0000000_?????_?????_001_?????_0011011;
    localparam SRLIW  = 32'b0000000_?????_?????_101_?????_0011011;
    localparam SRAIW  = 32'b0100000_?????_?????_101_?????_0011011;
    localparam ADDW   = 32'b0000000_?????_?????_000_?????_0111011;
    localparam SUBW   = 32'b0100000_?????_?????_000_?????_0111011;
    localparam SLLW   = 32'b0000000_?????_?????_001_?????_0111011;
    localparam SRLW   = 32'b0000000_?????_?????_101_?????_0111011;
    localparam SRAW   = 32'b0100000_?????_?????_101_?????_0111011;
    // For easier simulation:
    localparam HALT   = 32'b0000000_00000_00000_100_00000_0110011; // XOR x0, x0, x0

    function string INSTR_TO_STR(input [31:0] instr, input [63:0] pc); begin
        casez (instr)
            LUI    : INSTR_TO_STR = $sformatf(" %0d >> LUI   : imm   = %h ; rd   = %h ", ((pc >> 2)), instr[31:12], instr[11:7]);
            AUIPC  : INSTR_TO_STR = $sformatf(" %0d >> AUPIC : imm   = %h ; rd   = %h ", ((pc >> 2)), instr[31:12], instr[11:7]);
            JAL    : INSTR_TO_STR = $sformatf(" %0d >> JAL   : imm   = %h ; rd   = %h ", ((pc >> 2)), {instr[20], instr[10:1], instr[11], instr[19:12]}, instr[11:7]);
            JALR   : INSTR_TO_STR = $sformatf(" %0d >> JALR  : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            BEQ    : INSTR_TO_STR = $sformatf(" %0d >> BEQ   : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31], instr[7], instr[30:25], instr[11:8]}, instr[24:20], instr[19:15]);
            BNE    : INSTR_TO_STR = $sformatf(" %0d >> BNE   : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31], instr[7], instr[30:25], instr[11:8]}, instr[24:20], instr[19:15]);
            BLT    : INSTR_TO_STR = $sformatf(" %0d >> BLT   : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31], instr[7], instr[30:25], instr[11:8]}, instr[24:20], instr[19:15]);
            BGE    : INSTR_TO_STR = $sformatf(" %0d >> BGE   : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31], instr[7], instr[30:25], instr[11:8]}, instr[24:20], instr[19:15]);
            BLTU   : INSTR_TO_STR = $sformatf(" %0d >> BLTU  : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31], instr[7], instr[30:25], instr[11:8]}, instr[24:20], instr[19:15]);
            BGEU   : INSTR_TO_STR = $sformatf(" %0d >> BGEU  : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31], instr[7], instr[30:25], instr[11:8]}, instr[24:20], instr[19:15]);
            LB     : INSTR_TO_STR = $sformatf(" %0d >> LB    : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            LH     : INSTR_TO_STR = $sformatf(" %0d >> LH    : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            LW     : INSTR_TO_STR = $sformatf(" %0d >> LW    : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            LBU    : INSTR_TO_STR = $sformatf(" %0d >> LBU   : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            LHU    : INSTR_TO_STR = $sformatf(" %0d >> LHU   : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            SB     : INSTR_TO_STR = $sformatf(" %0d >> SB    : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31:25], instr[11:7]}, instr[24:20], instr[19:15]);
            SH     : INSTR_TO_STR = $sformatf(" %0d >> SH    : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31:25], instr[11:7]}, instr[24:20], instr[19:15]);
            SW     : INSTR_TO_STR = $sformatf(" %0d >> SW    : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31:25], instr[11:7]}, instr[24:20], instr[19:15]);
            ADDI   : INSTR_TO_STR = $sformatf(" %0d >> ADDI  : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            SLTI   : INSTR_TO_STR = $sformatf(" %0d >> SLTI  : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            SLTIU  : INSTR_TO_STR = $sformatf(" %0d >> SLTIU : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            XORI   : INSTR_TO_STR = $sformatf(" %0d >> XORI  : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            ORI    : INSTR_TO_STR = $sformatf(" %0d >> ORI   : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            ANDI   : INSTR_TO_STR = $sformatf(" %0d >> ANDI  : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            SLLI   : INSTR_TO_STR = $sformatf(" %0d >> SLLI  : shamt = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRLI   : INSTR_TO_STR = $sformatf(" %0d >> SRLI  : shamt = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRAI   : INSTR_TO_STR = $sformatf(" %0d >> SRAI  : shamt = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            ADD    : INSTR_TO_STR = $sformatf(" %0d >> ADD   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SUB    : INSTR_TO_STR = $sformatf(" %0d >> SUB   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SLL    : INSTR_TO_STR = $sformatf(" %0d >> SLL   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SLT    : INSTR_TO_STR = $sformatf(" %0d >> SLT   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SLTU   : INSTR_TO_STR = $sformatf(" %0d >> SLTU  : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            XOR    : INSTR_TO_STR = $sformatf(" %0d >> XOR   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRL    : INSTR_TO_STR = $sformatf(" %0d >> SRL   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRA    : INSTR_TO_STR = $sformatf(" %0d >> SRA   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            OR     : INSTR_TO_STR = $sformatf(" %0d >> OR    : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            AND    : INSTR_TO_STR = $sformatf(" %0d >> AND   : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            FENCE  : INSTR_TO_STR = $sformatf(" %0d >> FENCE : preh  = %b ; succ = %b ", ((pc >> 2)), instr[25:23], instr[22:20]);
            FENCEI : INSTR_TO_STR = $sformatf(" %0d >> FENCEI ", ((pc >> 2)));
            ECALL  : INSTR_TO_STR = $sformatf(" %0d >> ECALL  ", ((pc >> 2)));
            EBREAK : INSTR_TO_STR = $sformatf(" %0d >> EBREAK ", ((pc >> 2)));
            CSRRW  : INSTR_TO_STR = $sformatf(" %0d >> CSRRW : csr   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:22], instr[21:17], instr[11:7]);
            CSRRS  : INSTR_TO_STR = $sformatf(" %0d >> CSRRS : csr   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            CSRRC  : INSTR_TO_STR = $sformatf(" %0d >> CSRRC : csr   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            CSRRWI : INSTR_TO_STR = $sformatf(" %0d >> CSRRWI: csr   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            CSRRSI : INSTR_TO_STR = $sformatf(" %0d >> CSRRSI: csr   = %h ; zimm = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            CSRRCI : INSTR_TO_STR = $sformatf(" %0d >> CSRRCI: csr   = %h ; zimm = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            LWU    : INSTR_TO_STR = $sformatf(" %0d >> LWU   : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            LD     : INSTR_TO_STR = $sformatf(" %0d >> LD    : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            SD     : INSTR_TO_STR = $sformatf(" %0d >> SD    : imm   = %h ; rs2  = %h ; rs1 = %h ", ((pc >> 2)), {instr[31:25], instr[11:7]}, instr[24:20], instr[19:15]);
            ADDIW  : INSTR_TO_STR = $sformatf(" %0d >> ADDIW : imm   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[31:20], instr[19:15], instr[11:7]);
            SLLIW  : INSTR_TO_STR = $sformatf(" %0d >> SLLIW : shamt = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRLIW  : INSTR_TO_STR = $sformatf(" %0d >> SRLIW : shamt = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRAIW  : INSTR_TO_STR = $sformatf(" %0d >> SRAIW : shamt = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            ADDW   : INSTR_TO_STR = $sformatf(" %0d >> ADDW  : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SUBW   : INSTR_TO_STR = $sformatf(" %0d >> SUBW  : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SLLW   : INSTR_TO_STR = $sformatf(" %0d >> SLLW  : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRLW   : INSTR_TO_STR = $sformatf(" %0d >> SRLW  : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            SRAW   : INSTR_TO_STR = $sformatf(" %0d >> SRAW  : rs2   = %h ; rs1  = %h ; rd  = %h ", ((pc >> 2)), instr[24:20], instr[19:15], instr[11:7]);
            default :INSTR_TO_STR = $sformatf(" %0d >> INVALID INSTR ", ((pc >> 2)));
        endcase
    end endfunction

    
    function automatic string INSTR_TO_STR_EX(input [31:0] instr, input [63:0] pc, input [63:0] v1, input [63:0] jalr, input [63:0] v2, input [63:0] v3, input [63:0] res); 
            logic IMM_sign = instr[31];
            logic [64 - 1:0] IMM_I = {{32{IMM_sign}}, {20{IMM_sign}},  instr[31:20]};
            logic [64 - 1:0] IMM_S = {{32{IMM_sign}}, {20{IMM_sign}},  instr[31:25], instr[11:7]};
            logic [64 - 1:0] IMM_U = {{32{IMM_sign}}, instr[31:12], 12'h0};
            logic [64 - 1:0] IMM_J = {{32{IMM_sign}}, {12{IMM_sign}},  instr[19:12], instr[20],    instr[30:21], 1'h0};
            logic [64 - 1:0] IMM_B = {{32{IMM_sign}}, {20{IMM_sign}},  instr[7],     instr[30:25], instr[11:8],  1'h0};
            logic [4:9] RD  = instr[11:7];
            logic [4:9] RS1 = instr[19:15];
            logic [4:9] RS2 = instr[24:20];
            logic [5:0] SHIFT_AMT = instr[26:20];
        begin
        casez (instr)
            HALT   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >>   (HALT)", (pc) );
            NOOP   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >>   (NOOP)", (pc) );
            LUI    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LUI   :  rd(%d)= 0x%0H,\t imm= 0x%0H",                       (pc), RD,res,                    IMM_U );
            AUIPC  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> AUPIC :  rd(%d)= 0x%0H,\t imm= 0x%0H",                       (pc), RD,res,                    IMM_U );
            JAL    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> JAL   :  rd(%d)= 0x%0H,\t imm= 0x%0H",                       (pc), RD,res,                    IMM_J );
            JALR   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> JALR  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,jalr,         IMM_I );
            BEQ    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> BEQ   : rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H,\t imm= 0x%0H",     (pc),          RS1,v1,  RS2,v2,  IMM_B );
            BNE    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> BNE   : rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H,\t imm= 0x%0H",     (pc),          RS1,v1,  RS2,v2,  IMM_B );
            BLT    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> BLT   : rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H,\t imm= 0x%0H",     (pc),          RS1,v1,  RS2,v2,  IMM_B );
            BGE    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> BGE   : rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H,\t imm= 0x%0H",     (pc),          RS1,v1,  RS2,v2,  IMM_B );
            BLTU   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> BLTU  : rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H,\t imm= 0x%0H",     (pc),          RS1,v1,  RS2,v2,  IMM_B );
            BGEU   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> BGEU  : rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H,\t imm= 0x%0H",     (pc),          RS1,v1,  RS2,v2,  IMM_B );
            LB     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LB    : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            LH     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LH    : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            LW     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LW    : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            LD     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LD    : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            LBU    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LBU   : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            LHU    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LHU   : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            LWU    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> LWU   : r%d=M[0x%0H],\t rs1(%d)= 0x%0H,\t imm= 0x%0H",       (pc), RD,res,  RS1,v1,           IMM_I );
            SB     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SB    : M[0x%0h]=(r%d)0x%0H,\t (r%d)0x%0H + 0x%0H",          (pc), res,     RS2,v3,  RS1,v1,  IMM_S );
            SH     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SH    : M[0x%0h]=(r%d)0x%0H,\t (r%d)0x%0H + 0x%0H",          (pc), res,     RS2,v3,  RS1,v1,  IMM_S );
            SW     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SW    : M[0x%0h]=(r%d)0x%0H,\t (r%d)0x%0H + 0x%0H",          (pc), res,     RS2,v3,  RS1,v1,  IMM_S );
            SD     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SD    : M[0x%0h]=(r%d)0x%0H,\t (r%d)0x%0H + 0x%0H",          (pc), res,     RS2,v3,  RS1,v1,  IMM_S );
            ADDI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ADDI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SLTI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLTI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SLTIU  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLTIU :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            XORI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> XORI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            ORI    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ORI   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            ANDI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ANDI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SLLI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLLI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SRLI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRLI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SRAI   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRAI  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            ADDIW  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ADDIW :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SLLIW  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLLIW :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SRLIW  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRLIW :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            SRAIW  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRAIW :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t imm= 0x%0H",     (pc), RD,res,  RS1,v1,           IMM_I );
            ADD    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ADD   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SUB    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SUB   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SLL    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLL   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SLT    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLT   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SLTU   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLTU  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            XOR    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> XOR   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SRL    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRL   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SRA    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRA   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            OR     : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> OR    :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            AND    : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> AND   :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            ADDW   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ADDW  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SUBW   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SUBW  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SLLW   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SLLW  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SRLW   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRLW  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            SRAW   : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> SRAW  :  rd(%d)= 0x%0H,\t rs1(%d)= 0x%0H,\t rs2(%d)= 0x%0H", (pc), RD,res,  RS1,v1,  RS2,v2         );
            FENCE  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> FENCE : preh  = %b ; succ = %b ", (pc), instr[25:23], instr[22:20]);
            FENCEI : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> FENCEI ", (pc));
            ECALL  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> ECALL  ", (pc));
            EBREAK : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> EBREAK ", (pc));
            CSRRW  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> CSRRW : csr   = %h ; rs1  = %h ; rd  = %h ", (pc), instr[31:22], instr[21:17], instr[11:7]);
            CSRRS  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> CSRRS : csr   = %h ; rs1  = %h ; rd  = %h ", (pc), instr[24:20], instr[19:15], instr[11:7]);
            CSRRC  : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> CSRRC : csr   = %h ; rs1  = %h ; rd  = %h ", (pc), instr[24:20], instr[19:15], instr[11:7]);
            CSRRWI : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> CSRRWI: csr   = %h ; rs1  = %h ; rd  = %h ", (pc), instr[24:20], instr[19:15], instr[11:7]);
            CSRRSI : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> CSRRSI: csr   = %h ; zimm = %h ; rd  = %h ", (pc), instr[24:20], instr[19:15], instr[11:7]);
            CSRRCI : INSTR_TO_STR_EX = $sformatf(" 0x%0h >> CSRRCI: csr   = %h ; zimm = %h ; rd  = %h ", (pc), instr[24:20], instr[19:15], instr[11:7]);
            default :INSTR_TO_STR_EX = $sformatf(" 0x%0h >> INVALID INSTR ", (pc));
        endcase
    end endfunction
    
    function IS_INSTR_INVALID(input [31:0] instr); begin
        casez (instr)
            LUI,AUIPC,JAL,JALR,BEQ,BNE,BLT,BGE,BLTU,BGEU,LB,LH,LW,LBU,LHU,SB,SH,SW,
            ADDI,SLTI,SLTIU,XORI,ORI,ANDI,SLLI,SRLI,SRAI,ADD,SUB,SLL,SLT,SLTU,XOR,
            SRL,SRA,OR,AND,FENCE,FENCEI,ECALL,EBREAK,CSRRW,CSRRS,CSRRC,CSRRWI,CSRRSI,
            CSRRCI,LWU,LD,SD,ADDIW,SLLIW,SRLIW,SRAIW,ADDW,SUBW,SLLW,SRLW,SRAW: 
                IS_INSTR_INVALID = 0;
            default :
                IS_INSTR_INVALID = 1;
        endcase
    end endfunction