This is a stripped-down version (from licensed RISC-V code) of the project for my Master's Thesis. Every file here was created by me.

**This makes it impossible to actually compile and test the code.** To do so, you can **download a ZIP from the GitHub releases**, which contains this project together with most build artifacts, so you can see the compiled programs, test summaries, and pipeline visualizations.
Alternatively, if you want, you can contact me privately, so that I can send you the complete codebase. I just cannot make the rest of the code publicly available.

**A lot of my work went into not only creating the branch predictor, but into debugging the existing RISC-V project.** Because of the licensing, I am unable to show these changes here :(

## Project Structure

- `./hw_src/jump_predictor/` - all implemented submodules and variants of the branch predictor in SystemVerilog, configurable via macros
- `./quartus/` - Quartus Prime project, used for generating estimated max clock speed, etc. *(not fully completed, since my thesis didn't ultimately require it)*
- `./sim_src/scripts/`
  - `asm.js` - simple RISC-V assembler, created by me
  - `link_c.ld` - linker script, used to run the compiled program on "bare-metal" without any operating system
  - `pipeline_visualizer.js` - script used for generating the HTML pipeline visualization, based on a CSV file representing the execution of a program
  - `prediction_summary.js` - script used for generating the branch predictor efficiency summary, based on a CSV file representing the execution of a program
- `./sim_src/TESTS/`
  - `asms/`, `c_src/` - source codes for tested programs
  - `c_obj/`, `progmems/` - program build artifacts
  - `csvs/`, `nextlogs/` - CSV files representing the execution of a program and the behavior of the configured branch predictor
  - `reps/` - Quartus Prime reports
  - `summaries/` - summaries of prediction efficiency for various sets of configurations
  - `pipelines/` - HTML visualizations of program execution
  - `Makefile` - the makefile, automating all possible tests
- `./sim_src/riscv_ref.sv` - reference RISC-V processor model
- `./sim_src/riscv_verify.sv`, `./sim_src/riscv_tb.sv` - testbenches used for tests

## Makefile Usage

Notable targets:
- `run` - simulates the program
- `gui` - shows simulation result in Questa Sim GUI
- `pipeline` - creates an HTML pipeline visualization
- `verify` - performs comparison of the simulation with the reference model
- `summary` - generates summaries for the specified configuration

Any possible target can accept configuration parameters, for example:
- `name` - name of the `.asm` or `.c` source file to compile and simulate
- `opt` - optimization level (only for `.c` source files)
- `next` - name for the chosen branch prediction strategy for the PM stage. Possible values:
  - `none`
  - `btb`
  - `bht`
  - `bhtret`
- `nextid` - name for the chosen branch prediction strategy for the ID stage. Possible values:
  - `none`
  - `jump`
  - `jumpret`
- `pmarg` - arguments for the specified PM prediction strategy
- `runfor` - how many simulation steps to perform

## Example

For example, the command:
```
make pipeline name=fizzbuzz opt=3 next=btb pmarg=4_2 nextid=jumpret
```
will generate the pipeline visualization for the `fizzbuzz.c` test program, compiling it with `-O3` level optimizations, using a branch predictor consisting of the `btb` strategy (as a buffer with 2^**4** entries and **2**-bit saturation counters) for the PM pipeline stage, and the `jumpret` strategy for the ID pipeline stage.

All resulting build targets have a filename with embedded configuration. For example, the resulting pipeline visualization will have the filename:
```
fizzbuzz__O3__v0__r10000__nbtb__ijumpret__a4_2.html
```