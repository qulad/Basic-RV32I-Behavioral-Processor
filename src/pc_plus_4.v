module pc_plus_4(
    input           [31:0]  instruction_i,
    output  reg     [31:0]  instruction_o
);
    always @(*) begin
        instruction_o = instruction_i + 4;
    end
endmodule
