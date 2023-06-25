`timescale 1ns / 1ps
`include "src/pc_plus_4.v"

module pc_plus_4_tb;
    reg [31:0] instruction_i;
    wire [31:0] instruction_o;
    
    pc_plus_4 dut (
        .instruction_i(instruction_i),
        .instruction_o(instruction_o)
    );
    
    reg [31:0] expected_output;

    initial begin
        $dumpfile("test/vcd/pc_plus_4_tb.vcd");
        $dumpvars(0, pc_plus_4_tb);

        instruction_i = 0;
        expected_output = 4;
        #1;
        if (instruction_o != expected_output)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", expected_output, instruction_i);
        else
            $display("Senario 1 is successfull.");
        
        instruction_i = 10;
        expected_output = 14;
        #1;
        if (instruction_o != expected_output)
            $display("ERROR: Senario 3, Expected Output: %d, Actual Output: %d", expected_output, instruction_i);
        else
        $display("Senario 2 is successfull.");
        
        instruction_i = 4294967291;
        expected_output = 4294967295;
        #1;
        if (instruction_o != expected_output)
            $display("ERROR: Senario 3, Expected Output: %d, Actual Output: %d", expected_output, instruction_i);
        else
            $display("Senario 3 is successfull.");
        
        $finish;
    end
endmodule
