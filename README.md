# MRTD3A

This repository contains a small, synchronous 8-bit CPU. `CPU` accepts a
4-bit opcode and an 8-bit operand on its inputs, captures them during fetch,
and executes each instruction in three clock phases (fetch, decode, execute).
The opcode and operand must remain valid at the fetch edge. `data_out` exposes
the accumulator, and `pc_out` exposes the instruction counter.

The CPU has 256 bytes of internal data RAM. `MOVWM` stores the accumulator at
the operand address; `MOVMW` loads the accumulator from that address. `MOVW`
and `LOADW` load the 8-bit operand into the accumulator, and `ADDW` adds the
operand to the accumulator.

| Opcode | Mnemonic | Operation |
| --- | --- | --- |
| `0x0` | `NOOP` | No accumulator or memory change |
| `0x1` | `LOADW` | Accumulator = operand |
| `0x2` | `MOVW` | Accumulator = operand |
| `0x3` | `MOVWM` | RAM[operand] = accumulator |
| `0x4` | `MOVMW` | Accumulator = RAM[operand] |
| `0x5` | `ADDW` | Accumulator = accumulator + operand |

`ALU` also provides 8-bit add, subtract, increment, decrement, bitwise, and
logical-shift operations. The opcode and ALU operation encodings are defined
in `OpCodes.v`.

The self-checking `CPU_tb.v` testbench covers immediate loads, addition,
memory store/load, unknown opcodes, and program-counter updates. With ModelSim,
run `vlib work`, `vlog -sv ALU.v CPU.v ControlUnit.v RAM.v Registers.v CPU_tb.v`,
then `vsim -c CPU_tb -do "run -all; quit -f"`.