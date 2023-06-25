module pc_target(
    input [31:0] pc_i,
    input [31:0] offset_i,
    output reg [31:0] instruction_o
);
    always @(*) begin
        instruction_o = pc_i + offset_i;
    end
endmodule
