`timescale 1ns / 1ps

import riscv_next_pkg::*;

module riscv_verify #(
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

  initial begin
    clk = 0;
    nreset = 0;
    enable = 0;
  end

  integer iteration = 0;
  always #10 clk<= ~clk;
  always @(posedge clk) iteration++;

  initial begin
    #20 enable <= 1;
    #60 nreset <= 1;
  end

  wire [63:0] REF_PC;
  wire [DATA_WIDTH - 1:0] REF_REGS   [0:31];
  wire [63:0]             REF_MEMORY [0:8191];
  wire REF_FINISHED;

  // wire enable_REF_clk;

  wire [31:0] REF_INSTR = UUT.riscv_prog_mem.prog_r[REF_PC >> 2];
  wire REF_INVALID;

  riscv_ref REF(
      // .clk (clk),
      // .en  (enable_REF_clk),

      .pc     (REF_PC),
      .instr  (REF_INSTR),

      .REGS    (REF_REGS  ),
      .MEMORY  (REF_MEMORY),
      .finished (REF_FINISHED),
      .invalid (REF_INVALID)
  );


  `ifdef RUN_FOR
    localparam run_for = `RUN_FOR;
  `else
    localparam run_for = 100;
  `endif

  `ifndef TEST_NAME
  `define TEST_NAME ""
  `endif
  
  `ifndef TEST_VARIANT
  `define TEST_VARIANT 0
  `endif

  `include "./riscv_verify_asserts.vh"
  `include "./riscv_instr_parse.vh"

  integer invalid_insts  = 0;
  integer total_cycles    = 0;
  integer total_fetched  = 0;
  integer total_executed = 0;
  integer total_flushed_ex = 0;

  wire [DATA_WIDTH  - 1:0] pc    = UUT.riscv_top.riscv_main_unit.o_pc;
  wire [INSTR_WIDTH - 1:0] instr = UUT.riscv_top.riscv_main_unit.i_instr;

  wire stall_mem = UUT.riscv_top.riscv_main_unit.riscv_mu_hazard_detection_unit.o_stall_mem;
  wire stall_if  = UUT.riscv_top.riscv_main_unit.riscv_mu_hazard_detection_unit.o_stall_if;
  wire was_stall_mem = $past(stall_mem, 1,, @(posedge clk));
  wire was_stall_if  = $past(stall_if,  1,, @(posedge clk));
  wire is_flush_mem  = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.flush_c;
  wire is_valid_mem  = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.i_valid_instr;
  wire is_new_instr  = !is_flush_mem && !was_stall_mem && is_valid_mem;
  wire is_flush_ex   = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.flush_c;
  wire is_stall_ex   = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_stage.i_stall;
                          
  wire [31:0] pipelined_instr = $past(instr, 2, !was_stall_if, @(posedge clk));
  wire [63:0] pipelined_pc    = $past(pc,    3, !was_stall_if, @(posedge clk));
  wire [63:0] pipelined_v1    = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value1_c,     1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_v2    = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value2_c,     1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_v3    = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.value3_c,     1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_res   = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_arithmetic_logic_unit.alu_result_c, 1, !was_stall_mem, @(posedge clk));
  wire [63:0] pipelined_jalr  = $past(UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_execution_unit.riscv_ex_jump_n_branches.rs1_data_c,         1, !was_stall_mem, @(posedge clk));


  wire next_instr_signals_t pipelined_signals;

  riscv_next_instr_decoder #(
    .INSTR_WIDTH(32),
    .ADDR_WIDTH(64)
  ) pipelined_next_instr_decoder(
    .i_instr(pipelined_instr),
    .i_flush(1'd0),
    .o_signals(pipelined_signals)
  );

  reg sim_good = 1;
  
  reg TEST_FINISHED = 0;
  // assign enable_REF_clk = is_new_instr || TEST_FINISHED;

  integer first_instr_differance = -1;
  reg too_many_instructions = 0;
  reg test_was_invalid = 0;
  string ref_parsed_instr;
  string uut_parsed_instr;

  ASSERTIONS_CONDITIONS conditions;

  integer nextlog_file;

  `include "./riscv_next_logger.vh"

  initial begin
    INIT_NLOG(nextlog_file);
    while(!TEST_FINISHED) begin
      #20;
      PRINT_NLOG(nextlog_file, 0);
    end
  end

`ifndef JUMP_PREDICTOR_FROM_ID
`define JUMP_PREDICTOR_FROM_ID "none"
`endif
`ifndef JUMP_PREDICTOR_FROM_PM
`define JUMP_PREDICTOR_FROM_PM "none"
`endif

  initial begin
    GET_ASSERTIONS_CONDITIONS(`TEST_NAME, `TEST_VARIANT, conditions);
    SET_PRECONDITIONS(conditions, UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r, UUT.axil_ram.mem);
    SET_PRECONDITIONS(conditions, REF.REGS, REF.MEMORY);
    while (!TEST_FINISHED) begin
      #20
      total_cycles++;
      if(!stall_if && enable && nreset) begin
        total_fetched++;
      end
      if(is_flush_ex && !is_stall_ex && enable && nreset) begin
        total_flushed_ex++;
      end
      if (!is_new_instr) begin
        // uut_parsed_instr = INSTR_TO_STR_EX(pipelined_instr, pipelined_pc, pipelined_v1, pipelined_jalr, pipelined_v2, pipelined_v3, pipelined_res);
        // $display("BUSY  %s\t(I:%0d) IF_STALL=%b, MEM_STALL=%b, MEM_FLUSH=%b", uut_parsed_instr, total_cycles, was_stall_if, was_stall_mem, UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_memory_access_unit.riscv_mem_stage.flush_c);
      end else begin
        total_executed++;
        REF.STEP(ref_parsed_instr);
        uut_parsed_instr = INSTR_TO_STR_EX(pipelined_instr, pipelined_pc, pipelined_v1, pipelined_jalr, pipelined_v2, pipelined_v3, pipelined_res);
        `ifdef SHOW_LOG
        $display("      %s\t(I:%0d)", uut_parsed_instr, total_cycles);
        `endif
        if(ref_parsed_instr != uut_parsed_instr) begin
          if(first_instr_differance < 0)
            first_instr_differance = total_cycles;
            `ifdef SHOW_LOG
            $display("[REF] %s", ref_parsed_instr);
            `endif
        end
        if(IS_INSTR_INVALID(pipelined_instr)) begin
          test_was_invalid = 1;
          TEST_FINISHED = 1;
        end
        if(pipelined_instr == HALT) begin
          $display("[UUT] Halted simulation");
          #40;
          TEST_FINISHED = 1;
        end
      end
      if(total_cycles > run_for) begin
        $display("[UUT] Too many instructions");
        too_many_instructions = 1;
        TEST_FINISHED = 1;
      end
    end
  end

  integer i = 0;
  reg [63:0] temp = 0;
  integer fd;

  initial begin
    wait(TEST_FINISHED);
    $display("[UUT] FINISHED");
    while(!REF_FINISHED) begin
        REF.STEP(ref_parsed_instr);
    end;
    $display("[REF] FINISHED");

    $display("SIMULATION FINISHED");
    `ifdef VERIFICATION_LOG_PATH
      fd = $fopen(`VERIFICATION_LOG_PATH, "a");
      $display("fd: %d, %s", fd, `VERIFICATION_LOG_PATH);
    `else
      fd = 0;
    `endif
    $display("=========================================");
    $display(     "MEM=%s | VAR=%0d | NEXT_PM=%s (%s) | NEXT_ID=%s | RUNFOR=%0d", `PROGRAM_MEM_FILE_NAME, `TEST_VARIANT, `JUMP_PREDICTOR_FROM_PM, `JUMP_PREDICTOR_FROM_PM_ARGS, `JUMP_PREDICTOR_FROM_ID, `RUN_FOR);
    $fdisplay(fd, "MEM=%s | VAR=%0d | NEXT_PM=%s (%s) | NEXT_ID=%s | RUNFOR=%0d", `PROGRAM_MEM_FILE_NAME, `TEST_VARIANT, `JUMP_PREDICTOR_FROM_PM, `JUMP_PREDICTOR_FROM_PM_ARGS, `JUMP_PREDICTOR_FROM_ID, `RUN_FOR);
    if(too_many_instructions) begin
               $display     ("TOO MANY INSTRUCTIONS (RUNFOR=%0d)", run_for);
        if(fd) $fdisplay(fd, "TOO MANY INSTRUCTIONS (RUNFOR=%0d)", run_for);
        sim_good = 0;
    end
    if(REF_INVALID || test_was_invalid) begin
               $display     ("ENCOUNERED INVALID INSTRUCTION (ref=%b), (uut=%b)", REF_INVALID, test_was_invalid);
        if(fd) $fdisplay(fd, "ENCOUNERED INVALID INSTRUCTION (ref=%b), (uut=%b)", REF_INVALID, test_was_invalid);
        sim_good = 0;
    end
    if(first_instr_differance >= 0) begin
               $display     ("FIRST INCORECT INSTRUCTION AT (I:%0d)", first_instr_differance);
        if(fd) $fdisplay(fd, "FIRST INCORECT INSTRUCTION AT (I:%0d)", first_instr_differance);
        sim_good = 0;
    end
    for(i=1; i<32; i++) begin
      temp = UUT.riscv_top.riscv_main_unit.riscv_mu_processing_unit.riscv_pu_register.register_r[i];
      if(REF_REGS[i] !== temp) begin
               $display     ("CORRUPTED REG [%0d]: UUT=0x%0h %0d REF=0x%0h %0d", i, temp,temp, REF_REGS[i],REF_REGS[i]);
        if(fd) $fdisplay(fd, "CORRUPTED REG [%0d]: UUT=0x%0h %0d REF=0x%0h %0d", i, temp,temp, REF_REGS[i],REF_REGS[i]);
        sim_good = 0;
      end
    end
    for(i=0; i<1024; i++) begin
      temp = UUT.axil_ram.mem[i];
      if(REF_MEMORY[i] !== temp) begin
               $display     ("CORRUPTED MEM [0x%0h]: UUT=0x%0h %0d REF=0x%0h %0d", i*4, temp,temp, REF_MEMORY[i],REF_MEMORY[i]);
        if(fd) $fdisplay(fd, "CORRUPTED MEM [0x%0h]: UUT=0x%0h %0d REF=0x%0h %0d", i*4, temp,temp, REF_MEMORY[i],REF_MEMORY[i]);
        sim_good = 0;
      end
    end
    sim_good &= CHECK_POSTCONDITIONS(fd, conditions, REF_REGS, REF_MEMORY);
    if(!sim_good) begin
             $error       ("ERRORS IN VERIFICATION for file %s", `PROGRAM_MEM_FILE_NAME);
      if(fd) $fdisplay(fd, "ERRORS IN VERIFICATION for file %s", `PROGRAM_MEM_FILE_NAME);
    end else begin
             $display     ("ALL GOOD");
      if(fd) $fdisplay(fd, "ALL GOOD");
    end
           $display     ("=========================================");
    if(fd) $fdisplay(fd, "=========================================");
    
    PRINT_NLOG(nextlog_file, 1);
    $finish;
  end

endmodule
