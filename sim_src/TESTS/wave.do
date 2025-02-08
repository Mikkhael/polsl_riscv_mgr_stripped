onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top /riscv_tb/UUT/o_busy
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/clk
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/nreset
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/enable
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/i_read
add wave -noupdate -group Progmem -radix decimal /riscv_tb/UUT/riscv_prog_mem/i_pc
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/o_valid
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/o_instr
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/prog_mem_en_c
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/debug_instr_c
add wave -noupdate -group Progmem /riscv_tb/UUT/riscv_prog_mem/unused_ok
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/clk
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/nreset
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/enable
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/i_valid
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/i_ras_read
add wave -noupdate -group Skid -radix decimal /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/i_pc
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/o_ras_read
add wave -noupdate -group Skid -radix decimal /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/o_pc
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/mu_skid_buffer_en_c
add wave -noupdate -group Skid /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/ras_read_r
add wave -noupdate -group Skid -radix decimal /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/pc_r
add wave -noupdate -group Skid -radix decimal /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_skid_buffer/debug_skid_buffer_pc
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/clk
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/nreset
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/enable
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/i_stall
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/i_flush
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/i_interr
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/i_jump_branch
add wave -noupdate -group IF -radix decimal /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/i_pc
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/i_interr_addr
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/o_read_instr
add wave -noupdate -group IF /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/o_flush
add wave -noupdate -group IF -radix decimal /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_fetch/o_pc
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/clk
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/nreset
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/enable
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_stall
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_flush_if
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_flush_id
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_alu_op
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_alu_src
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_imm
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_width
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_branch_op
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_csr_op
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_pc_src
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_jump
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_branch
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_add_sub_srl_sra
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_rd_write
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_read
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_write
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_csr_write
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_csr_read
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_csr_rs1_imm
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_wb_src
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_valid_instr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_pc
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_imm_data
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_rs1_addr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_rs2_addr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/i_rd_addr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_alu_op
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_alu_src
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_imm
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_width
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_branch_op
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_csr_op
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_pc_src
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_jump
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_branch
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_add_sub_srl_sra
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_rd_write
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_read
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_write
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_csr_write
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_csr_read
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_csr_rs1_imm
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_wb_src
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_valid_instr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_flush
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_pc
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_imm_data
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_rs1_addr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_rs2_addr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/o_rd_addr
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/id_stage_en_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/flush_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/alu_op_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/alu_src_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/imm_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/width_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/branch_op_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/csr_op_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/pc_src_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/jump_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/branch_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/add_sub_srl_sra_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/rd_write_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/read_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/write_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/csr_write_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/csr_read_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/csr_rs1_imm_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/wb_src_c
add wave -noupdate -group ID /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_instr_decode/riscv_id_stage/valid_instr_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/clk
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/enable
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/nreset
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_stall
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_if_pc
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_pm_flush
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_id_flush
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_id_inst
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_ex_jump_branch
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_ex_jump_addr
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/i_ex_o_flush
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/o_discard_jump
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/o_rollback_jump
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/o_pm_flush
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/o_if_inject
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/o_if_inject_addr
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/o_rollback_jump_addr
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/predictor_enable_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/id_signals_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/discard_jump_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/rollback_jump_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_inject_flush_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/if_inject_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/if_inject_addr_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/rollback_jump_addr_c
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_inject_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/id_inject_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/ex_inject_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_inject_addr_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/id_inject_addr_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/ex_inject_addr_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_pc_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/id_pc_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/ex_pc_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/old_pc_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/ex_jump_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/old_jump_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/ex_branch_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/old_branch_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/true_ex_inject_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/true_ex_inject_addr_r
add wave -noupdate -group NEXT /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/was_prediction_flushed
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/clk
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/nreset
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/enable
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i_stall
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i_read_addr
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/o_read_value
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/o_read_jump
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/o_read_valid
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i_write_addr
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i_write_value
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i_write_jump
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i_write_enable
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_index_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_index_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_key_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_key_c
add wave -noupdate -group BTB -expand /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_entry_c
add wave -noupdate -group BTB -expand /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_entry_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_key_matches_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_key_matches_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_counter_is_max_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_counter_is_min_c
add wave -noupdate -group BTB -expand /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/write_next_counter_c
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_value_r
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_jump_r
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/read_valid_r
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/evicts
add wave -noupdate -group BTB /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/btb/i
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/clk
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/nreset
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/enable
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_stall
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_flush_read_hisotry
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_shift_read_history
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_read_addr
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/o_read_jump
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/o_read_valid
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_write_addr
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_write_jump
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i_write_enable
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/read_history_r
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_history_r
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/speculative_offset_r
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/expected_write_jump_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/was_last_prediction_wrong_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/read_index_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_index_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/read_entry_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_entry_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/read_key_matches_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_key_and_val_matches_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_counter_is_max_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_counter_is_min_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/write_next_counter_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/read_jump_r
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/read_valid_r
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/shifted_read_history_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/shifted_write_history_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/next_write_history_c
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/evicts
add wave -noupdate -expand -group bht /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_next_addr_predictor/pm_strategy_generate/riscv_next_strategy_pm/bht/i
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/clk
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/nreset
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/enable
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_stall_rd
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_stall_wr
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_rd_write
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_ras_read
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_rd_write_data
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_ras_data
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_rs1_addr
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_rs2_addr
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/i_rd_addr
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/o_rs1_data
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/o_rs2_data
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/register_rd_en_c
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/register_wr_en_c
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/register_c
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/wr_addr_c
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/rs1_data_r
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/rs1_data_c
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/rs2_data_r
add wave -noupdate -group REG /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_register/rs2_data_c
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_imm
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_jump
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_ex_rd_write
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_mem_rd_write
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_rs1_addr
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_rs2_addr
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_id_rd_addr
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_ex_rd_addr
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/i_mem_rd_addr
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/o_mux1_src
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/o_mux2_src
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/o_mux3_src
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/o_ras_mux_src
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/o_call_mux_src
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/mux1_src_c
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/mux2_src_c
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/mux3_src_c
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/ras_mux_src_c
add wave -noupdate -group FWD /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_forwarding_unit/call_mux_src_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_alu_op
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_alu_src
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_width
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_mux1_src
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_mux2_src
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_mux3_src
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_add_sub_srl_sra
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_read
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_write
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_pc
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_alu_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_wr_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_rs1_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_rs2_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/i_imm_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/o_carry
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/o_zero
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/o_alu_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/o_rs1_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/o_rs2_data
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/shamt_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/width_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/carry_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/sign_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/carry_sign_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/carry_unsigned_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/value1_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/value2_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/value3_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/sub_value_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/alu_result_c
add wave -noupdate -group ALU /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_arithmetic_logic_unit/srl_sra_value_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/clk
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/nreset
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/enable
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_stall
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_flush_id
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_flush_ex
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_width
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_jump
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_rd_write
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_read
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_write
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_wb_src
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_valid_instr
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_jump_branch
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_pc
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_alu_data
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_rs2_data
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_rs1_addr
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/i_rd_addr
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_width
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_jump
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_rd_write
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_read
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_write
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_wb_src
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_valid_instr
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_jump_branch
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_flush
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_pc
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_alu_data
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_rs2_data
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_rs1_addr
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/o_rd_addr
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/ex_stage_en_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/flush_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/width_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/rd_write_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/read_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/write_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/wb_src_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/valid_instr_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/jump_branch_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/alu_data_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/rd_addr_c
add wave -noupdate -group EX /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_execution_unit/riscv_ex_stage/jump_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/clk
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/nreset
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/enable
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_stall
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/i_flush_ex
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/i_flush_mem
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_rd_write
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_read
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_write
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_wb_src
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_valid_instr
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_mem_wr_ready
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_mem_rd_valid
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_desc_wready
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_resp_rready
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_alu_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_rs2_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_mem_rd_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_resp_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_mem_wr_strb
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/i_rd_addr
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_rd_write
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_mem_rd_ready
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_mem_wr_valid
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_desc_wr
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_resp_rd
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_valid_instr
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_flush
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_rd_write_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_mem_wr_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_desc_data
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_mem_wr_strb
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_mem_addr
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/o_rd_addr
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_stage_en_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/desc_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/rd_write_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/valid_instr_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/rd_write_data_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_wr_valid_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_wr_valid_r
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_rd_ready_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_rd_ready_r
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_addr_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_addr_r
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_wr_data_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_wr_data_r
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_wr_strb_c
add wave -noupdate -group MEM /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_processing_unit/riscv_pu_memory_access_unit/riscv_mem_stage/mem_wr_strb_r
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/clk
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/nreset
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/enable
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/i_mem_wr_ready
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/i_mem_wr_valid
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/i_mem_rd_valid
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/i_mem_rd_ready
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/i_jump_branch
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_stall_if
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_stall_id
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_stall_rd_reg
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_stall_wr_reg
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_stall_ex
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_stall_mem
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_flush_if
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_flush_id
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/o_flush_ex
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/rready_c
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/rready_r
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/wvalid_c
add wave -noupdate -group Hazard /riscv_tb/UUT/riscv_top/riscv_main_unit/riscv_mu_hazard_detection_unit/wvalid_r
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/clk
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/rst
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_awaddr
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_awprot
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_awvalid
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_awready
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_wdata
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_wstrb
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_wvalid
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_wready
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_bresp
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_bvalid
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_bready
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_araddr
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_arprot
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_arvalid
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_arready
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_rdata
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_rresp
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_rvalid
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/s_axil_rready
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/mem_wr_en
add wave -noupdate -group {AXI RAM} /riscv_tb/UUT/axil_ram/mem_rd_en
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/aclk
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/anreset
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/aenable
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_wr_valid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_wr_strb
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_wr_data
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_wr_addr
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_wr_ready
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_rd_ready
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_rd_addr
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_rd_valid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_rd_data
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_awaddr
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_awprot
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_awvalid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_awready
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_wdata
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_wstrb
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_wvalid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_wready
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_bresp
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_bvalid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_bready
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_araddr
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_arprot
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_arvalid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_arready
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_rdata
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_rresp
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/i_rvalid
add wave -noupdate -group {AXI INTF} /riscv_tb/UUT/riscv_top/axil_riscv_if/o_rready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1370000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 311
configure wave -valuecolwidth 188
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1465005 ps} {1607106 ps}
