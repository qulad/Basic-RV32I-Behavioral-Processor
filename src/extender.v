module extender(
    input [1:0] extend_i,
    input [19:0] u_type_i,
    input [8:0] j_type_i,
    input [12:0] b_type_i,
    input [11:0] i_and_s_type_i,
    output reg [31:0] extended_o
);
    reg [31:0] temp;
    always @(*) begin
        case (extend_i)
            2'b00: begin // U Type
                temp[31:12] = u_type_i;
                temp[11:0] = 12'b0;
            end
            2'b01: begin // J Type
                temp[20:12] = j_type_i;
                temp[31:21] = 11'b0;
                temp[11:0] = 12'b0;
            end
            2'b10: begin // B Type
                temp[12:0] = b_type_i;
                temp[31:13] = 19'b0;
            end
            2'b11: begin // I and S Type
                temp[11:0] = i_and_s_type_i;
                temp[31:12] = 20'b0;
            end
            default: temp = 32'b0;
        endcase
        extended_o = temp;
    end
endmodule
