`timescale 1ns / 1ps
`include "src/pc_target.v"

module pc_target_tb;
    reg [31:0] pc_i;
    reg [31:0] offset_i;
    wire [31:0] instruction_o;
    
    pc_target dut (
        .pc_i(pc_i),
        .offset_i(offset_i),
        .instruction_o(instruction_o)
    );
    
    reg [31:0] expected_output;

    initial begin
        $dumpfile("test/vcd/pc_target_tb.vcd");
        $dumpvars(0, pc_target_tb);

        pc_i = 0;
        offset_i = 0;
        expected_output = 0;
        #1;
        if (instruction_o != expected_output)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", expected_output, instruction_o);
        else
            $display("Senario 1 is successfull.");
        
        pc_i = 16;
        offset_i = 33;
        expected_output = 49;
        #1;
        if (instruction_o != expected_output)
            $display("ERROR: Senario 2, Expected Output: %d, Actual Output: %d", expected_output, instruction_o);
        else
            $display("Senario 2 is successfull.");
        
        pc_i = 4294967291;
        offset_i = 880;
        expected_output = 4294968171;
        #1;
        if (instruction_o != expected_output)
            $display("ERROR: Senario 3, Expected Output: %d, Actual Output: %d", expected_output, instruction_o);
        else
            $display("Senario 3 is successfull.");
        
        $finish;
    end
endmodule
