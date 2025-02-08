.SECONDEXPANSION:

SCRIPTS_PATH ?= ../scripts
MODEL_PATH   ?= ../../hw_src
QUARTUS_PATH ?= ../../quartus
QUARTUS_OUTPUT_PATH ?= $(QUARTUS_PATH)/output_files
QUARTUS_OUTPUT_REP_FLOW_FILE ?= $(QUARTUS_OUTPUT_PATH)/mgr_riscv_quartus.flow.rpt
QUARTUS_OUTPUT_REP_MAP_FILE  ?= $(QUARTUS_OUTPUT_PATH)/mgr_riscv_quartus.map.rpt
SOURCES_PATH ?= .

ASMS_PATH  ?= $(SOURCES_PATH)/asms
CSRCS_PATH ?= $(SOURCES_PATH)/c_src
COBJS_PATH ?= $(SOURCES_PATH)/c_obj
MEMS_PATH  ?= $(SOURCES_PATH)/progmems
CSVS_PATH  ?= $(SOURCES_PATH)/csvs
NLOGS_PATH ?= $(SOURCES_PATH)/nextlogs
PIPES_PATH ?= $(SOURCES_PATH)/pipelines
REPS_PATH  ?= $(SOURCES_PATH)/reps


### parameters getters
# name
#	Compilation:
# O<number> - optimization level
#	Simulation:
# r<number> - runfor
# n<string> - selected predictor from if/pm
# i<string> - selected predictor from id
# v<number> - runtime variant
# a<_ seperated list> - additional arguments for predictor

define get_rname # (file_names) -> rname, without dir and withous ext
$(notdir $(basename $1))
endef

define get_fname # (file_names / rname) -> path to mem file
$(word 1,$(subst __v, ,$(notdir $(basename $1))))
endef

define get_name	# (rname / fname / filename) -> value of parameter in rname (or fname)
$(word 1,$(subst __, ,$(notdir $1)))
endef

define get	# (parameter, rname) -> value of parameter in rname (or fname)
$(subst __$1,,$(filter __$1%,$(subst __, __,$2)))
endef

define get_use_jump_predictor #(rname)
$(if $(filter-out none,$(call get,n,$1) $(call get,i,$1)),-define USE_JUMP_PREDICTOR)
endef
define get_use_jump_predictor_syn #(rname)
$(if $(filter-out none,$(call get,n,$1) $(call get,i,$1)),-verilog_macro=\"USE_JUMP_PREDICTOR\")
endef

define get_args_defines_pm #(rname)
$(foreach m,$(call get_args_defines_pm_impl_$(call get,n,$1),$(subst _, ,$(call get,a,$1))),-define $(m))
endef
define get_args_defines_pm_syn #(rname)
$(foreach m,$(call get_args_defines_pm_impl_$(call get,n,$1),$(subst _, ,$(call get,a,$1))),--verilog_macro=\"$(m:"=\\")\")
endef

# define get_args_defines_pm_impl_btbcounter #(args...)
# -define USE_BTB_COUNTER -define BTB_INDEX_WIDTH=$(word 1,$1) -define BTB_COUNTER_WIDTH=$(word 2,$1)
# endef

define get_args_defines_pm_impl_btb #(args...)
USE_BTB_COUNTER BTB_INDEX_WIDTH=$(word 1,$1) BTB_COUNTER_WIDTH=$(word 2,$1)
endef

define get_args_defines_pm_impl_bht #(args...)
USE_BTB_COUNTER BTB_INDEX_WIDTH=$(word 1,$1) BTB_COUNTER_WIDTH=$(word 2,$1) BHT_HIST_WIDTH=$(word 3,$1) BHT_COUNTER_WIDTH=$(word 4,$1)
endef
define get_args_defines_pm_impl_agree #(args...)
USE_BTB_COUNTER BTB_INDEX_WIDTH=$(word 1,$1) BTB_COUNTER_WIDTH=$(word 2,$1) BHT_HIST_WIDTH=$(word 3,$1) BHT_COUNTER_WIDTH=$(word 4,$1)
endef

define get_args_defines_pm_impl_bhtret #(args...)
USE_BTB_COUNTER BTB_INDEX_WIDTH=$(word 1,$1) BTB_COUNTER_WIDTH=$(word 2,$1) BHT_HIST_WIDTH=$(word 3,$1) BHT_COUNTER_WIDTH=$(word 4,$1) RET_INDEX_WIDTH=$(word 5,$1)
endef

# define get_args_defines_pm_impl_20 #(args...)
# $(if $(filter-out none,$1),-define HARDCODED_FROM=$(word 1,$1) -define HARDCODED_TO=$(word 2,$1))
# endef

# define get_args_defines_pm_impl_20 #(args...)
# $(if $(filter-out none,$1),HARDCODED_FROM=$(word 1,$1) HARDCODED_TO=$(word 2,$1))
# endef

define get_args_defines_pm_impl_hardcoded #(args...)
$(if $(filter-out none,$1),HARDCODED_FROM=$(word 1,$1) HARDCODED_TO=$(word 2,$1))
endef

### ALL USEFUL FILE PATHS

ALL_ASMS  += $(wildcard $(ASMS_PATH)/*.asm)
ALL_CSRCS += $(wildcard $(CSRCS_PATH)/*.c)

ALL_ASMS_NAMES  := $(notdir $(ALL_ASMS:.asm=))
ALL_CSRCS_NAMES := $(notdir $(ALL_CSRCS:.c=))

## name
## pat
# var 	?= 0
opt		?= 0 3
runfor 	?= 10000
log 	?= verification.log
# sumout
# sumapp
next	?= none
nextid  ?= none
pmarg   ?= none
nonlog  ?= 1


## pmarg =
##   random     :
##   hardoced20 :
##   btbcountr  : <btb_index_width> <btb_counter_width>
##   btbcountr  : <btb_index_width> <btb_counter_width> <bht_hist_width> <bht_counter_width>


define get_syn_output_name # (rname)
syn_output__n$(call get,n,$1)__i$(call get,i,$1)__a$(call get,a,$1)
endef


ifdef name
	pat := $(firstword $(name))
	var := $(firstword $(var))
	opt := $(firstword $(opt))
endif
ifdef pat
	ALL_ASMS_NAMES  := $(filter $(pat),$(ALL_ASMS_NAMES))
	ALL_CSRCS_NAMES := $(filter $(pat),$(ALL_CSRCS_NAMES))
endif

# Name  with source compilation parameters
ALL_ASMS_FNAMES  := $(ALL_ASMS_NAMES)
ALL_CSRCS_FNAMES := $(foreach o,$(opt),$(foreach n,$(ALL_CSRCS_NAMES),$(n)__O$(o)))
ALL_FNAMES := $(ALL_ASMS_FNAMES) $(ALL_CSRCS_FNAMES)

# FName with simulation compilation and runtime parameters
include Makefile_variants

ALL_ASMS_RNAMES := $(ALL_ASMS_FNAMES)
ifdef var
ALL_ASMS_RNAMES := $(foreach n,$(ALL_ASMS_RNAMES),$(foreach val,$(var),$(n)__v$(val)))
else
ALL_ASMS_RNAMES := $(foreach n,$(ALL_ASMS_RNAMES),$(foreach val,0 $(ADDITIONAL_VARIANTS_$(call get_name,$(n))),$(n)__v$(val)))
endif
ALL_ASMS_RNAMES := $(foreach n,$(ALL_ASMS_RNAMES),$(foreach val,$(runfor),$(n)__r$(val)))
ALL_ASMS_RNAMES := $(foreach n,$(ALL_ASMS_RNAMES),$(foreach val,$(next),$(n)__n$(val)))
ALL_ASMS_RNAMES := $(foreach n,$(ALL_ASMS_RNAMES),$(foreach val,$(nextid),$(n)__i$(val)))
ALL_ASMS_RNAMES := $(foreach n,$(ALL_ASMS_RNAMES),$(foreach val,$(pmarg),$(n)__a$(val)))

ALL_CSRCS_RNAMES := $(ALL_CSRCS_FNAMES)
ifdef var
ALL_CSRCS_RNAMES := $(foreach n,$(ALL_CSRCS_RNAMES),$(foreach val,$(var),$(n)__v$(val)))
else
ALL_CSRCS_RNAMES := $(foreach n,$(ALL_CSRCS_RNAMES),$(foreach val,0 $(ADDITIONAL_VARIANTS_$(call get_name,$(n))),$(n)__v$(val)))
endif
ALL_CSRCS_RNAMES := $(foreach n,$(ALL_CSRCS_RNAMES),$(foreach val,$(runfor),$(n)__r$(val)))
ALL_CSRCS_RNAMES := $(foreach n,$(ALL_CSRCS_RNAMES),$(foreach val,$(next),$(n)__n$(val)))
ALL_CSRCS_RNAMES := $(foreach n,$(ALL_CSRCS_RNAMES),$(foreach val,$(nextid),$(n)__i$(val)))
ALL_CSRCS_RNAMES := $(foreach n,$(ALL_CSRCS_RNAMES),$(foreach val,$(pmarg),$(n)__a$(val)))

ALL_RNAMES 		:= $(ALL_ASMS_RNAMES) $(ALL_CSRCS_RNAMES)

ALL_OS          := $(ALL_CSRCS_FNAMES:%=$(COBJS_PATH)/%.o)
ALL_ASMS_MEMS   := $(ALL_ASMS_FNAMES:%=$(MEMS_PATH)/%.mem)
ALL_CSRCS_MEMS  := $(ALL_CSRCS_FNAMES:%=$(MEMS_PATH)/%.mem)
ALL_MEMS        := $(ALL_FNAMES:%=$(MEMS_PATH)/%.mem)
ALL_CSVS		:= $(ALL_RNAMES:%=$(CSVS_PATH)/%.csv)
ALL_PIPES		:= $(ALL_RNAMES:%=$(PIPES_PATH)/%.html)
ALL_NLOGS		:= $(ALL_RNAMES:%=$(NLOGS_PATH)/%.csv)
ALL_ASMS_NLOGS	:= $(ALL_ASMS_RNAMES:%=$(NLOGS_PATH)/%.csv)
ALL_CSRCS_NLOGS	:= $(ALL_CSRCS_RNAMES:%=$(NLOGS_PATH)/%.csv)

SINGLE_FNAME	:= $(firstword $(ALL_FNAMES))
SINGLE_RNAME	:= $(firstword $(ALL_RNAMES))
SINGLE_O        := $(firstword $(ALL_OS))
SINGLE_MEM      := $(firstword $(ALL_MEMS))
SINGLE_CSV		:= $(firstword $(ALL_CSVS))
SINGLE_PIPE		:= $(firstword $(ALL_PIPES))
SINGLE_NLOG		:= $(firstword $(ALL_NLOGS))

SINGLE_REPNAME	:= $(call get_syn_output_name,__n$(next)__i$(nextid)__a$(pmarg))
SINGLE_REP	    := $(REPS_PATH)/$(SINGLE_REPNAME).map.rpt

IS_SINGLE_CSRC := $(filter $(SINGLE_FNAME),$(ALL_CSRCS_FNAMES))
IS_SINGLE_ASM  := $(filter $(SINGLE_FNAME),$(ALL_ASMS_FNAMES))



### Compilation parameters

C_LINK_SCRIPT    := $(SCRIPTS_PATH)/link_c.ld
C_COMMON_HEADERS := $(CSRCS_PATH)/common.h
C_COMPILER_DEPS  := $(C_COMMON_HEADERS) $(C_LINK_SCRIPT)
C_FLAGS          := -static -nostartfiles -fdiagnostics-color=always -march=rv64i -mabi=lp64
C_COMPILER       := riscv-none-elf-gcc
C_OBJCOPY        := riscv-none-elf-objcopy
C_OBJDUMP        := riscv-none-elf-objdump

### Simulation parameters

RISCV_SIM := qrun
RISCV_TB := ../riscv_tb.sv
RISCV_VERIFY := ../riscv_verify.sv ../riscv_ref.sv
RISCV_SYN_QPF := $(QUARTUS_PATH)/mgr_riscv_quartus.qpf
RISCV_SYN_QSF := $(QUARTUS_PATH)/mgr_riscv_quartus.qsf
RISCV_ALL_SOURCES =     $(wildcard $(MODEL_PATH)/*.sv     $(MODEL_PATH)/*.v     $(MODEL_PATH)/*/*.sv     $(MODEL_PATH)/*/*.v)
RISCV_ALL_SOURCES_PKG = $(wildcard $(MODEL_PATH)/*_pkg.sv $(MODEL_PATH)/*_pkg.v $(MODEL_PATH)/*/*_pkg.sv $(MODEL_PATH)/*/*_pkg.v)
RISCV_HW := $(RISCV_ALL_SOURCES_PKG) $(RISCV_ALL_SOURCES)
RISCV_TB_DEPS := $(RISCV_HW) $(RISCV_TB) ../riscv_instr_parse.vh ../riscv_verify_asserts.vh ../riscv_tb_pipeline_export.vh 
RISCV_VERIFY_DEPS := $(RISCV_HW) $(RISCV_VERIFY) ../riscv_instr_parse.vh ../riscv_verify_asserts.vh ../riscv_next_logger.vh
RISCV_SYN_DEPS := $(RISCV_HW) $(wildcard $(QUARTUS_PATH)/*.qpf $(QUARTUS_PATH)/*.qsf $(QUARTUS_PATH)/*.hex $(QUARTUS_PATH)/*.v $(QUARTUS_PATH)/*.sv $(QUARTUS_PATH)/*.qip)
RISCV_VLOG_OPS := -mfcu=macro -define SIMULATION 



define get_vlog_ops_for_rname # (rname)
$(RISCV_VLOG_OPS) -define PROGRAM_MEM_FILE_NAME="\"$(MEMS_PATH)/$(call get_fname,$1).mem\"" -define TEST_NAME="\"$(call get_name,$1)\"" -define TEST_VARIANT=$(call get,v,$1) -define RUN_FOR=$(call get,r,$1) -define JUMP_PREDICTOR_FROM_PM=\"$(call get,n,$1)\" -define JUMP_PREDICTOR_FROM_ID=\"$(call get,i,$1)\" $(call get_use_jump_predictor,$1) $(call get_args_defines_pm,$1) -define JUMP_PREDICTOR_FROM_PM_ARGS=\"$(call get,a,$1)\"
endef

define get_syn_macros_for_rname # (rname)
--verilog_macro="JUMP_PREDICTOR_FROM_PM=\\\"$(call get,n,$1)\\\"\" --verilog_macro=\"JUMP_PREDICTOR_FROM_ID=\\\"$(call get,i,$1)\\\"\" $(call get_use_jump_predictor_syn,$1) $(call get_args_defines_pm_syn,$1)
endef

### Addicional scripts

SCRIPT_C_COMPILE := $(C_COMPILER) $(C_FLAGS) -T$(C_LINK_SCRIPT)
SCRIPT_OBJCOPY   := $(C_OBJCOPY) -j .text -O binary
SCRIPT_OBJDUMP   := $(C_OBJDUMP) -d -r
SCRIPT_ASM          := node $(SCRIPTS_PATH)/asm.js
SCRIPT_BIN_TO_MEM   := node $(SCRIPTS_PATH)/convert_bin_to_mem.js
SCRIPT_PIPELINE     := node $(SCRIPTS_PATH)/pipeline_visualizer.js
SCRIPT_SUMMARY      := node $(SCRIPTS_PATH)/prediction_summary.js $(if $(sumout), --output=$(sumout)) $(if $(sumapp), --app=$(sumapp))

SCRIPT_ASM_DEPS        := $(SCRIPTS_PATH)/asm.js
SCRIPT_BIN_TO_MEM_DEPS := $(SCRIPTS_PATH)/convert_bin_to_mem.js
SCRIPT_PIPELINE_DEPS   := $(SCRIPTS_PATH)/pipeline_visualizer.js
SCRIPT_SUMMARY_DEPS    := $(SCRIPTS_PATH)/prediction_summary.js


define MKDIR
	@if not exist "$1" mkdir "$1"
endef

.PHONY: default test clear clearq clearall run gui pipeline pipeline_build show_asm syn verify verify_all verify_all_asm verify_all_c summary summary_all summary_all_asm summary_all_c asm p pb v va vaa vac s sa saa sac

default:
#	@echo $(RISCV_HW)
	@echo Requirements:  
	@echo 	- Questa
	@echo 	- RISCV GCC toolchain (https://xpack.github.io/blog/2022/05/14/riscv-none-elf-gcc-v11-3-0-1-released/)
	@echo USAGE:
	@echo (note: "opt" argument is only nessesary when dealing with .c sources. It can take values "0" through "3")
	@echo (note: "test_name" is the filename without extension inside TESTS/asms of TESTS/c_src folder)
	@echo (note: "runfor" is the timeout value of clock cycles in the simulation, by default 10000)
	@echo 	make run            name=(test_name) opt=(O_level) [runfor=(n)]               - run a simulation from an .asm file or .c file with given optimization level
	@echo 	make gui            name=(test_name) opt=(O_level)                            - run a simulation for a test with a Questa Waveform GUI
	@echo 	make pipeline       name=(test_name) opt=(O_level) [runfor=(n)]               - show pipeline visualization of a test
	@echo 	make show_asm       name=(test_name) opt=(O_level)                            - show generated assembly of a .c file with given optimization levels
	@echo 	make verify         name=(test_name) opt=(O_level) [runfor=(n)] [v=(variant)] - run verification of a test
	@echo 	make verify_all_c   [log=(log_file)] opt=(O_level) [runfor=(n)] [v=(variant)] - run verification of all .c files with given optimization levels
	@echo 	make verify_all_asm [log=(log_file)]               [runfor=(n)] [v=(variant)] - run verification of all .asm files
	@echo 	make verify_all     [log=(log_file)] opt=(O_level) [runfor=(n)] [v=(variant)] [pat=(pattern)] - run verification of all files with given optimization levels, possibly with names matching the pattern
	
test:
	@echo RNAMES: $(ALL_RNAMES)
	@echo FNAMES: $(ALL_FNAMES)
	@echo RNAME:  $(SINGLE_RNAME)
	@echo PIPE:   $(SINGLE_PIPE)
	@echo PRNAME: $(call get_rname,$(SINGLE_PIPE))
	@echo PFNAME: $(call get_fname,$(SINGLE_PIPE))
	@echo PNAME:  $(call get_name,$(SINGLE_PIPE))
	@echo PR:     $(call get,r,$(SINGLE_PIPE))
	@echo PMARG:  $(call get_args_defines_pm,$(call get_rname,$(SINGLE_PIPE)))

clearq:
	del /Q ".\qrun.out"

clear:
	del /Q $(subst /,\,$(CSVS_PATH))
	del /Q $(subst /,\,$(NLOGS_PATH))
	del /Q $(subst /,\,$(PIPES_PATH))
	
clearall: clear
	del /Q $(subst /,\,$(COBJS_PATH))
	del /Q $(subst /,\,$(MEMS_PATH))

########### RUNNING A SINGLE FILE ##############

run: $(SINGLE_MEM) $(RISCV_TB_DEPS)
	$(RISCV_SIM) $(RISCV_TB) $(RISCV_HW) -vlog.options $(call get_vlog_ops_for_rname,$(SINGLE_RNAME)) -end

gui: $(SINGLE_MEM) $(RISCV_TB_DEPS)
	$(RISCV_SIM) $(RISCV_TB) $(RISCV_HW) -gui -do "\"do wave.do\"" -voptargs="\"+acc\"" -vlog.options $(call get_vlog_ops_for_rname,$(SINGLE_RNAME)) -end

pipeline_build pb: $(SINGLE_PIPE)

pipeline p: $(SINGLE_PIPE)
	cmd /c start $<

show_asm asm: $(SINGLE_O)
	$(if $(IS_SINGLE_CSRC),$(SCRIPT_OBJDUMP) $<)
	$(if $(IS_SINGLE_ASM),$(SCRIPT_ASM) $(ASMS_PATH)/$(SINGLE_FNAME).asm --)
	
########### VERIFICATION ##############

define get_nlog_path_opt # (rname)
$(if $(nonlog),-define OUT_NEXT_LOG_FILE_NAME="\"$(NLOGS_PATH)/$1.csv\"")
endef

define run_batch_verify_step # (rname)
$(RISCV_SIM) $(RISCV_VERIFY) $(RISCV_HW) -vlog.options $(call get_vlog_ops_for_rname,$1) -define VERIFICATION_LOG_PATH="\"$(log)\"" $(call get_nlog_path_opt,$1) -end
endef

verify v: $(SINGLE_MEM) $(RISCV_VERIFY_DEPS)
	$(call MKDIR,$(NLOGS_PATH))
	$(RISCV_SIM) $(RISCV_VERIFY) $(RISCV_HW) -vlog.options $(call get_vlog_ops_for_rname,$(SINGLE_RNAME)) $(call get_nlog_path_opt,$(SINGLE_RNAME)) -define SHOW_LOG -end

verify_all_asm vaa: $(ALL_ASMS_MEMS) $(RISCV_VERIFY_DEPS)
	$(call MKDIR,$(NLOGS_PATH))
	@echo %date% %time% > $(log)
	$(foreach val,$(ALL_ASMS_RNAMES), $(call run_batch_verify_step,$(val)) &) REM

verify_all_c vac: $(ALL_CSRCS_MEMS) $(RISCV_VERIFY_DEPS)
	$(call MKDIR,$(NLOGS_PATH))
	@echo %date% %time% > $(log)
	$(foreach val,$(ALL_CSRCS_RNAMES), $(call run_batch_verify_step,$(val)) &) REM

verify_all va: $(ALL_MEMS) $(RISCV_VERIFY_DEPS)
	$(call MKDIR,$(NLOGS_PATH))
	@echo %date% %time% > $(log)
	$(foreach val,$(ALL_RNAMES), $(call run_batch_verify_step,$(val)) &) REM
#	echo $(foreach name,$(ALL_RNAMES), >> $(name)     )

########### SYNTHESIS ############



$(REPS_PATH)/%.map.rpt: $(RISCV_SYN_DEPS)
	$(call MKDIR,$(@D))
	quartus_map $(RISCV_SYN_QPF) --write_settings_files=off $(call get_syn_macros_for_rname,$(call get_rname,$@))
	copy $(QUARTUS_OUTPUT_REP_MAP_FILE)  $@
	copy $(QUARTUS_OUTPUT_REP_FLOW_FILE) $(@:%.map.rpt=%.flow.rpt)

syn: $(RISCV_SYN_DEPS)
	$(call MKDIR,$(REPS_PATH))
	quartus_map $(RISCV_SYN_QPF) --write_settings_files=off $(call get_syn_macros_for_rname,$(SINGLE_REPNAME))
	copy $(subst /,\,$(QUARTUS_OUTPUT_REP_MAP_FILE)  $(SINGLE_REP))
	copy $(subst /,\,$(QUARTUS_OUTPUT_REP_FLOW_FILE) $(SINGLE_REP:%.map.rpt=%.flow.rpt))


########### SUMMARY ##############

summary s: $(SINGLE_NLOG) $(SCRIPT_SUMMARY_DEPS)
	$(SCRIPT_SUMMARY) $(SINGLE_NLOG)

summary_all_asm saa: $(ALL_ASMS_NLOGS) $(SCRIPT_SUMMARY_DEPS)
	$(SCRIPT_SUMMARY) $(ALL_ASMS_NLOGS)

summary_all_c sac: $(ALL_CSRCS_NLOGS) $(SCRIPT_SUMMARY_DEPS)
	$(SCRIPT_SUMMARY) $(ALL_CSRCS_NLOGS)

summary_all sa: $(ALL_NLOGS) $(SCRIPT_SUMMARY_DEPS)
	$(SCRIPT_SUMMARY) $(ALL_NLOGS)

### PIPELINE AND CSVS

$(ALL_NLOGS): $(NLOGS_PATH)/%.csv: $(MEMS_PATH)/$$(call get_fname,%).mem $(RISCV_VERIFY_DEPS)
	$(call MKDIR,$(dir $(SINGLE_NLOG)))
	$(RISCV_SIM) $(RISCV_VERIFY) $(RISCV_HW) -vlog.options $(call get_vlog_ops_for_rname,$(call get_rname,$@)) -define OUT_NEXT_LOG_FILE_NAME="\"$@\"" -end
#	echo $@

$(ALL_CSVS): $(CSVS_PATH)/%.csv: $(MEMS_PATH)/$$(call get_fname,%).mem $(RISCV_TB_DEPS)
	$(call MKDIR,$(dir $(SINGLE_CSV)))
	$(RISCV_SIM) $(RISCV_TB) $(RISCV_HW) -vlog.options $(call get_vlog_ops_for_rname,$(call get_rname,$@)) -define OUT_CSV_FILE_NAME="\"$@\"" -end

$(ALL_PIPES): $(PIPES_PATH)/%.html : $(CSVS_PATH)/%.csv $(SCRIPT_PIPELINE_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_PIPELINE) $< $@

### ASM SOURCE

$(ALL_ASMS_MEMS): $(MEMS_PATH)/%.mem: $(ASMS_PATH)/%.asm $(SCRIPT_ASM_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_ASM) $< $@

### C SOURCE

$(ALL_CSRCS_MEMS): $(MEMS_PATH)/%.mem: $(COBJS_PATH)/%.bin $(SCRIPT_BIN_TO_MEM_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_BIN_TO_MEM) $< $@

$(COBJS_PATH)/%.bin: $(COBJS_PATH)/%.o
	$(call MKDIR,$(@D))
	$(SCRIPT_OBJCOPY) $< $@

$(COBJS_PATH)/%__O0.o: $(CSRCS_PATH)/%.c $(C_COMPILER_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_C_COMPILE) -O0 $< -o $@
$(COBJS_PATH)/%__O1.o: $(CSRCS_PATH)/%.c $(C_COMPILER_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_C_COMPILE) -O1 $< -o $@
$(COBJS_PATH)/%__O2.o: $(CSRCS_PATH)/%.c $(C_COMPILER_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_C_COMPILE) -O2 $< -o $@
$(COBJS_PATH)/%__O3.o: $(CSRCS_PATH)/%.c $(C_COMPILER_DEPS)
	$(call MKDIR,$(@D))
	$(SCRIPT_C_COMPILE) -O3 $< -o $@


