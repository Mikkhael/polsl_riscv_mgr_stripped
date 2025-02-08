task INIT_NLOG(output integer nextlog_file); begin
    `ifdef OUT_NEXT_LOG_FILE_NAME
    nextlog_file = $fopen(`OUT_NEXT_LOG_FILE_NAME);
    $fdisplay(nextlog_file, "total_cycles",
        ",total_fetched",
        ",total_flushed_ex",
        ",total_executed",
        ",sim_good",
        ",signals",
        ",pc",
        ",jump_addr",
        ",jump_branch",
        ",inject",
        ",inject_addr",
        ",discard",
        ",rollback",
        ",rollback_addr",
        ",flushed_pm",

        ",evicts_btb",
        ",evicts_bht",
        ",evicts_ret",
    );
    `else
    nextlog_file = 0;
    `endif
end endtask

task PRINT_NLOG(input integer nextlog_file, input force_print); begin
    `ifdef USE_JUMP_PREDICTOR
    if(nextlog_file != 0 && 
        nreset && enable && (
            force_print || (
                !UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.was_prediction_flushed &&
                !UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_stall && (
                    UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.old_jump_r ||
                    UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.old_branch_r ||
                    UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_inject_r
                )
            )
        )
    )
    $fdisplay(nextlog_file,  "%0d", total_cycles,
        ",%0d", total_fetched,
        ",%0d", total_flushed_ex,
        ",%0d", total_executed,
        ",%0d", sim_good,
        ",%b",  UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.old_signals_r,               
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.old_pc_r,               // EX stage
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_ex_jump_addr,         // EX stage
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_ex_jump_branch,       // EX stage
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_inject_r,            // in EX
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_inject_addr_r,       // in EX
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.discard_jump_c,         
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.rollback_jump_c,
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.rollback_jump_addr_c,
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_pm_inject_flush_r,

        // evicts
        `ifdef USE_BTB_COUNTER
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.evicts,
        `else
        ",%0d", 0,
        `endif

        `ifdef BHT_HIST_WIDTH
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.bht.evicts,
        `else
        ",%0d", 0,
        `endif
        
        `ifdef RET_INDEX_WIDTH
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.ret_table.evicts
        `else
        ",%0d", 0
        `endif
    );
    `else
    if(nextlog_file != 0 && 
        nreset && enable && ( 
            force_print || (
                is_new_instr &&
                (pipelined_signals.jal ||
                 pipelined_signals.jalr ||
                 pipelined_signals.branch)
            )
        )
    )
    $fdisplay(nextlog_file,  "%0d", total_cycles,
        ",%0d", total_fetched,
        ",%0d", total_flushed_ex,
        ",%0d", total_executed,
        ",%0d", sim_good,
        ",%b",  pipelined_signals, // signals
        ",%0d", pipelined_pc, // pc
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_pc, // jump addr
        ",%0d", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_jump_branch, // jump branch
        ",%0d", 1'd0,
        ",%0d", 0,
        ",%0d", 1'd0,
        ",%0d", 1'd0,
        ",%0d", 0,
        ",%0d", 1'd0,
        
        // evicts
        ",%0d", 0,
        ",%0d", 0,
        ",%0d", 0
    );
    `endif
end endtask
