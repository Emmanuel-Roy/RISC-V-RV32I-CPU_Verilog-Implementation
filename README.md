# RISC-V RV32I CPU - Verilog Implementation

## Introduction:
After taking ECE 316 (Digital Logic Design) at the University of Texas at Austin, I found that I enjoyed using HDLs. I thought it would be cool to make a CPU in Verilog, so after some research, I found the RISC-V RV32I ISA and got started.

This project required a ton of independent research, so there isn't much optimization. I plan to implement optimizations, such as parallelization and pipelining, after I develop those skills in ECE 460N (Computer Architecture) next spring.

## Goals:
  * Implement all of the RV32I's Base Instructions. ✅
  * Create test benches to ensure maximum accuracy. ✅
  * Synthesis on a Basys 3 with AMD Artix 7 FPGA Board.

## Simulation Output (Basic Test Case)

### Input:

![image](https://github.com/Emmanuel-Roy/RISC-V-RV32I-CPU_Verilog-Implementation/assets/54725843/3d700c9a-c805-437a-835e-28774d107aa7)

### Output:

![image](https://github.com/Emmanuel-Roy/RISC-V-RV32I-CPU_Verilog-Implementation/assets/54725843/56376a31-53cd-48dc-a476-399f4b892458)

## Potential Plans:
  * Implement Pipelining.
  * Pass RISC-V [rv32ui Unit Test.](https://github.com/riscv-software-src/riscv-tests).
  * Implement [Zicsr](https://five-embeddev.com/riscv-user-isa-manual/Priv-v1.12/csr.html#csr-instructions) extension.
  * Implement [Zifencei](https://five-embeddev.com/riscv-user-isa-manual/Priv-v1.12/zifencei.html#chap:zifencei) extension.
  * Run Linux

## Reference:
  * [Blinker To RISC-V](https://github.com/BrunoLevy/learn-fpga/blob/master/FemtoRV/TUTORIALS/FROM_BLINKER_TO_RISCV/README.md)
  * [The RISC-V Instruction Set Manual](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf)
  * [How to Design a RISC-V Processor](https://medium.com/programmatic/how-to-design-a-risc-v-processor-12388e1163c)
  * [Writing a simple RISC-V emulator in plain C](https://fmash16.github.io/content/posts/riscv-emulator-in-c.html)
  * [16-Bit-CPU-using-Verilog](https://github.com/vprabhu28/16-Bit-CPU-using-Verilog)
  * [Bare metal C on my RISC-V toy CPU](https://florian.noeding.com/posts/risc-v-toy-cpu/cpu-from-scratch/)
  * [RV32emu](https://github.com/sysprog21/rv32emu/tree/master)
  * [LupV](https://gitlab.com/luplab/lupv)
  * [RISCV](https://github.com/AngeloJacobo/RISC-V)
  * [Toast-RV32](https://github.com/georgeyhere/Toast-RV32i)
  * Jim Ledin “Modern Computer Architecture and Organization" (2022)
  * David Patterson and John L. Hennessy "Computer Organization and Design RISC-V Edition: The Hardware Software Interface" (2nd Edition)
