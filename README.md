# Single Cycle RISC-V Processor

This project is a **single cycle RISC-V processor** designed in Verilog.  
It supports a minimal subset of RV32I instructions (addi, add, sw, beq) and can execute small programs stored in instruction memory.

---

## Features
- Program Counter with PC+4 and branch support
- Instruction Memory (hex file initialization)
- Register File with 32 registers
- Immediate Generator for I, S, and B formats
- ALU + ALU Control Unit (supports ADD, SUB, AND, OR)
- Data Memory with read/write
- Control Unit for instruction decoding
- Top level integration and testbench
- Verified using **Icarus Verilog + GTKWave**

---

## Repository Structure
- `src/` → Verilog modules
- `tb/` → Testbenches
- `mem/` → Instruction memory hex files
- `waves/` → Example waveforms (VCD + GTKWave saves)
- `Makefile` → Easy simulation run

---

## How to Run
iverilog -o cpu_sim src/*.v tb/top_tb.v
vvp cpu_sim
gtkwave cpu_wave.vcd

---

## Example Program
The included `program.hex` runs:
```assembly
addi x1, x0, 5    # x1 = 5
addi x2, x0, 10   # x2 = 10
add  x3, x1, x2   # x3 = 15
sw   x3, 0(x0)    # MEM[0] = 15
beq  x0, x0, -4   # infinite loop
