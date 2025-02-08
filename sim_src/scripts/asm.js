const fs = require("fs");


const REGS_LOOKUP = {
    "x0":    0,
    "x1":    1,
    "x2":    2,
    "x3":    3,
    "x4":    4,
    "x5":    5,
    "x6":    6,
    "x7":    7,
    "x8":    8,
    "x9":    9,
    
    "x10":  10,
    "x11":  11,
    "x12":  12,
    "x13":  13,
    "x14":  14,
    "x15":  15,
    "x16":  16,
    "x17":  17,
    "x18":  18,
    "x19":  19,

    "x20":  20,
    "x21":  21,
    "x22":  22,
    "x23":  23,
    "x24":  24,
    "x25":  25,
    "x26":  26,
    "x27":  27,
    "x28":  28,
    "x29":  29,
    
    "x30":  30,
    "x31":  31,

    "zero":  0,
    "ra":    1,
    "sp":    2,
    "gp":    3,

    "t0":    5,
    "t1":    6,
    "t2":    7,

    "s0":    8,
    "fp":    8,
    "s1":    9,

    "a0":   10,
    "a1":   11,
    "a2":   12,
    "a3":   13,
    "a4":   14,
    "a5":   15,
    "a6":   16,
    "a7":   17,
    
    "s2":   18,
    "s3":   19,
    "s4":   20,
    "s5":   21,
    "s6":   22,
    "s7":   23,
    "s8":   24,
    "s9":   25,
    "s10":  26,
    "s11":  27,

    "t3":   28,
    "t4":   29,
    "t5":   30,
    "t6":   31,

}

function parse_int(value, width, half = false){
    value = parseInt(value);
    if(half) value = value / 2;
    if(isNaN(value)){
        throw "NOT A NUMBER"
    }
    value = (value & 0xFFFFFF).toString(2);
    return W(value, width);
}
function parse_reg(value){
    value = REGS_LOOKUP[value]
    if(value === undefined) {
        throw "NOT A REGISTER";
    }
    return W(value.toString(2), 5);
}

function W(str, width, pad='0') {
    return (pad.repeat(width)+str).slice(-width)
}


const PARSERS = {
    "R": function (op, f3, f7) {
        return function(rd, rs1, rs2) {
            rd  = parse_reg(rd);
            rs1 = parse_reg(rs1);
            rs2 = parse_reg(rs2);
            return f7+rs2+rs1+f3+rd+op;
        };
    },
    "r": function (op, f3, f7) {
        return function(rd, rs1, rs2) {
            rd  = parse_reg(rd);
            rs1 = parse_reg(rs1);
            rs2 = parse_int(rs2, f7.length!==7 ? 6 : 5);
            return f7+rs2+rs1+f3+rd+op;
        };
    },
    "I": function(op, f3) {
        return function(rd, rs1, imm) {
            rd  = parse_reg(rd);
            rs1 = parse_reg(rs1);
            imm = parse_int(imm,12);
            return imm+rs1+f3+rd+op;
        };
    },
    "S": function(op, f3) {
        return function(rs1, rs2, imm) {
            rs1 = parse_reg(rs1);
            rs2 = parse_reg(rs2);
            imm = parse_int(imm,12);
            f7  = imm.slice(0,7);
            rd  = imm.slice(-5);
            return f7+rs2+rs1+f3+rd+op;
        };
    },
    "B": function(op, f3) {
        return function(rs1, rs2, imm) {
            rs1 = parse_reg(rs1);
            rs2 = parse_reg(rs2);
            imm = parse_int(imm,12,true);
            f7  = imm[0] + imm.slice(2,8);
            rd  = imm.slice(-4) + imm[1];
            return f7+rs2+rs1+f3+rd+op;
        };
    },
    "U": function (op) {
        return function(rd, imm) {
            rd  = parse_reg(rd);
            imm = parse_int(imm,20);
            return imm+rd+op;
        };
    },
    "J": function(op) {
        return function(rd, imm) {
            rd  = parse_reg(rd);
            imm = parse_int(imm,20,true);
            imm = imm[0] + imm.slice(-10)+imm[9]+imm.slice(1,9);
            return imm+rd+op;
        };
    },
    "E": function(op,val) {
        return function() {
            return val+op;
        };
    }
}
const INST_PARSER = {
    LUI:        PARSERS.U("0110111"),
    AUIPC:      PARSERS.U("0010111"),
    JAL:        PARSERS.J("1101111"),
    JALR:       PARSERS.I("1100111","000"),
    BEQ:        PARSERS.B("1100011","000"),
    BNE:        PARSERS.B("1100011","001"),
    BLT:        PARSERS.B("1100011","100"),
    BGE:        PARSERS.B("1100011","101"),
    BLTU:       PARSERS.B("1100011","110"),
    BGEU:       PARSERS.B("1100011","111"),
    LB:         PARSERS.I("0000011","000"),
    LH:         PARSERS.I("0000011","001"),
    LW:         PARSERS.I("0000011","010"),
    LBU:        PARSERS.I("0000011","100"),
    LHU:        PARSERS.I("0000011","101"),
    SB:         PARSERS.S("0100011","000"),
    SH:         PARSERS.S("0100011","001"),
    SW:         PARSERS.S("0100011","010"),
    ADDI:       PARSERS.I("0010011","000"),
    SLTI:       PARSERS.I("0010011","010"),
    SLTIU:      PARSERS.I("0010011","011"),
    XORI:       PARSERS.I("0010011","100"),
    ORI:        PARSERS.I("0010011","110"),
    ANDI:       PARSERS.I("0010011","111"),
    // SLLI:       GET_PARSER_r("0010011","001","0000000"),
    // SRLI:       GET_PARSER_r("0010011","101","0000000"),
    // SRAI:       GET_PARSER_r("0010011","101","0100000"),
    ADD:        PARSERS.R("0110011","000","0000000"),
    SUB:        PARSERS.R("0110011","000","0100000"),
    SLL:        PARSERS.R("0110011","001","0000000"),
    SLT:        PARSERS.R("0110011","010","0000000"),
    SLTU:       PARSERS.R("0110011","011","0000000"),
    XOR:        PARSERS.R("0110011","100","0000000"),
    SRL:        PARSERS.R("0110011","101","0000000"),
    SRA:        PARSERS.R("0110011","101","0100000"),
    OR:         PARSERS.R("0110011","110","0000000"),
    AND:        PARSERS.R("0110011","111","0000000"),
    FENCE:      PARSERS.U("0001111"),
    ECALL:      PARSERS.E("1110011","0000000000000000000000000"),
    EBREAK:     PARSERS.E("1110011","0000000000010000000000000"),
    // 64
    LWU:        PARSERS.I("0000011", "110"),
    LD:         PARSERS.I("0000011", "011"),
    SD:         PARSERS.S("0100011", "011"),
    SLLI:       PARSERS.r("0010011", "001","000000"),
    SRLI:       PARSERS.r("0010011", "101","000000"),
    SRAI:       PARSERS.r("0010011", "101","010000"),
    ADDIW:      PARSERS.I("0011011", "000"),
    SLLIW:      PARSERS.r("0011011", "001","0000000"),
    SRLIW:      PARSERS.r("0011011", "101","0000000"),
    SRAIW:      PARSERS.r("0011011", "101","0100000"),
    ADDW:       PARSERS.R("0111011", "000","0000000"),
    SUBW:       PARSERS.R("0111011", "000","0100000"),
    SLLW:       PARSERS.R("0111011", "001","0000000"),
    SRLW:       PARSERS.R("0111011", "101","0000000"),
    SRAW:       PARSERS.R("0111011", "101","0100000"),
};

let res_insts   = [];
let res_args    = [];
let res_lines   = [];
let res_labels  = {};

let line_cnt = 0;
function parse_line(line){
    const comm = line.indexOf(';');
    if(comm !== -1) line = line.slice(0, comm);
    line = line.trim();
    let label = "";
    if(line.indexOf(":") !== -1){
        [label,line] = line.split(":");
        label = label.trim();
        line = line.trim();
        res_labels[label] = res_insts.length*4;
    }
    let tokens = line.split(/[\s\,]/g).map(x => x.trim()).filter(x => x !== "");
    // console.log(`${label}: ${tokens}`);
    if(tokens.length > 0){
        res_insts.push(tokens.shift().toUpperCase());
        res_args.push(tokens);
        res_lines.push(line_cnt);
    }
    line_cnt++;
}

let bad = false;
function compile_inst(i){
    let current_address = i*4;
    let parser = INST_PARSER[res_insts[i]];
    try{
        if(parser === undefined){
            throw "UNKNOWN COMMAND " + res_insts[i];
        }
        for(let j in res_args[i]){
            value = res_args[i][j];
            if(res_labels[value] !== undefined){
                res_args[i][j] = res_labels[value] - current_address;
            }
            if(value.length > 1 && value[0] == "%"){
                res_args[i][j] = res_labels[value.slice(1)];
            }
        }
        let res_line = parser(...(res_args[i]));
        let annote = res_line + ` \t; [${W(current_address, 5,' ')}] ${res_insts[i]}\t${res_args[i].join(',\t')}`;

        return [res_line, annote];
    } catch(err) {
        bad = true;
        console.error(err, res_lines[i], res_insts[i], res_args[i]);
        return ["",""];
    }
}

function compile_all(){
    let res = "";
    let annotes = "";
    for(let i = 0; i<res_insts.length; i++){
        let [line, annote] = compile_inst(i);
        res += line + '\n';
        annotes += annote + '\n';
    }
    return [res, annotes];
}

function parse_file(filename) {
    // console.log(filename)
    let data = fs.readFileSync(filename);
    data = data.toString();
    data = data.split(/\r?\n/);
    // console.log(data);
    for(line of data){
        parse_line(line);
    }
}


parse_file(process.argv[2]);
let [res, annotes] = compile_all();
if(bad){
    console.log(annotes);
    console.log("ERRORS");
    process.exit(1);
}else{
    console.log(annotes);
    if(process.argv[3] !== '--') {
        console.log("SUCCESS");
        // const lines = res_insts.length;
        // const line = "0".repeat(32) + '\n';
        // const padding = line.repeat()
        fs.writeFileSync(process.argv[3] || "./program.mem", res);
    }
}