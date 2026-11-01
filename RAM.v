module RAM (
    input clk,
    input rst,
    input we,
    input oe,
    input [7:0] mem_in,
    input [7:0] mem_add,
    output [7:0] mem_out
);
    integer i;
    reg [7:0] ram [0:255];

    assign mem_out = oe ? ram[mem_add] : 8'b0;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 256; i = i + 1)
                ram[i] <= 8'b0;
        end else if (we) begin
            ram[mem_add] <= mem_in;
        end
    end
endmodule
