`ifdef USE_JUMP_PREDICTOR

import riscv_next_pkg::*;

interface riscv_next_strategy_from_pm_intf # (parameter ADDR_WIDTH = 16) (
    input [ADDR_WIDTH-1:0] i_if_pc,
    input [ADDR_WIDTH-1:0] i_pm_pc,
    input i_pm_flush,
    input [ADDR_WIDTH-1:0] i_ra_data,
    output                  o_inject,
    output [ADDR_WIDTH-1:0] o_inject_addr
);
    // modport prot(input i_if_pc, i_pm_pc, i_pm_flush,
    //              output o_inject, o_inject_addr);
endinterface
interface riscv_next_strategy_from_id_intf # (parameter ADDR_WIDTH = 16) (
    input [ADDR_WIDTH-1:0] i_id_pc,
    `ifdef SIMULATION
    input wire next_instr_signals_t i_id_signals,
    `else
    input next_instr_signals_t i_id_signals,
    `endif
    input i_id_flush,
    input [ADDR_WIDTH-1:0] i_ra_data,

    output                  o_inject,
    output [ADDR_WIDTH-1:0] o_inject_addr
);
endinterface

interface riscv_next_strategy_history_intf # (parameter ADDR_WIDTH = 16) (
    input [ADDR_WIDTH-1:0] i_pc,
    input i_flush,
    input i_jump_branch,
    input [ADDR_WIDTH-1:0] i_jump_addr,
    `ifdef SIMULATION
    input wire next_instr_signals_t i_signals
    `else
    input next_instr_signals_t i_signals
    `endif
);
endinterface

`endif