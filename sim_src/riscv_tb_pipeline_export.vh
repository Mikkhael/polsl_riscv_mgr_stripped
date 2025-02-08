task INIT_CSV(output integer simout_file); begin
    `ifdef OUT_CSV_FILE_NAME
    simout_file = $fopen(`OUT_CSV_FILE_NAME);
    $fdisplay(simout_file, "SIM.i,SIM.en,SIM.nres",
        ",FI.stalled",          
        ",FI.i_flush",          
        ",FI.i_interr",         
        ",FI.i_jump_branch",    
        ",FI.i_valid_instr",    
        ",FI.i_pc",             
        ",FI.i_interr_addr",    
        ",FI.o_read_instr",     
        ",FI.o_flush",          
        ",FI.o_pc",             
        ",FI.pc_c",

        ",PROGMEM.stalled",       
        ",PROGMEM.i_if_flush",       
        ",PROGMEM.i_read",       
        ",PROGMEM.i_pc",         
        ",PROGMEM.debug_instr_c",
        ",PROGMEM.o_instr",
        ",PROGMEM.o_pc",
        ",PROGMEM.i_valid_skid",

        ",ID.stalled",            
        ",ID.i_flush_if",         
        ",ID.i_flush_id",         
        ",ID.i_instr",            
        ",ID.i_pc",               
        ",ID.c_alu_op",           
        ",ID.c_alu_src",          
        ",ID.c_imm",              
        ",ID.c_width",            
        ",ID.c_branch_op",        
        ",ID.c_csr_op",           
        ",ID.c_pc_src",           
        ",ID.c_jump",             
        ",ID.c_branch",           
        ",ID.c_add_sub_srl_sra",  
        ",ID.c_rd_write",         
        ",ID.c_read",             
        ",ID.c_write",            
        ",ID.c_csr_write",        
        ",ID.c_csr_read",         
        ",ID.c_csr_rs1_imm",      
        ",ID.c_wb_src",           
        ",ID.c_valid_instr",      
        ",ID.c_flush",            
        ",ID.c_pc",               
        ",ID.c_imm_data",         
        ",ID.c_rs1_addr",         
        ",ID.c_rs2_addr",         
        ",ID.c_rd_addr",

        ",REG.stalled",
        ",REG.register_wr_en_c",
        ",REG.register_rd_en_c",
        ",REG.wr_addr_c",       
        ",REG.register_c",      
        ",REG.i_rd_write",      
        ",REG.i_ras_read",      
        ",REG.i_rd_write_data", 
        ",REG.i_ras_data",      
        ",REG.i_rs1_addr",      
        ",REG.i_rs2_addr",      
        ",REG.i_rd_addr",       
        ",REG.debug_rs1_data",
        ",REG.debug_rs2_data",

        ",EX.stalled",            //               
        ",EX.i_flush_id",          //              
        ",EX.i_flush_ex",         //               
        ",EX.i_alu_op",            //              
        ",EX.i_alu_src",            //             
        ",EX.i_imm",                //             
        ",EX.i_width",               //            
        ",EX.i_branch_op",           //            
        ",EX.i_pc_src",              //            
        ",EX.i_jump",               //             
        ",EX.i_branch",             //             
        ",EX.i_add_sub_srl_sra",  //               
        ",EX.i_rd_write",           //             
        ",EX.i_read",               //             
        ",EX.i_write",              //             
        ",EX.i_wb_src",             //             
        ",EX.i_valid_instr",        //             
        ",EX.i_ex_rd_write",        //             
        ",EX.i_mem_rd_write",       //             
        ",EX.i_pc",                 //             
        ",EX.i_alu_data",           //             
        ",EX.i_wr_data",             //            
        ",EX.i_rs1_data",           //         
        ",EX.i_rs2_data",           //         
        ",EX.i_imm_data",           //         
        ",EX.i_rs1_addr",            //            
        ",EX.i_rs2_addr",            //            
        ",EX.i_rd_addr",             //            
        ",EX.i_ex_rd_addr",          //            
        ",EX.i_mem_rd_addr",         //            
        ",EX.mux1_src",             //
        ",EX.mux2_src",             // 
        ",EX.mux3_src",             // 
        ",EX.jump_branch_c",        //
        ",EX.flush_c",             //
        ",EX.pc_c",                //
        ",EX.alu_data_c",         //
        ",EX.rs2_data_c",          //
        ",EX.value1_c",         //
        ",EX.value2_c",          //
        ",EX.wait_for_load",          //
        ",EX.was_read",          //

        ",MEM.stalled",            //           
        ",MEM.i_flush_ex",            //           
        ",MEM.i_flush_mem",            //           
        ",MEM.flush_c",            //           
        ",MEM.i_width",            //           
        ",MEM.c_rd_write",          //          
        ",MEM.c_read",             //           
        ",MEM.c_write",            //           
        ",MEM.i_wb_src",           //           
        ",MEM.i_valid_instr",      //           
        ",MEM.i_alu_data",         //           
        ",MEM.i_rs2_data",          //          
        ",MEM.i_rd_data",          //           
        ",MEM.i_rd_addr",       //              
        ",MEM.rs2_data_shft",   //
        ",MEM.rd_write_data_c", //
        ",MEM.rd_mask",         //
        
        ",RAS1.i_pop",
        ",RAS1.i_push",
        ",RAS1.i_pop_then_push",
        ",RAS1.ras_fsm_nxt_c",
        ",RAS2.ras_cnt_en_c",
        ",RAS2.ras_nxt_c",
        ",RAS2.push_c",
        ",RAS2.pop_c",
        ",RAS3.o_pop_addr",
        ",RAS3.o_push_addr",

        `ifdef USE_JUMP_PREDICTOR
        ",NEXT.stalled",          
        ",NEXT.was_prediction_flushed",
        ",NEXT.i_if_pc",          
        // ",NEXT.i_ex_jump",         
        // ",NEXT.i_ex_branch",         
        ",NEXT.i_ex_jump_branch",    
        // ",NEXT.i_ex_pc",
        ",NEXT.old_pc",    
        ",NEXT.ex_inject",    
        ",NEXT.ex_inject_addr",    
        ",NEXT.i_ex_jump_addr",             
        ",NEXT.discard_jump_c",    
        ",NEXT.rollback_jump_c",     
        ",NEXT.if_inject_c",          
        ",NEXT.if_inject_addr_c",             
        ",NEXT.rollback_jump_addr_c",
        ",NEXT.inject_from_pm_c",
        ",NEXT.inject_from_pm_addr_c",
        ",NEXT.inject_from_id_c",
        ",NEXT.inject_from_id_addr_c",

        `ifdef USE_BTB_COUNTER
        ",BTBCOUNTER.read_index_c",
        ",BTBCOUNTER.read_key_c",
        ",BTBCOUNTER.write_index_c",
        ",BTBCOUNTER.write_key_c",
        ",BTBCOUNTER.i_write_value",
        ",BTBCOUNTER.i_write_jump",
        ",BTBCOUNTER.i_write_enable",
        ",BTBCOUNTER.read_entry_c_valid",
        ",BTBCOUNTER.read_entry_c_key",
        ",BTBCOUNTER.read_entry_c_value",
        ",BTBCOUNTER.read_entry_c_cnt",
        ",BTBCOUNTER.write_entry_c_valid",
        ",BTBCOUNTER.write_entry_c_key",
        ",BTBCOUNTER.write_entry_c_value",
        ",BTBCOUNTER.write_entry_c_cnt",
        ",BTBCOUNTER.o_read_value",
        ",BTBCOUNTER.o_read_jump",
        ",BTBCOUNTER.o_read_valid",
        ",BTBCOUNTERE.ADDR_WIDTH",
        ",BTBCOUNTERE.INDEX_WIDTH",
        ",BTBCOUNTERE.VALUE_WIDTH",
        ",BTBCOUNTERE.COUNTER_WIDTH",
        ",BTBCOUNTERE.0",
        ",BTBCOUNTERE.1",
        ",BTBCOUNTERE.2",
        ",BTBCOUNTERE.3",
        ",BTBCOUNTERE.4",
        ",BTBCOUNTERE.5",
        ",BTBCOUNTERE.6",
        ",BTBCOUNTERE.7",
        ",BTBCOUNTERE.8",
        ",BTBCOUNTERE.9",
        ",BTBCOUNTERE.10",
        ",BTBCOUNTERE.11",
        ",BTBCOUNTERE.12",
        ",BTBCOUNTERE.13",
        ",BTBCOUNTERE.14",
        ",BTBCOUNTERE.15",
        `endif

        `endif

        ",MEMDATA.r_valid",     
        ",MEMDATA.r_ready",     
        ",MEMDATA.w_valid",    
        ",MEMDATA.w_ready",    
        ",MEMDATA.w_data",     
        ",MEMDATA.r_data",     
        ",MEMDATA.strb",
        ",MEMDATA.w_addr",    
        ",MEMDATA.r_addr",    

        // ",REGDATA.0",
        ",REGDATA.1",
        ",REGDATA.2",
        ",REGDATA.3",
        ",REGDATA.4",
        ",REGDATA.5",
        ",REGDATA.6",
        ",REGDATA.7",
        ",REGDATA.8",
        ",REGDATA.9",
        ",REGDATA.10", 
        ",REGDATA.11", 
        ",REGDATA.12", 
        ",REGDATA.13", 
        ",REGDATA.14", 
        ",REGDATA.15",
        ",REGDATA.16",
        ",REGDATA.17",
        ",REGDATA.18", 
        ",REGDATA.19", 
        ",REGDATA.20", 
        ",REGDATA.21", 
        ",REGDATA.22", 
        ",REGDATA.23",
        ",REGDATA.24",
        ",REGDATA.25",
        ",REGDATA.26", 
        ",REGDATA.27", 
        ",REGDATA.28", 
        ",REGDATA.29", 
        ",REGDATA.30", 
        ",REGDATA.31", 

        ",MEMDATA.0",
        ",MEMDATA.1",
        ",MEMDATA.2",
        ",MEMDATA.3",
        ",MEMDATA.4",
        ",MEMDATA.5",
        ",MEMDATA.6",
        
        ",CHEDATA.0",
        ",CHEDATA.1",
        ",CHEDATA.2",
        ",CHEDATA.3",
        ",CHEDATA.4",
        ",CHEDATA.5",
        ",CHEDATA.6",

        ",CHEDATA.i_read",   
        ",CHEDATA.i_write",    
        ",CHEDATA.i_data",   
        ",CHEDATA.i_rd_addr",
        ",CHEDATA.i_wr_addr",
        ",CHEDATA.o_data"   
    );
    `else
    simout_file = 0;
    `endif
end endtask

task PRINT_CSV(input integer simout_file); begin
    if(simout_file != 0)
    $fdisplay(simout_file,
        iteration,
        ",", enable       ,
        ",", nreset       ,
        // Fetch
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_stall      ,
        // ",", was_stall_if      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_flush      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_interr     ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_jump_branch,
        ",", /*UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_valid_instr*/ 1,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_pc         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_interr_addr,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.o_read_instr ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.o_flush      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.o_pc         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.riscv_if_prog_counter.pc_c         ,
        //ProgMem
        ",", UUT.riscv_prog_mem.i_read          ,
        // ",", was_read_pm          ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_fetch.i_flush      ,
        ",", UUT.riscv_prog_mem.i_read          ,
        ",", UUT.riscv_prog_mem.i_pc            ,
        ",", UUT.riscv_prog_mem.debug_instr_c   ,
        ",", UUT.riscv_prog_mem.o_instr   ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_skid_buffer.o_pc      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_skid_buffer.i_valid   ,
        // Decode
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.i_stall         ,
        // ",", was_stall_id            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.i_flush_if         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.i_flush_id         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.i_instr            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.i_pc               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.alu_op_c           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.alu_src_c          ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.imm_c              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.width_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.branch_op_c        ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.csr_op_c           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.pc_src_c           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.jump_c             ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.branch_c           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.add_sub_srl_sra_c  ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.rd_write_c         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.read_c             ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.write_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.csr_write_c        ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.csr_read_c         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.csr_rs1_imm_c      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.wb_src_c           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.valid_instr_c      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.flush_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.i_pc               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.i_imm_data         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.i_rs1_addr         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.i_rs2_addr         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_instr_decode.riscv_id_stage.i_rd_addr          ,
        // REG
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_stall_wr      ,
        // ",", was_stall_wb      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_wr_en_c      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_rd_en_c      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.wr_addr_c             ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_rd_write            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_ras_read            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_rd_write_data       ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_ras_data            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_rs1_addr            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_rs2_addr            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.i_rd_addr             ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.rs1_data_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.rs2_data_c            ,
        // EX
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_stall                              ,
        // ",", was_stall_ex                                 ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_flush_id                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_flush_ex                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_alu_op                                ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_alu_src                               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_imm                                   ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_width                                 ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_branch_op                             ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_pc_src                                ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_jump                                  ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_branch                                ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_add_sub_srl_sra                       ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_rd_write                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_read                                  ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_write                                 ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_wb_src                                ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_valid_instr                           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_ex_rd_write                           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_mem_rd_write                          ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_pc                                    ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_alu_data                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_wr_data                               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_rs1_data                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_rs2_data                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_imm_data                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_rs1_addr                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_rs2_addr                              ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_rd_addr                               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_ex_rd_addr                            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.i_mem_rd_addr                           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_forwarding_unit__mux1_src      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_forwarding_unit__mux2_src      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_forwarding_unit__mux3_src      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.jump_branch_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.flush_c                  ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.i_pc                     ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.i_alu_data               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.i_rs2_data               ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value1_c ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value2_c ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_hazard_detection_unit.wait_for_load_c                                           ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.o_read      ,
        // MEM
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_stall                         ,
        // ",", was_stall_mm                         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_flush_ex                         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_flush_mem                        ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.flush_c                 ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_width                         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.rd_write_c                      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.i_read                  ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.i_write                 ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_wb_src                        ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_valid_instr                   ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_alu_data                      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_rs2_data                      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_mem_rd_data                   ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_rd_addr                       ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_adapter__rs2_data     ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.rd_write_data_c ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.mem_wr_strb_c   ,
        // Ras 1
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.i_pop             ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.i_push            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.i_pop_then_push   ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.ras_fsm_nxt_c     ,
        // Ras 2
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.ras_cnt_en_c      ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.ras_nxt_c         ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.push_c            ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.pop_c             ,
        // Ras 3
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.o_pop_addr        ,
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_cache_access_unit.riscv_ca_return_addr_stack.riscv_ras_arbiter.o_push_addr       ,
        
        `ifdef USE_JUMP_PREDICTOR
        // NEXT
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_stall,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.was_prediction_flushed,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_if_pc,
        // ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_jump_r,
        // ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_branch_r,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_ex_jump_branch,
        // ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_rollback_addr_r,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.old_pc_r,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_inject_r,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.ex_inject_addr_r,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.i_ex_jump_addr,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.discard_jump_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.rollback_jump_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.if_inject_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.if_inject_addr_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.rollback_jump_addr_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.inject_from_pm_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.inject_from_pm_addr_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.inject_from_id_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.inject_from_id_addr_c,

        `ifdef USE_BTB_COUNTER
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.read_index_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.read_key_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.write_index_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.write_key_c,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.i_write_value,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.i_write_jump,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.i_write_enable,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.read_entry_c.valid,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.read_entry_c.key,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.read_entry_c.value,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.read_entry_c.cnt,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.write_entry_c.valid,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.write_entry_c.key,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.write_entry_c.value,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.write_entry_c.cnt,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.o_read_value,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.o_read_jump,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.o_read_valid,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.ADDR_WIDTH,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.INDEX_WIDTH,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.VALUE_WDITH,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.COUNTER_WIDTH,
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[0],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[1],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[2],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[3],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[4],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[5],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[6],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[7],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[8],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[9],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[10],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[11],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[12],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[13],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[14],
        ",", UUT.riscv_top.riscv_main_unit.riscv_next_addr_predictor.pm_strategy_generate.riscv_next_strategy_pm.btb.entries[15],
        `endif
        `endif
        // WB (Memory)
        ",", UUT.axil_ram.s_axil_rvalid ,
        ",", UUT.axil_ram.s_axil_rready ,
        ",", UUT.axil_ram.s_axil_wvalid ,
        ",", UUT.axil_ram.s_axil_wready ,
        ",", UUT.axil_ram.s_axil_wdata  ,
        ",", UUT.axil_ram.s_axil_rdata  ,
        ",", UUT.axil_ram.s_axil_wstrb  ,
        ",", UUT.axil_ram.s_axil_awaddr ,
        ",", UUT.axil_ram.s_axil_araddr ,
        // REGDATA
        // ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 0],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 1],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 2],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 3],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 4],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 5],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 6],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 7],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 8],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[ 9],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[10],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[11],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[12],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[13],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[14],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[15],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[16],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[17],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[18],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[19],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[20],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[21],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[22],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[23],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[24],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[25],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[26],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[27],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[28],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[29],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[30],
        ",", UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[31],
        // MEMDATA
        ",%h", UUT.axil_ram.mem[ 0],
        ",%h", UUT.axil_ram.mem[ 1],
        ",%h", UUT.axil_ram.mem[ 2],
        ",%h", UUT.axil_ram.mem[ 3],
        ",%h", UUT.axil_ram.mem[ 4],
        ",%h", UUT.axil_ram.mem[ 5],
        ",%h", UUT.axil_ram.mem[ 6],
        // CHEDATA
        ",", UUT.riscv_top.riscv_cache.cache_r[ 0],
        ",", UUT.riscv_top.riscv_cache.cache_r[ 1],
        ",", UUT.riscv_top.riscv_cache.cache_r[ 2],
        ",", UUT.riscv_top.riscv_cache.cache_r[ 3],
        ",", UUT.riscv_top.riscv_cache.cache_r[ 4],
        ",", UUT.riscv_top.riscv_cache.cache_r[ 5],
        ",", UUT.riscv_top.riscv_cache.cache_r[ 6],

        ",", UUT.riscv_top.riscv_cache.i_read     ,   
        ",", UUT.riscv_top.riscv_cache.i_write    ,  
        ",", UUT.riscv_top.riscv_cache.i_data     ,   
        ",", UUT.riscv_top.riscv_cache.i_rd_addr  ,
        ",", UUT.riscv_top.riscv_cache.i_wr_addr  ,
        ",", UUT.riscv_top.riscv_cache.o_data      
    );
end endtask
