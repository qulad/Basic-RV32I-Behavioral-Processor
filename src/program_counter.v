module program_counter(
    input clk_i,
    input reset_i,
    input [31:0] pc_next_i,
    output reg [31:0] pc_o
);
    always @(posedge clk_i or negedge reset_i) begin
        if (reset_i) pc_o = 32'd0;
        else begin
            pc_o = pc_next_i;
        end
    end
endmodule
