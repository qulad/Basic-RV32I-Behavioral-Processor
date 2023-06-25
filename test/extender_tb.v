`timescale 1ns / 1ps
`include "src/extender.v"

module extender_tb;
    reg [2:0] extend_i;
    reg [19:0] u_type_i;
    reg [8:0] j_type_i;
    reg [12:0] b_type_i;
    reg [11:0] s_type_i;
    reg [11:0] i_type_i;
    wire [31:0] extended_o;

    extender dut (
        .extend_i(extend_i),
        .u_type_i(u_type_i),
        .j_type_i(j_type_i),
        .b_type_i(b_type_i),
        .s_type_i(s_type_i),
        .i_type_i(i_type_i),
        .extended_o(extended_o)
    );

    reg [31:0] expected_output;

    initial begin
        $dumpfile("test/vcd/extender_tb.vcd");
        $dumpvars(0, extender_tb);

        extend_i = 3'b000;   // U Type
        u_type_i = 20'b10010010011001001001;
        expected_output = 32'b10010010011001001001000000000000;
        #1;
        if (extended_o != expected_output)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", expected_output, extended_o);
        else
            $display("Senario 1 is successfull.");
        
        #10;
        
        extend_i = 3'b001;   // J Type
        j_type_i = 8'b11001001;
        expected_output = 32'b00000000000011001001000000000000;
        #1;
        if (extended_o != expected_output)
            $display("ERROR: Senario 2, Expected Output: %d, Actual Output: %d", expected_output, extended_o);
        else
            $display("Senario 2 is successfull.");
        
        #10;

        extend_i = 3'b010;   // B Type
        b_type_i = 13'b1110010011001;
        expected_output = 32'b00000000000000000001110010011001;
        #1;
        if (extended_o != expected_output)
            $display("ERROR: Senario 3, Expected Output: %d, Actual Output: %d", expected_output, extended_o);
        else
            $display("Senario 3 is successfull.");
        
        #10;

        extend_i = 3'b011;   // S Type
        s_type_i = 12'b110010011001;
        expected_output = 32'b00000000000000000000110010011001;
        #1;
        if (extended_o != expected_output)
            $display("ERROR: Senario 4, Expected Output: %b, Actual Output: %b", expected_output, extended_o);
        else
            $display("Senario 4 is successfull.");
        
        #10;

        extend_i = 3'b100;   // I Type
        i_type_i = 12'b110010011011;
        expected_output = 32'b00000000000000000000110010011011;
        #1;
        if (extended_o != expected_output)
            $display("ERROR: Senario 5, Expected Output: %b, Actual Output: %b", expected_output, extended_o);
        else
            $display("Senario 5 is successfull.");
        
        $finish;
    end

endmodule
