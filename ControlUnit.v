`include "OpCodes.v"

module CU (
	input clk,
	input rst,
	input [3:0] opCode,
	input [7:0] data_in,
	input [7:0] accumulator,
	input [7:0] mem_data_in,
	input [7:0] alu_result,
	output reg [3:0] alu_op,
	output reg [7:0] alu_operand,
	output reg acc_we,
	output reg pc_inc,
	output reg mem_read,
	output reg mem_write,
	output reg [7:0] mem_addr,
	output reg [7:0] mem_data_out,
	output reg [7:0] acc_data
);
	localparam FETCH = 2'b00;
	localparam DECODE = 2'b01;
	localparam EXECUTE = 2'b10;

	reg [1:0] state;
	reg [3:0] instruction_opcode;
	reg [7:0] instruction_operand;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= FETCH;
			instruction_opcode <= `NOOP;
			instruction_operand <= 8'b0;
		end else begin
			case (state)
				FETCH: begin
					instruction_opcode <= opCode;
					instruction_operand <= data_in;
					state <= DECODE;
				end
				DECODE: state <= EXECUTE;
				EXECUTE: state <= FETCH;
				default: state <= FETCH;
			endcase
		end
	end

	always @* begin
		alu_op = `ALU_NOOP;
		alu_operand = instruction_operand;
		acc_we = 1'b0;
		pc_inc = 1'b0;
		mem_read = 1'b0;
		mem_write = 1'b0;
		mem_addr = instruction_operand;
		mem_data_out = accumulator;
		acc_data = 8'b0;

		if (state == EXECUTE) begin
			pc_inc = 1'b1;
			case (instruction_opcode)
				`NOOP: begin
				end
				`LOADW, `MOVW: begin
					acc_we = 1'b1;
					acc_data = instruction_operand;
				end
				`MOVWM: mem_write = 1'b1;
				`MOVMW: begin
					mem_read = 1'b1;
					acc_we = 1'b1;
					acc_data = mem_data_in;
				end
				`ADDW: begin
					alu_op = `ADD;
					acc_we = 1'b1;
					acc_data = alu_result;
				end
				default: begin
				end
			endcase
		end
	end
endmodule
