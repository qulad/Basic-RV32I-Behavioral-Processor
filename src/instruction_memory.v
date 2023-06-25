module instruction_memory(
    input clk_i,
    input reset_i,
    input [31:0] addr_i,
    output reg [31:0] instruction_o
);
    reg [31:0] memory [0:31];
    reg first_boot;

    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            instruction_o <= memory[0];
            first_boot <= 1'b1;
        end else if (first_boot) begin
            instruction_o <= memory[0];
            if (addr_i != 32'h00000000) begin
                first_boot <= 1'b0;
            end
        end else begin
            instruction_o <= memory[addr_i];
        end
    end

    initial begin
        memory[0] <= 32'h01234567;
        memory[1] <= 32'h89ABCDEF;
    end
endmodule
