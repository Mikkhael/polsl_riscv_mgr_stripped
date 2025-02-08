//@ts-check
const { count } = require("console");
const fs = require("fs");
const path = require('path');

const ARGV = process.argv.slice(2);

function parse_option(name) {
    const index = ARGV.findIndex(x => x.startsWith(`--${name}=`));
    if(index == -1) {
        return undefined;
    }
    const val = ARGV[index].split('=')[1];
    ARGV.splice(index, 1);
    return val;
}

const options = {
    output: parse_option('output'),
    app:    parse_option('app'),
};

const csv_files = ARGV;

function zip(a1, a2) {
    return a1.map((x,i) => [x, a2[i]]);
}

function parse_dec(str) {
    if(typeof str === 'string' && str.match(/[xXzZ]/)) return NaN;
    return parseInt(str);
}

function parse_row(row) {
    const out = {
        jal         : row.signals[0]   === '1',
        jalr        : row.signals[1]   === '1',
        branch      : row.signals[2]   === '1',
        rs1_zero    : row.signals[3]   === '1',
        rs1_ra      : row.signals[4]   === '1',
        imm_sign    : row.signals[5]   === '1',
        inject      : row.inject       === '1',
        discard     : row.discard      === '1',
        jump_branch : row.jump_branch  === '1',
        rollback    : row.rollback     === '1',
        flushed_pm  : row.flushed_pm   === '1',
        sim_good    : row.sim_good     === '1',
        
        
        total_fetched    : parse_dec(row.total_fetched),
        total_executed   : parse_dec(row.total_executed),
        pc               : parse_dec(row.pc),
        total_cycle      : parse_dec(row.total_cycle),
        total_flushed_ex : parse_dec(row.total_flushed_ex),
        jump_addr        : parse_dec(row.jump_addr),
        inject_addr      : parse_dec(row.inject_addr),
        rollback_addr    : parse_dec(row.rollback_addr),

        evicts_btb : parse_dec(row.evicts_btb),
        evicts_bht : parse_dec(row.evicts_bht),
        evicts_ret : parse_dec(row.evicts_ret),
    };
    

    return out;
}

/**
 * @param {object} data
 * @param {string} type
 * @param {string} match
 * @param {boolean} [flushed_pm]
 */
function count_if(data, type, match, flushed_pm, as_list = false) {
    const res = data.filter( row => {
        let good = true;
        switch(type) {
            case "jal"  : good =  row.jal; break;
            case "jalr" : good =  row.jalr; break;
            case "br"   : good =  row.branch; break;
            case "jump" : good =  row.jal || row.jalr; break;
            case "abs"  : good =  row.jalr && row.rs1_zero; break;
            case "ret"  : good =  row.jalr && row.rs1_ra; break;
            case "total": good =  row.jal || row.jalr || row.branch; break;
            case "none" : good =!(row.jal || row.jalr || row.branch); break;
        }
        if(!good) return false;

        if(flushed_pm === true  && !row.flushed_pm) return false;
        if(flushed_pm === false &&  row.flushed_pm) return false;

        switch(match) {
            case "hit"          : good = row.inject === row.jump_branch && (!row.inject || row.jump_addr === row.inject_addr); break;
            case "miss_target"  : good = row.inject === row.jump_branch &&   row.inject && row.jump_addr !== row.inject_addr;  break;
            case "miss"         : good = row.inject !== row.jump_branch; break;
            case "inject"       : good = row.inject; break;
        }
        
        return good;
    });
    return as_list ? [res.length, res] : res.length;
}

/**
 * 
 * @param {string} match 
 * @param {boolean} [flushed_pm]
 * @returns 
 */
function generate_summary_for_all_types(data, match, flushed_pm) {
    return {
        jal  : count_if(data, 'jal'  , match, flushed_pm),
        jalr : count_if(data, 'jalr' , match, flushed_pm),
        br   : count_if(data, 'br'   , match, flushed_pm),
        jump : count_if(data, 'jump' , match, flushed_pm),
        abs  : count_if(data, 'abs'  , match, flushed_pm),
        ret  : count_if(data, 'ret'  , match, flushed_pm),
        total: count_if(data, 'total', match, flushed_pm),
    };
}

function get_single_file_summary(csv_file) {
    const csv_raw = fs.readFileSync(csv_file);
    const csv = csv_raw.toString().split(/\r?\n/g).map(x => x.split(',').map(x => x.trim()));
    csv.pop();
    const csv_headers = csv.shift();
    const data = csv.map(row => Object.fromEntries( zip(csv_headers, row) )).map(parse_row);
    const last = data.pop();

    const summary = {};
    summary.flushed  = last?.total_flushed_ex || 0;
    summary.executed = last?.total_executed || 0;
    summary.sim_good    = last?.sim_good || false;
    summary.jumps       = generate_summary_for_all_types(data, 'any');
    summary.hit         = generate_summary_for_all_types(data, 'hit', false);
    summary.hit_late    = generate_summary_for_all_types(data, 'hit', true);
    summary.miss_target = generate_summary_for_all_types(data, 'miss_target');
    summary.miss        = generate_summary_for_all_types(data, 'miss');
    const [missfires_count, missfires_list] = count_if(data, "none", "inject", undefined, true);
    const [_1, jal_pm_miss_list] = count_if(data, "jal", 'miss_target', true, true);
    const [_2, jal_misses_list]  = count_if(data, "jal", 'miss', undefined, true);
    summary.missfires = missfires_count;
    summary.missfires_list = missfires_list.map(x => { return {
        pc: x.pc,
        fetched: x.total_fetched,
        executed: x.total_executed,
        inject_addr: x.inject_addr,
        rollback_addr: x.rollback_addr,
        rollback: x.rollback
    };});
    summary.jal_pm_miss_list = jal_pm_miss_list.map(x => { return {
        pc: x.pc.toString(16),
        inject_addr: x.inject_addr.toString(16),
    };});
    summary.evicts = [
        last?.evicts_btb || 0,
        last?.evicts_bht || 0,
        last?.evicts_ret || 0,
    ];
    const unique_jal_misses = {};
    for(let x of jal_misses_list){
        const pc = x.pc.toString(16);
        if(unique_jal_misses[pc] === undefined) {
            unique_jal_misses[pc]  = 1;
        } else {
            unique_jal_misses[pc] += 1;
        }
    }
    summary.unique_jal_misses = unique_jal_misses;
    return summary;
}

function get_filename(csv_file) {
    return path.basename(csv_file, '.csv');
}

function pad(str = '', width = 0, pad_ch = ' ') {
    const to_pad = width - str.length;
    if(to_pad > 0) {
        return pad_ch.repeat(to_pad) + str;
    }
    return str;
}

/**
 * 
 * @param {number[]} vals
 * @param {number} total 
 * @returns 
 */
function get_proc_str_arr(vals, total) {
    if(total === 0) {
        return " --- ";
    }
    const procs  = vals.map(val => val / total * 100).map(val => (Math.round(val * 10) / 10) + '%');
    return `${procs.join('+')} (${vals.join('+')}/${total})`;
}

function get_padded(arr, sim_good = true) {
    const PADS = [58, 20, 27, 27, 27, 7, 3];
    const res = PADS.map((p, i) => pad(arr[i], p));
    return (sim_good ? "  " : "X ") + res.join(' |');
}

/**
 * @param {Object.<string,Number>} o1 
 * @param {Object.<string,Number>} o2 
 * @returns {Object.<string,Number>}
 */
function sum_obj(o1, o2) {
    const res = Object.apply({}, o1);
    for(let key in o1) {
        res[key] = o1[key] + o2[key];
    }
    return res;
}

function get_summary_row(file) {
    const name = get_filename(file);
    const summ = get_single_file_summary(file);

    console.log(name, summ)

    const all   = get_proc_str_arr([summ.flushed], summ.flushed + summ.executed);
    // const arr   = [summ.miss, summ.miss_target, summ.hit_late];
    const arr   = [sum_obj(summ.miss, summ.miss_target), summ.hit_late];
    const jal   = get_proc_str_arr(arr.map(x=>x.jal  ), summ.jumps.jal );
    const jalr  = get_proc_str_arr(arr.map(x=>x.jalr ), summ.jumps.jalr);
    const br    = get_proc_str_arr(arr.map(x=>x.br   ), summ.jumps.br  );
    const evicts = summ.evicts.join('+');
    const missfires = summ.missfires;
    const simgood = summ.sim_good;


    return get_padded([name, all, jal, jalr, br, evicts, missfires], simgood);
}

const summary_header = get_padded(['NAME', 'FLUSHES', 'MISSES JAL', 'MISSES JALR', 'MISSES BR', 'EVICTS', 'MF']);

const summary_rows = csv_files.map(get_summary_row);

console.log(summary_header);
summary_rows.forEach(row => console.log(row));

if(options.output) {
    if(options.app) {
        const out = summary_rows.join('\n') + '\n';
        fs.appendFileSync(options.output, out);
    } else {
        const out = summary_header + '\n' + summary_rows.join('\n') + '\n';
        fs.writeFileSync(options.output, out);
    }
}