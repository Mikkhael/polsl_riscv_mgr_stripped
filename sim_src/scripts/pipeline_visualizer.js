const fs = require("fs");
const csv_file  = process.argv[2];
const html_file = process.argv[3];

const csv_raw = fs.readFileSync(csv_file);

const csv = csv_raw.toString().split(/\r?\n/g).map(x => x.split(',').map(x => x.trim()));
csv.pop();

const csv_header = csv.shift().map(x => x.split('.'));

const data = csv.map(x => {return {SIM: {}, FI: {}, PROGMEM:{}, ID:{}, REG:{}, EX:{}, MEM:{}, 
                                    REGDATA:[], MEMDATA:[], CHEDATA:[], RAS1:{}, RAS2:{}, RAS3:{},
								    NEXT:{}, MEMWB:{}, BTBCOUNTER:{}, BTBCOUNTERE:[] }});
for(let i=0; i<csv.length; i++){
	for(let j=0; j<csv[0].length; j++){
		data[i][csv_header[j][0]][csv_header[j][1]] = csv[i][j];
	}
}

const filter_reset = 0;
const filter_first_rows_amt = 2;

data.splice(0, filter_first_rows_amt);
const filtered_data = filter_reset ? data.filter(x => x.SIM.nres == '1') : data;

const aux_data_mem_stalls  = filtered_data.map(x => x.MEM.stalled === '1' ? 1 : 0);
const aux_data_wait_stalls = filtered_data.map(x => (x.MEM.stalled === '0' && x.FI.stalled == '1') ? 1 : 0);


// console.log("FI", data[0].FI);
// console.log("ID", data[0].ID);

////////// Rendering //////////////

function create_header(I, data, invalid, flushed, stalled, subclass){
	if(stalled)
		return `<header class="stalled">[${I}]&nbsp;${data}(Stalled)</header>`;
	if(flushed)
		return `<header class="flushed">[${I}]&nbsp;${data}(Flushed)</header>`;
	if(invalid)
		return `<header class="invalid">[${I}]&nbsp;${data}(Invalid)</header>`;
	return `<header class="${subclass}">[${I}]&nbsp;${data}</header>`;
}
function create_subheader(data, subclass = ""){
	return `<header class="sub ${subclass}">${data}</header>`;
}
function create_field(name, val, subs = [], subclass=""){
	if(typeof subs === "function") val = subs(val);
	else val = subs[+val] || val;
	return `<div class="field ${subclass}"><span>${name}:</span><span>${val}</span></div>`;
}
function create_field_with_enable(name, value, enable, on_class = 'on', off_class = 'off') {
	return create_field(name, value, [], enable ? on_class : off_class);
}
function create_field_with_enable_x(name, value, status, on_class = 'on', off_class = 'off', x_class = 'xxx') {
	return create_field(name, value, [], status == '1' ? on_class : status == '0' ? off_class : x_class);
}

function create_text(val, subclass = ""){
	return `<div class="field ${subclass}"><span>${val}</span></div>`;
}
function create_auto_fields(data, names){
	res = "";
	for(let i = 0; i<names.length; i++){
		const val = data[names[i][0]];
		if(val === undefined){
			console.error(names[i][0], "is undefined");
		}
		res += create_field(names[i][1] || names[i][0], val, names[i][2]);
	}
	return res;
}
function create_signal(state, name){
	return `<div class="field signal ${state ? "on" : "off"}"><span>${name}:</span><span>${state ? "ON" : "OFF"}</span></div>`;
}
function create_auto_signals(data, names){
	res = "";
	for(let i = 0; i<names.length; i++){
		const val = data[names[i][0]];
		if(val === undefined){
			console.error(names[i][0], "is undefined");
		}
		res += create_signal(+val > 0 , names[i][1] || names[i][0]);
	}
	return res;
}

function parse_alu_op(op, op2, src){
	if(op == "x" || src == "x") return "x";
	let op_str = SUBS.ALU_OP[op];
	if(op_str.indexOf("_") !== -1){
		op_str = op_str.split("_")[op2];
	}
	return `${op_str}(${SUBS.ALU_SRC[src]})`;
}

const SUBS = {
	ALU_OP:   ["ADD_SUB", "SLL", "SLT", "SLTU", "XOR", "SRL_SRA", "OR", "AND"],
	ALU_SRC:  [	"R1,R2",   
				"R1,IMM",  
				"R1,+4", 
				"PC,R2",   
				"PC,IMM",  
				"PC,+4", 
				"0,R2", 
				"0,IMM",],
	IMM_TYPE: ["I", "S", "U", "J", "B"],
	WIDTH: ["s8", "s16", "s32", "s64", "u8", "u16", "u32", "u64", ],
	BRANCH_SRC: ["PC", "R1"],
	WB_SRC: [ "DATA_MEM","ALU_RES"],
	ALU_OP2: ["ADD_SRL", "SUB_SRA"],
	MUX_SRC: ["REG","EX","MEM","REG"],
    RAS_FSM: [  "IDLE","POP","POP_THEN_PUSH","PUSH","ABORTING"]
}

function create_FI(I,data){
	return create_header(I,"FETCH", 0, 0, data.stalled == '1') +
		create_auto_fields(data, [
			["pc_c","PC"],
			// ["o_pc"]
		]) +
		create_auto_signals(data, [
			["i_jump_branch","JUMP"],
			// ["i_flush"],
		]);
}

function create_NEXT(I,data){
	return create_header(I,"NEXT", 0, 0, data.stalled == '1', "light") +
		create_field_with_enable_x("Inject PM",    	data.inject_from_pm_addr_c, 	data.inject_from_pm_c)	+
		create_field_with_enable_x("Inject ID",    	data.inject_from_id_addr_c, 	data.inject_from_id_c)	+
		create_field("PC",		data.i_if_pc, 	[], 'light') +
		create_field("Old PC", 	data.old_pc, 	[], 'light') +
		create_field_with_enable_x("Jump",    		data.i_ex_jump_addr, 			data.i_ex_jump_branch		, 	"light") +
		create_field_with_enable_x("Old Inject", 	data.ex_inject_addr, 			data.ex_inject				, 	"light") +
		create_field_with_enable_x("Rollback",    	data.rollback_jump_addr_c, 		data.rollback_jump_c 		, 	"light") +
		create_field_with_enable_x("Discard", 		data.discard_jump_c, 			data.discard_jump_c 		, 	"light") + 
		create_field_with_enable_x("Flushed", 		data.was_prediction_flushed, 	data.was_prediction_flushed	, 	"light");
}

function create_PROGMEM(I,data){
	return create_header(I,"PROGMEM", 0, data.i_if_flush == '1', data.stalled != '1') +
		// create_field("SKID valid", data.i_valid_skid=='1'?'YES':'NO',[],data.i_valid_skid=='1'?'on':'off')+
		// create_field("Read",       data.i_read      =='1'?'YES':'NO',[],data.i_read      =='1'?'on':'off')+
		create_auto_fields(data, [
			// ["o_pc","PC_OUT"],
			// ['o_instr',"INST_OUT",parse_inst],
			["i_pc","PC"],
			['debug_instr_c',"INST",parse_inst]
		]);
}

function create_BTBCOUNTER(I,data){
	return create_header(I,"BTB_CNT", 0, 0, 0, "light") +
		create_field("Ri ki",  H2(data.read_key_c) + '_' + H2(data.read_index_c), [], "light")	+
		create_field_with_enable_x("Ro kc",   H2(data.read_entry_c_key) + '_' + H2(data.read_entry_c_cnt), data.read_entry_c_valid, "light")	+
		create_field_with_enable_x("Ro v",    H2(data.read_entry_c_value),                                 data.read_entry_c_valid, "light")	+
		create_field_with_enable_x("Ro out",  H2(data.o_read_value) + '_' + data.o_read_jump,              data.o_read_valid)	+
		create_field_with_enable_x("Wi ki",    H2(data.write_key_c)   + '_' + H2(data.write_index_c),      data.i_write_enable, "light")	+
		create_field_with_enable_x("Wi vj",    H2(data.i_write_value) + '_' + data.i_write_jump,           data.i_write_enable, "light")	+
		create_field_with_enable_x("Wo kc",   H2(data.write_entry_c_key) + '_' + H2(data.write_entry_c_cnt),   data.write_entry_c_valid, "light")	+
		create_field_with_enable_x("Wo v",    H2(data.write_entry_c_value),                                    data.write_entry_c_valid, "light");
}

function create_ID(I,data){
	return create_header(I,"DECODE",
			data.c_valid_instr != "1",
			data.c_flush == "1",
			data.stalled == '1'
		)+
		create_auto_fields(data, [
			["i_pc","PC"],
			["i_instr","INST",parse_inst],
		])+
		// create_field("OP", 
		// 	SUBS.ALU_SRC[data.c_alu_src]+"->"+
		// 	SUBS.ALU_OP[data.c_alu_op]+"&nbsp;"+SUBS.ALU_OP2[data.c_add_sub_srl_sra]
		// )+
		create_field("OP", parse_alu_op(data.c_alu_op, data.c_add_sub_srl_sra, data.c_alu_src))+
		create_auto_fields(data, [
			// ["c_imm","TYPE",SUBS.IMM_TYPE],
			// ["c_rs1_addr","R1_a"],
			// ["c_rs2_addr","R2_a"],
			// ["c_rd_addr", "Rd_a"],
			["c_width","FORMAT",SUBS.WIDTH],
			// ["c_branch_op","BRANCH_TYPE"],
			// ["c_pc_src","BASE",SUBS.BRANCH_SRC],
			["c_imm_data","IMM",H2],
			["c_wb_src","WB_SRC",SUBS.WB_SRC],
		]) +
		create_auto_signals(data, [
			// ["c_jump", "JUMP"],
			// ["c_branch", "BRANCH"],
			["c_rd_write","WRITE_RD"],
			["c_read","READ_MEM"],
			["c_write","WRITE_MEM"],
			// ["c_csr_write"],
			// ["c_csr_read"],
			// ["c_csr_rs1_imm"],
		]);
		// create_REG(0,reg,false);
}

function create_REG_READ(data){
    const r = data.register_rd_en_c == '1' ? "on" : "off";
	const w1 = (data.register_wr_en_c == '1' && data.i_ras_read == '1') ? "mid" : "off";
	const w2 = (data.register_wr_en_c == '1' && data.i_rd_write == '1') ? "mid" : "off";
    return create_field("READ",
            `x${data.i_rs1_addr}:${H2(data.debug_rs1_data)} `+
            `x${data.i_rs2_addr}:${H2(data.debug_rs2_data)}`,[], r)+

            create_subheader("WRITEBACK", "mid")+
            create_field("WRITE_TO_RD",
            `x${data.i_rd_addr}=${H2(data.i_rd_write_data)}`,[], w2)+
            create_field("WRITE_FROM_RAS",
            `x${data.wr_addr_c}=${H2(data.i_ras_data)}`,[], w1);
}

function create_WB(I,data){
	const r = data.register_rd_en_c == '1' ? "on" : "off";
	const w1 = (data.register_wr_en_c == '1' && data.i_ras_read == '1') ? "on" : "off";
	const w2 = (data.register_wr_en_c == '1' && data.i_rd_write == '1') ? "on" : "off";
	return create_header(I, "WRITEBACK",0,0,data.stalled == '1')+
		create_field("WRITE_TO_RD",
		`x${data.i_rd_addr}=${H2(data.i_rd_write_data)}`,[], w2)+
		create_field("WRITE_FROM_RAS",
		`x${data.wr_addr_c}=${H2(data.i_ras_data)}`,[], w1);
		// create_field("Mask", MASK(data.i_mask_data))+
		// create_field("Load", "M["+(data.i_addr_w)+"]:"+H2(data.o_data),[],data.i_read =='1'?"on":"off")+
		// create_field("Store","M["+(data.i_addr_r)+"]="+H2(data.i_data),[],data.i_write=='1'?"on":"off");
		
}

function create_EX(I,data){
	return create_header(I, "EXECUTE",
			data.i_valid_instr != '1',
			data.flush_c == '1',
			data.stalled == '1')+
		create_auto_fields(data, [
			["i_pc","PC"],
		])+
		// create_field("OP", 
		// 	SUBS.ALU_SRC[data.i_alu_src]+"->"+
		// 	SUBS.ALU_OP[data.i_alu_op]+"&nbsp;"+SUBS.ALU_OP2[data.i_add_sub_srl_sra]
		// )+
		create_field("OP", parse_alu_op(data.i_alu_op, data.i_add_sub_srl_sra, data.i_alu_src))+
		create_auto_fields(data, [
			// ["i_imm","TYPE",SUBS.IMM_TYPE],
			// ["i_width","width",SUBS.WIDTH],
			// ["i_branch_op","BRANCH_TYPE"],
			// ["i_pc_src","BASE",SUBS.BRANCH_SRC],
			["i_wb_src","WB_SRC",SUBS.WB_SRC],
			// ["pc_c", "JUMP_PC"],
			// ['rs2_data_c',,H2],
			["i_imm_data", "IMM", H2],
		])+
		create_field("MUX", `[${SUBS.MUX_SRC[data.mux1_src]},${SUBS.MUX_SRC[data.mux2_src]},${SUBS.MUX_SRC[data.mux3_src]}]`)+
		create_field("R1", R2(data.i_rs1_addr)+":"+H2(data.i_rs1_data))+
		create_field("R2", R2(data.i_rs2_addr)+":"+H2(data.i_rs2_data))+
		create_field("V1", H2(data.value1_c))+
		create_field("V2", H2(data.value2_c))+
		create_field("RES",R2(data.i_rd_addr) +"="+H2(data.alu_data_c),[],data.i_rd_write=='1'?"on":"off")+
		create_field("RES_EX",  R2(data.i_ex_rd_addr) +"="+H2(data.i_alu_data),[],data.i_ex_rd_write=='1'?"on":"off")+
		create_field("RES_MEM", R2(data.i_mem_rd_addr)+"="+H2(data.i_wr_data), [],data.i_mem_rd_write=='1'?"on":"off")+
		create_field("JUMP","PC="+(data.pc_c), [],data.jump_branch_c=='1'?"on":"off")+
		create_field("Wait Load",data.wait_for_load,[],data.wait_for_load=='1'?"on":"off")+
		create_field("Load",R2(data.i_rd_addr) +"=M["+(data.alu_data_c)+"]",[],data.i_read=='1'?"on":"off")+
		create_field("Store","M["+(data.alu_data_c)+"]="+H2(data.rs2_data_c),[],data.i_write=='1'?"on":"off");
		// create_auto_signals(data, [
			// ["i_jump", "JUMP"],
			// ["i_branch", "BRANCH"],
			// ["jump_branch_c", "JUMP_OR_BRANCH"],
			// ["i_rd_write","WRITE_RD"],
			// ["i_ex_rd_write","WAS_WRITE_RD_EX"],
			// ["i_mem_rd_write","WAS_WRITE_RD_MEM"],
			// ["i_read","READ_MEM"],
			// ["i_write","WRITE_MEM"],
		// ]);

	
}

function create_MEM(I, data){
	return create_header(I, "MEM",
			data.i_valid_instr != '1',
			data.flush_c == '1',
			data.stalled == '1')+
		create_auto_fields(data, [
			["i_width","WIDTH",SUBS.WIDTH],
			["i_wb_src","WB_SRC",SUBS.WB_SRC],
			["i_alu_data","MEM_ADDR"],
			["i_rs2_data","TO_WRITE(raw)",H2],
			["i_rd_data","LAST_READ(raw)",H2],
			["rd_mask","MEM_MASK",MASK],
		])+
		create_field("WB",     R2(data.i_rd_addr)+"="+H2(data.rd_write_data_c),[],data.c_rd_write=='1'?"on":"off")+
		create_field("Store", `M[${data.i_alu_data}]`+"="+H2(data.rs2_data_shft),[],data.c_write=='1'?"on":"off")+
		create_field("Load",   R2(data.i_rd_addr)+"="+`M[${data.i_alu_data}]`,[],data.c_read=='1'?"on":"off");
		// create_auto_signals(data, [
		// 	["c_rd_write", "WRITE_RD"],
		// 	["c_write", "WRITE"],
		// 	["c_read", "READ"],
		// ]);
}

function create_RAS1(I, data){
    return create_header(I, "RAS_1") + 
        create_auto_fields(data, [
            ["ras_fsm_nxt_c",  "STATE", SUBS.RAS_FSM],
        ])+
        create_auto_signals(data, [
            ["i_pop",   "POP"],
            ["i_push",  "PUSH"],
            ["i_pop_then_push", "POP_THEN_PUSH"],
        ]);
}
function create_RAS2(I, data){
    return create_header(I, "RAS_2") + 
        create_auto_fields(data, [
            ["ras_nxt_c", "CNT"],
        ])+
        create_auto_signals(data, [
            ["push_c", "PUSH"],
            ["pop_c", "POP"],
        ]);
}
function create_RAS3(I, data){
    return create_header(I, "RAS_3") + 
        create_auto_fields(data, [
            ["o_pop_addr", "POP_ADDR"],
            ["o_push_addr", "PUSH_ADDR"],
        ]);
}

function create_DATA(I, title, addr_fnc, val_fnc, data, prev, filter_zeros=false){
	return create_header(I,title,0,0,0,"data_lookup")+
		data.map((x,i) => 
			filter_zeros && x=='0' ? "" :
				create_field(addr_fnc(i), val_fnc(x), [], `data_lookup ${!prev || prev[i]!=data[i] ? "marked" : ""}`)).join('');
}
function create_DATAI(I, title, addr_fnc, val_fnc, data, prev, filter_zeros=false){
	return create_header(I,title,0,0,0,"data_lookup")+
		data.map((x,i) => 
			filter_zeros && x=='0' ? "" :
				create_field(addr_fnc(i), val_fnc(i,x), [], `data_lookup ${!prev || prev[i]!=data[i] ? "marked" : ""}`)).join('');
}

function create_REGDATA(I, data, prev){
	return create_DATA  (I, "REG DATA", R2, H2, data, prev, true);
}

function parse_btb_counter_entry(params, index, entry) {
	if(entry.includes('x') || entry.includes('X')) return 'X';
	if(entry.includes('z') || entry.includes('Z')) return 'Z';
	const valid_off 	= 1;
	const addr_off  	= valid_off+(+params.ADDR_WIDTH)-(+params.INDEX_WIDTH);
	const value_off 	= addr_off+(+params.VALUE_WIDTH);
	const bin = W(BigInt(entry).toString(2), value_off + (+params.COUNTER_WIDTH));
	// console.log(bin, valid_off, addr_off, value_off);
	// console.log(typeof bin, typeof valid_off, typeof addr_off, typeof value_off);
	const valid    = bin[0];
	const addr     = BigInt('0b' + bin.slice(valid_off,addr_off) + '0'.repeat(+params.INDEX_WIDTH) + '00') + BigInt(index*4);
	const value    = BigInt('0b' + bin.slice(addr_off,value_off) + '00');
	const counter  = BigInt('0b' + bin.slice(value_off));
	const res = valid + '_' + addr.toString(10) + '_' + value.toString(10) + '_' + W(counter.toString(2),+params.COUNTER_WIDTH);
	return res;
}

function create_BTBCOUNTERDATA(I, data, prev){
	return create_DATAI (I, "BTB DATA", H2, parse_btb_counter_entry.bind(null, data), data, prev, true);
}

function create_MEMDATA(I, data, prev){
	return create_DATA  (I, "MEM DATA",   x=>x*8,  x=>x.replace(/x/g,'.'), data, prev)+
		create_field('Read &nbsp' + (data.r_valid=='1'?"V":"_") + (data.r_ready=='1'?"R":"_"), `M[${data.r_addr}]`+"="+H2(data.r_data),[], data.r_ready=="1"?"on":"off")+  
		create_field('Write&nbsp' + (data.w_valid=='1'?"V":"_") + (data.w_ready=='1'?"R":"_"), `M[${data.w_addr}]`+"="+H2(data.w_data),[], data.w_valid=="1"?"on":"off")+  
		create_field("Strb", H2(data.strb), [], data.w_valid=="1"?"on":"off")
}

function create_CHEDATA(I, data, prev){
	return create_DATA  (I, "CACHE DATA", x=>x, x=>x, data, prev)+
		create_field("Write", `C[${data.i_wr_addr}]`+"="+data.i_data,[],data.i_write=='1'?"on":"off")+
		create_field("Read",  `C[${data.i_rd_addr}]`,[],data.i_read=='1'?"on":"off")+
		create_field("o_data",  data.o_data)
		// create_auto_fields(data,[
		//     ["i_read"],     
		//     ["i_write"],    
		//     ["i_data"],     
		//     ["i_rd_addr"],
		//     ["i_wr_addr"], 
		//     ["o_data"],     
		// ]) 
}


//////// INST DEOCDE //////

function parse_inst_fields(inst,shift=0){
	return {
		op: inst.slice(-7),
		rd: inst.slice(-12, -7),
		f3: inst.slice(-15,-12),
		r1: inst.slice(-20,-15),
		r2: inst.slice(-25-shift,-20),
		f7: inst.slice(-32,-25-shift),
	};
}

function R(bin){
	return "x" + parseInt(bin,2);
}
function R2(dec){
	return "x" + parseInt(dec);
}
function H(bin,pow=0){
	return "0x"+(BigInt(parseInt(bin,2))*BigInt(2**pow)).toString(16);
}
function H2(dec,pow=0){
	if(dec === undefined) return "undefined";
	if(dec === "x" || dec === "X") return "x";
	if(dec === "z" || dec === "Z") return "z";
	return "0x"+(BigInt(dec)*BigInt(2**pow)).toString(16).toUpperCase();
}
function MASK(dec){
	if(dec === "x") return "x";
	// return "0x"+(+dec).toString(2).replace(/1/g,"ff").replace(/0/g,"00");
	return W((+dec).toString(2),8);
}

function W(str, width) {
    return ("0".repeat(width)+str).slice(-width)
}

function parse_inst(inst_dec){
	if(inst_dec === "x") return "x";
	else if(inst_dec === "0") return "0";
	let inst_bin = W(BigInt(inst_dec).toString(2), 32);
	for(let inst in INST_PARSER){
		const parser = INST_PARSER[inst];
		const parse_res = parser(inst_bin);
		if(parse_res === null) continue;
		return (parse_res[1] + "|" + inst + "&nbsp;" + parse_res[0].join(','));
	}
	return inst_bin;
}

const PARSERS = {
    "R": function (_op, _f3, _f7) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op || f3 != _f3 || f7 != _f7) return null;
			return [[R(rd), R(r1), R(r2)],"R"];
        };
    },
    "r": function (_op, _f3, _f7) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst,1);
			if(op != _op || f3 != _f3 || f7 != _f7) return null;
			return [[R(rd), R(r1), H(r2)],"r"];
        };
    },
    "I": function(_op, _f3) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op || f3 != _f3) return null;
			return [[R(rd), R(r1), H(f7+r2)],"I"];
        };
    },
    "S": function(_op, _f3) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op || f3 != _f3) return null;
			return [[R(r1), R(r2), H(f7+rd)],"S"];
        };
    },
    "B": function(_op, _f3) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op || f3 != _f3) return null;
			let imm = f7[0] + rd[4] + f7.slice(1) + rd.slice(0,-1);
			return [[R(r1), R(r2), H(imm,1)], "B"];
        };
    },
    "U": function (_op) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op) return null;
            return [[R(rd), H(f7+r2+r1+f3,12)],"U"];
        };
    },
    "J": function(_op) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op) return null;
			let imm = f7+r2+r1+f3;
			imm = imm[0] + imm.slice(-8) + imm[9] + imm.slice(1,11);
            return [[R(rd), H(imm,1)],"J"];
        };
    },
    "E": function(_op,_val) {
        return function(inst) {
			const {op,rd,f3,r1,r2,f7} = parse_inst_fields(inst);
			if(op != _op || (f7+r2+r1+f3+rd) != _val) return null;
            return [[],"E"];
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
    SLLIW:      PARSERS.I("0011011", "001","0000000"),
    SRLIW:      PARSERS.I("0011011", "101","0000000"),
    SRAIW:      PARSERS.I("0011011", "101","0100000"),
    ADDW:       PARSERS.R("0111011", "000","0000000"),
    SUBW:       PARSERS.R("0111011", "000","0100000"),
    SLLW:       PARSERS.R("0111011", "001","0000000"),
    SRLW:       PARSERS.R("0111011", "101","0000000"),
    SRAW:       PARSERS.R("0111011", "101","0100000"),
};

/////// HTML /////////
function create_pipeline_table(data){
	// const headers = [];
	const NEXT = [];
	const FI = [];
	const PROGMEM = [];
	const BTBCOUNTER = [];
	const ID = [];
	const REG_READ = [];
	const EX = [];
	const MEM = [];
	const WB = [];
    const RAS1 = [];
    const RAS2 = [];
    const RAS3 = [];
	const REGDATA = [];
	const BTBCOUNTERDATA = [];
	const MEMDATA = [];
	const CHEDATA = [];
	for(let i=0; i<data.length; i++){
		// headers.push(data[i].SIM.i + (
		// 	data[i].SIM.en =='0'? ('(!en)') :
		// 	data[i].SIM.nres == '0'? ('(reset)') : ""
		// ));
		NEXT.push	        (create_NEXT	       (data[i].SIM.i, data[i].NEXT));
		FI.push		        (create_FI		       (data[i].SIM.i, data[i].FI));
		PROGMEM.push        (create_PROGMEM        (data[i].SIM.i, data[i].PROGMEM));
		BTBCOUNTER.push     (create_BTBCOUNTER     (data[i].SIM.i, data[i].BTBCOUNTER));
		ID.push		        (create_ID		       (data[i].SIM.i, data[i].ID));
		REG_READ.push       (create_REG_READ       (data[i].REG));
		EX.push		        (create_EX		       (data[i].SIM.i, data[i].EX));
		MEM.push	        (create_MEM		       (data[i].SIM.i, data[i].MEM));
		WB.push		        (create_WB		       (data[i].SIM.i, data[i].REG));
        RAS1.push           (create_RAS1           (data[i].SIM.i, data[i].RAS1));
        RAS2.push           (create_RAS2           (data[i].SIM.i, data[i].RAS2));
        RAS3.push           (create_RAS3           (data[i].SIM.i, data[i].RAS3));
		REGDATA.push        (create_REGDATA        (data[i].SIM.i, data[i].REGDATA,     data[i-1]?.REGDATA));
		BTBCOUNTERDATA.push (create_BTBCOUNTERDATA (data[i].SIM.i, data[i].BTBCOUNTERE, data[i-1]?.BTBCOUNTERE));
		MEMDATA.push        (create_MEMDATA        (data[i].SIM.i, data[i].MEMDATA,     data[i-1]?.MEMDATA));
        CHEDATA.push        (create_CHEDATA        (data[i].SIM.i, data[i].CHEDATA,     data[i-1]?.CHEDATA));
	}
    const merge = (arr1, arr2) => arr1.map((x,i) => arr1[i]+arr2[i]);
    const table = [
    	data[0].NEXT.stalled !== undefined?            merge(FI, NEXT) : FI,
    	data[0].BTBCOUNTER.read_index_c !== undefined? merge(PROGMEM, BTBCOUNTER) : PROGMEM,
        merge(ID, REG_READ),
        EX,
        merge(MEM, RAS1),
        merge(WB, RAS2),
        merge(REGDATA, RAS3),
        CHEDATA,
        MEMDATA,
		BTBCOUNTERDATA,
    ];
	return table;
}

const table = create_pipeline_table(filtered_data);


console.log("Created Pipeline.")

const html = /*html*/`
<head>
<style>

	body * {
		box-sizing: border-box;
		word-wrap: none;
		font-family: monospace;
	}

	td{
		border: 1px solid gray;
		padding: 2px;
	}
	td > header {
		padding: 5px;
		border-bottom:2px solid black;
        border-top:   2px solid black;
		background-color: limegreen;
	}
	td > header.invalid {
		background-color: red;
	}
	td > header.stalled {
		background-color: cyan;
	}
	td > header.flushed{
		background-color: lightblue;
	}
	td > header.sub{
		padding: 3px;
		border-bottom: 1px dashed black;
	}
	td > header.on{
		background-color: limegreen;
	}
	td > header.off{
		background-color: lightgray;
		color: gray;
	}
	td > .data_lookup {
		background-color: yellow;
	}
	td > .field.data_lookup {
		background-color: yellowgreen;
	}
	td > .marked {
		color: red;
		font-weight: bold;
	}
	td > .field {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		border-bottom: 1px dashed gray;
		background-color: limegreen;
	}
	td > .on {
	}
	td > .light{
		background-color: lightgreen;
	}
	td > .mid {
		background-color: gray;
	}
	td > .xxx {
		background-color: red;
	}
	td > .off {
		background-color: lightgray;
		text-decoration: line-through;
		color: gray;
	}

	.diagram {
		display: none;
	}

</style>
</head>
<body>

<main id="table_content">

</main>

<script>

	const aux_data_mem_stalls  = ${JSON.stringify(aux_data_mem_stalls)};
	const aux_data_wait_stalls = ${JSON.stringify(aux_data_wait_stalls)};
	
	const offs 		= [6,5,4,3,2,1,0,0,0,0];
	const wait_offs	= [0,0,0,0,1,2,3,3,3,3];
	const pipeline_redraws_count = 4;

	let flag_flow          = true;
	let flag_shift         = false;
	let flag_transpose     = true;
	let flag_no_full_stall = false;
	let flag_no_ext_stall  = true;
	window.addEventListener('keypress', (e) => {
		switch(e.key) {
			case 'q' : flag_flow           = !flag_flow;		    break;
			case 'w' : flag_shift          = !flag_shift;		    break;
			case 'e' : flag_transpose      = !flag_transpose;	    break;
			case 'r' : flag_no_full_stall  = !flag_no_full_stall;	break;
			case 't' : flag_no_ext_stall   = !flag_no_ext_stall;	break;
		}
		update_render();
	});
	update_render();

	function update_render(){

		let table = ${JSON.stringify(table)};
		const true_flag_shift        = flag_shift && flag_flow && flag_transpose;
		const true_flag_no_ext_stall = flag_no_ext_stall && flag_flow;


		if(flag_no_full_stall) {
			table = table.map(x => x.filter( (xx, ii) => aux_data_mem_stalls[ii] == 0 ));
			if(true_flag_no_ext_stall) {
				const filtered_aux_data_wait_stalls = aux_data_wait_stalls.filter( (xx, ii) => aux_data_mem_stalls[ii] == 0 );
				table = table.map((x, i) => 
					true_flag_shift ? 
						x.map(    (xx, ii) => ii < 3 || filtered_aux_data_wait_stalls[ii - wait_offs[i]] == 0 ? xx : (i == 0 ? "{{SHIFT}}" : "") ) : 
						x.filter( (xx, ii) => ii < 3 || filtered_aux_data_wait_stalls[ii - wait_offs[i]] == 0 )
				);
			}
		}

		if(flag_flow) {
			table = shift_pipeline(table);
		}
		if(flag_transpose) {
			table = transpose(table);
		}

		if(true_flag_shift && true_flag_no_ext_stall) {
			for(let i=table.length-1; i>=0; i--) {
				if(table[i][0] == "{{SHIFT}}") {
					let temp = [];
					for(let j=0; j<pipeline_redraws_count; j++) {
						temp = table[i-j].splice(j+1, Infinity, ...temp);
					}
					table.splice(i, 1);
					for(let j=i; j<table.length; j++) {
						table[j].splice(0, 0, "");
					}
				}
			}
		}

		
		const table_rows = table.map(x => x.map(xx => "<td>"+xx+"</td>").join(''));

		if(true_flag_shift) {
			for(let i=1; i<table.length; i++) {
				table_rows[i] = "<td colspan="+i+"></td>"+table_rows[i];
			}
		}

		const table_full = table_rows.map(x => "<tr>"+x+"</tr>").join('');

		document.getElementById('table_content').innerHTML = "<table>"+table_full+"</table>";
	}

function transpose(table){
	let res = [];
	for(let i in table){
		for(let j in table[i]){
			if(res[j] === undefined) res[j] = [];
			res[j][i] = table[i][j];
		}
	}
	return res;
}

function shift_pipeline(table,un=false){
	for(let i=0; i<table.length; i++){
		const lim  = un ? i : offs[0]-offs[i];
		for(let j=0; j<lim; j++){
			if(un) table[i].unshift("");
			else   table[i].shift();
		}
		if(!un){
			for(let j=0; j<offs[i]; j++){
				table[i].pop();
			}
		}
	}
	return table;
}
</script>

</body>
`

if(html_file)
	fs.writeFileSync(html_file, html);

