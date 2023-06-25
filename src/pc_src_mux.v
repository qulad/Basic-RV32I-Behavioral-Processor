module pc_src_mux(
    input                   pc_src_i,
    input           [31:0]  zero_i,
    input           [31:0]  one_i,
    output  reg     [31:0]  pc_src_o
);
    always @(*) begin
        if (pc_src_i == 1'b1) begin
            pc_src_o = one_i;
        end
        else begin
            pc_src_o = zero_i;
        end
    end
endmodule
