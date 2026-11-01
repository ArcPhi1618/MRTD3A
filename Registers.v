module registers (
    input clk,
    input rst,
    input pc_inc,
    input acc_we,
    input [7:0] acc_data,
    output reg [7:0] accumulator,
    output reg [7:0] pc_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            accumulator <= 8'b0;
            pc_out <= 8'b0;
        end else begin
            if (pc_inc)
                pc_out <= pc_out + 8'b1;
            if (acc_we)
                accumulator <= acc_data;
        end
    end
endmodule
