module alu(
    input [31:0] src_a_i,
    input [31:0] src_b_i,
    input alu_sign_i,
    input [2:0] alu_control_i,
    output reg [31:0] alu_result_o,
    output reg [2:0] alu_flags_o // [0]Negative, [1]Zero, [2]oVerflow, [3]Carry
);
    always @(*) begin
        case(alu_control_i)
            3'b000: begin // +
                    alu_result_o <= src_a_i + src_b_i;
                    alu_flags_o <= 2'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1;  // Zero
                    else if (alu_result_o[31] == 1)
                        alu_flags_o[0] <= 1;  // Negatif
                    alu_flags_o[3] <= (alu_result_o < src_a_i) | (alu_result_o < src_b_i); // Carry
                    alu_flags_o[2] <= (src_a_i[31] ^ src_b_i[31]) & (alu_result_o[31] ^ src_a_i[31]); // oVerflow
                end
            3'b001: begin // -
                    alu_result_o <= src_a_i - src_b_i;
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                    else if (alu_result_o[31] == 1)
                        alu_flags_o[0] <= 1; // Negatif
                    alu_flags_o[3] <= (src_a_i < src_b_i); // Carry
                    alu_flags_o[2] <= (src_a_i[31] ^ src_b_i[31]) & (alu_result_o[31] ^ src_a_i[31]); // oVerflow
                end
            3'b010: begin // &, |
                if (alu_sign_i == 0) begin // &
                    alu_result_o <= src_a_i & src_b_i;
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
                else begin // |
                    alu_result_o <= src_a_i | src_b_i;
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
            end
            3'b011: begin // xor, xori
                if (alu_sign_i == 0) begin // xor
                    alu_result_o <= src_a_i ^ src_b_i;
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
                else begin // xori
                    alu_result_o <= src_a_i ^ src_b_i;
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
            end
            3'b100: begin // sra, srai
                if (alu_sign_i == 0) begin // sra
                    alu_result_o <= src_a_i >>> src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
                else begin // srai
                    alu_result_o <= src_a_i >>> src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
            end
            3'b101: begin // sla, slai
                if (alu_sign_i == 0) begin // sla
                    alu_result_o <= src_a_i <<< src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
                else begin // slai
                    alu_result_o <= src_a_i <<< src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
            end
            3'b110: begin // srl, srli
                if (alu_sign_i == 0) begin // srl
                    alu_result_o <= src_a_i >> src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
                else begin // srli
                    alu_result_o <= src_a_i >> src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
            end
            3'b111: begin // sll, slli
                if (alu_sign_i == 0) begin // sll
                    alu_result_o <= src_a_i << src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
                else begin // slli
                    alu_result_o <= src_a_i << src_b_i[4:0];
                    alu_flags_o <= 4'b00;
                    if (alu_result_o == 0)
                        alu_flags_o[1] <= 1; // Zero
                end
            end
        endcase
    end
endmodule
