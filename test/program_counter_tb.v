`timescale 1ns / 1ps
`include "src/program_counter.v"

module program_counter_tb;
    reg clk_i;
    reg reset_i;
    reg [31:0] pc_next_i;
    wire [31:0] pc_o;
    
    program_counter dut (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_next_i(pc_next_i),
        .pc_o(pc_o)
    );
    
    initial begin
        $dumpfile("test/vcd/program_counter_tb.vcd");
        $dumpvars(0, program_counter_tb);
        
        clk_i = 0;
        reset_i = 1;
        pc_next_i = 123;
        #5;
        reset_i = 0;
        #10;
        if (pc_o !== 123)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", 123, pc_o);
        else
            $display("Senario 1 is successfull.");
        
        clk_i = 0;
        reset_i = 1;
        pc_next_i = 987;
        #5;
        reset_i = 0;
        #5;
        clk_i = 1;
        #5;
        clk_i = 0;
        #5;
        if (pc_o !== 987)
            $display("ERROR: Senario 2, Expected Output: %d, Actual Output: %d", 987, pc_o);
        else
            $display("Senario 2 is successfull.");
        
        clk_i = 0;
        reset_i = 1;
        pc_next_i = 555;
        #5;
        reset_i = 0;
        #5;
        clk_i = 1;
        #5;
        clk_i = 0;
        #5;
        if (pc_o !== 555)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", 555, pc_o);
        else
            $display("Senario 3 is successfull.");
        $finish;
    end
    
    always begin
        #1;
        clk_i = ~clk_i;
    end
endmodule
