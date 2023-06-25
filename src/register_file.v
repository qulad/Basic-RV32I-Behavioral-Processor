module register_file(
    input clk_i,
    input reset_i,
    input we3_i,
    input [4:0] a1_i,
    input [4:0] a2_i,
    input [4:0] a3_i,
    input [31:0] wd3_i,
    output reg [31:0] rd1_o,
    output reg [31:0] rd2_o
);
    reg [31:0] registers [31:0];
    reg [31:0] write_reg;
    always @(posedge clk_i, negedge reset_i) begin
        if (reset_i) begin
            for (integer i = 0; i<= 32; i++)
                registers[i] <= 32'd0;
        end
        else begin
            rd1_o <= (a1_i == 0) ? 32'd0 : registers[a1_i];
            rd2_o <= (a2_i == 0) ? 32'd0 : registers[a2_i];
            if ((a3_i != 32'd0) && we3_i)
                registers[a3_i] <= wd3_i;
        end
    end
endmodule
