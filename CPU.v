module CPU (
    input clk,
    input rst,
    input [3:0] opCode,
    input [7:0] data_in,
    output [7:0] data_out,
    output [7:0] pc_out
);
    wire [3:0] alu_op;
    wire [7:0] alu_operand;
    wire [7:0] alu_result;
    wire [7:0] accumulator;
    wire [7:0] acc_data;
    wire acc_we;
    wire pc_inc;
    wire mem_read;
    wire mem_write;
    wire [7:0] mem_addr;
    wire [7:0] mem_data_in;
    wire [7:0] mem_data_out;

    CU ControlUnit (
        .clk(clk),
        .rst(rst),
        .opCode(opCode),
        .data_in(data_in),
        .accumulator(accumulator),
        .mem_data_in(mem_data_in),
        .alu_result(alu_result),
        .alu_op(alu_op),
        .alu_operand(alu_operand),
        .acc_we(acc_we),
        .pc_inc(pc_inc),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_addr(mem_addr),
        .mem_data_out(mem_data_out),
        .acc_data(acc_data)
    );

    registers RegisterFile (
        .clk(clk),
        .rst(rst),
        .pc_inc(pc_inc),
        .acc_we(acc_we),
        .acc_data(acc_data),
        .accumulator(accumulator),
        .pc_out(pc_out)
    );

    ALU ArithmeticLogicUnit (
        .A(accumulator),
        .B(alu_operand),
        .aluOp(alu_op),
        .aluOut(alu_result)
    );

    RAM DataMemory (
        .clk(clk),
        .rst(rst),
        .we(mem_write),
        .oe(mem_read),
        .mem_in(mem_data_out),
        .mem_add(mem_addr),
        .mem_out(mem_data_in)
    );

    assign data_out = accumulator;
endmodule
