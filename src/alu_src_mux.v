module alu_src_mux(
    input                   alu_src_i,
    input           [31:0]  rd2_i,
    input           [31:0]  extended_i,
    output  reg     [31:0]  src_b_o
);
    always @(*) begin
        if (alu_src_i == 1'b1) begin
            src_b_o = extended_i;
        end
        else begin
            src_b_o = rd2_i;
        end
    end
endmodule
