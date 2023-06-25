module result_src_mux(
    input [2:0] result_src_flag_i,
    input [31:0] alu_result_i,
    input [31:0] read_data_i,
    input [31:0] extended_i,
    input [31:0] pc_plus_4_i,
    input [31:0] comp_i,
    output reg [31:0] result_o
);
    always @(*) begin
        case(result_src_flag_i)
            3'b000: result_o = alu_result_i;
            3'b001: result_o = read_data_i;
            3'b010: result_o = extended_i;
            3'b011: result_o = pc_plus_4_i;
            3'b100: result_o = comp_i;
            default: result_o = 32'd0;
        endcase
    end
endmodule
