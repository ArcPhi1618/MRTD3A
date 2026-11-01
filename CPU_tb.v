`timescale 1ns/1ps

`include "OpCodes.v"

module CPU_tb;
    reg clk;
    reg rst;
    reg [3:0] opCode;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire [7:0] pc_out;

    CPU dut (
        .clk(clk),
        .rst(rst),
        .opCode(opCode),
        .data_in(data_in),
        .data_out(data_out),
        .pc_out(pc_out)
    );

    always #5 clk = ~clk;

    task automatic issue(input [3:0] opcode, input [7:0] operand);
        begin
            @(negedge clk);
            opCode = opcode;
            data_in = operand;
            repeat (3) @(posedge clk);
            #1;
        end
    endtask

    task automatic check_state(input [7:0] expected_acc, input [7:0] expected_pc);
        begin
            if (data_out !== expected_acc || pc_out !== expected_pc)
                $fatal(1, "Expected accumulator=%h pc=%h, got accumulator=%h pc=%h",
                       expected_acc, expected_pc, data_out, pc_out);
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        opCode = 4'b0;
        data_in = 8'b0;

        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        opCode = `MOVW;
        data_in = 8'hfe;
        repeat (3) @(posedge clk);
        #1;

        check_state(8'hfe, 8'h01);

        issue(`ADDW, 8'h05);
        check_state(8'h03, 8'h02);

        issue(`MOVWM, 8'h21);
        check_state(8'h03, 8'h03);

        issue(`MOVW, 8'h00);
        check_state(8'h00, 8'h04);

        issue(`MOVMW, 8'h21);
        check_state(8'h03, 8'h05);

        issue(`LOADW, 8'haa);
        check_state(8'haa, 8'h06);

        issue(4'hf, 8'h00);
        check_state(8'haa, 8'h07);

        $display("CPU_tb passed");
        $finish;
    end
endmodule
