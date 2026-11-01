`include "OpCodes.v"

module ALU (
    input [7:0] A,
    input [7:0] B,
    input [3:0] aluOp,
    output reg [7:0] aluOut
);
    always @* begin
        aluOut = 8'b0;

        case (aluOp)
            `ADD: aluOut = A + B;
            `SUB: aluOut = A - B;
            `INC: aluOut = A + 8'b1;
            `DEC: aluOut = A - 8'b1;
            `AND: aluOut = A & B;
            `OR:  aluOut = A | B;
            `NOT: aluOut = ~A;
            `XOR: aluOut = A ^ B;
            `SHL: aluOut = A << B[2:0];
            `SHR: aluOut = A >> B[2:0];
            default: aluOut = 8'b0;
        endcase
    end
endmodule
