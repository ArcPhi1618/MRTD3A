`ifndef MRTD3A_OPCODES_V
`define MRTD3A_OPCODES_V

`define NOOP  4'h0
`define LOADW 4'h1
`define MOVW  4'h2
`define MOVWM 4'h3
`define MOVMW 4'h4
`define ADDW  4'h5

`define ALU_NOOP 4'hf
`define ADD      4'h0
`define SUB      4'h1
`define INC      4'h2
`define DEC      4'h3
`define AND      4'h4
`define OR       4'h5
`define NOT      4'h6
`define XOR      4'h7
`define SHL      4'h8
`define SHR      4'h9

`endif
