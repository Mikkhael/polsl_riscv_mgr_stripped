`timescale 1ns / 1ps

module riscv_tb #(
  parameter ADDR_WIDTH = 16,
  parameter DATA_WIDTH = 64,
  parameter INSTR_WIDTH = 32
  )();

  reg clk;
  reg nreset;
  reg enable;


  wire [15:0] leds;
  wire busy;

  top #(
    .ADDR_WIDTH  (ADDR_WIDTH),
    .DATA_WIDTH  (DATA_WIDTH),
    .INSTR_WIDTH (INSTR_WIDTH)
     ) UUT (
          .aclk     (clk),
          .pclk     ({clk, clk}),
          .anreset  (nreset),
          .pnreset  ({nreset, nreset}),
          .aenable  (enable),
          .penable  ({enable,enable}),
          .i_switch (8'h00),
          .o_busy   (busy),
          .o_leds   (leds)
     );
     
  `ifdef RUN_FOR
    localparam run_for = `RUN_FOR;
  `endif
  
  integer simout_file;
  `include "./riscv_tb_pipeline_export.vh"
  initial begin
    clk = 0;
    nreset = 0;
    enable = 0;
    INIT_CSV(simout_file);
    forever begin
      #20;
      PRINT_CSV(simout_file);
    end
  end

  integer iteration = 0;
  always #10 clk<= ~clk;
  always @(posedge clk) iteration++;

  initial begin
    #20 enable <= 1;
    #60 nreset <= 1;
  end

  integer invalid_insts = 0;
  integer total_cycles = 0;

  `include "riscv_instr_parse.vh"
  `include "riscv_verify_asserts.vh"

  wire [DATA_WIDTH  - 1:0] pc    = UUT.riscv_top.riscv_main_unit.o_pc;
  wire [INSTR_WIDTH - 1:0] instr = UUT.riscv_top.riscv_main_unit.i_instr;

  wire stall_mem = UUT.riscv_top.riscv_main_unit.riscv_mu_hazard_detection_unit.o_stall_mem;
  wire stall_if  = UUT.riscv_top.riscv_main_unit.riscv_mu_hazard_detection_unit.o_stall_if;
  wire was_stall_mem = $past(stall_mem, 1,, @(posedge clk));
  wire was_stall_if  = $past(stall_if,  1,, @(posedge clk));
  wire is_flush_mem  = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.flush_c;
  wire is_valid_mem  = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_valid_instr;
  wire is_new_instr  = !is_flush_mem && !was_stall_mem && is_valid_mem;
                          
  wire [32:0] pipelined_instr = $past(instr, 2, !was_stall_if, @(posedge clk));
  wire [63:0] pipelined_pc    = $past(pc,    3, !was_stall_if, @(posedge clk));
  wire [63:0] pipelined_v1    = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value1_c,     1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_v2    = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value2_c,     1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_v3    = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value3_c,     1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_res   = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.alu_result_c, 1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_jalr  = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_jump_n_branches.rs1_data_c,         1, !was_stall_mem, @(posedge clk));

  ASSERTIONS_CONDITIONS conditions;

initial begin
  GET_ASSERTIONS_CONDITIONS(`TEST_NAME, `TEST_VARIANT, conditions);
  SET_PRECONDITIONS(conditions, UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r, UUT.axil_ram.mem);
  forever begin
    #20
    // iteration++;
    total_cycles++;
    if (!is_new_instr) begin
      //$display (" BUSY ");
    end else begin
      $display("      %s\t(I:%0d) (t:%0t)", INSTR_TO_STR_EX(pipelined_instr, pipelined_pc, pipelined_v1, pipelined_jalr, pipelined_v2, pipelined_v3, pipelined_res), total_cycles, $time);
      if(IS_INSTR_INVALID(pipelined_instr)) begin
        if(enable && nreset) begin
          if(++invalid_insts > 5)
            $stop();
        end
      end
      if(pipelined_instr == HALT) begin
        $display("Halted simulation");
        #60;
        $stop();
      end
    end
    `ifdef RUN_FOR
    if(total_cycles > run_for) begin
      $display("Too many instructions");
      $stop();
    end
    `endif
  end
end

endmodule
