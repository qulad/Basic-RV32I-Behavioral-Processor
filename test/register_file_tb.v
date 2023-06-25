`timescale 1ns / 1ps
`include "src/register_file.v"

module register_file_tb;
    reg clk_i;
    reg reset_i;
    reg we3_i;
    reg [4:0] a1_i;
    reg [4:0] a2_i;
    reg [4:0] a3_i;
    reg [31:0] wd3_i;
    wire [31:0] rd1_o;
    wire [31:0] rd2_o;

    register_file dut (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .we3_i(we3_i),
        .a1_i(a1_i),
        .a2_i(a2_i),
        .a3_i(a3_i),
        .wd3_i(wd3_i),
        .rd1_o(rd1_o),
        .rd2_o(rd2_o)
    );

    initial begin
        $dumpfile("test/vcd/register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk_i = 0;
        reset_i = 1;
        we3_i = 0;
        a1_i = 0;
        a2_i = 0;
        a3_i = 0;
        wd3_i = 0;
        
        // Reset
        #10 reset_i = 0;
        #10 reset_i = 1;

        // Test 1
        #10 a1_i = 1;  // Read register 1
        #10 a2_i = 2;  // Read register 2
        #10 a3_i = 3;  // Write register 3
        #10 wd3_i = 32'd12345;  // Write data
        #10 we3_i = 1;  // Enable write
        #10 we3_i = 0;  // Disable write
        // Check the outputs
        if (rd1_o === 32'd0 && rd2_o === 32'd0) $display("Test 1: PASS");
        else $display("Test 1: FAIL");

        // Test 2
        #10 a1_i = 0;  // Read register 0
        #10 a2_i = 4;  // Read register 4
        #10 a3_i = 5;  // Write register 5
        #10 wd3_i = 32'd9876;  // Write data
        #10 we3_i = 1;  // Enable write
        #10 we3_i = 0;  // Disable write
        // Check the outputs
        if (rd1_o === 32'd0 && rd2_o === 32'd0) $display("Test 2: PASS");
        else $display("Test 2: FAIL");

        // Add more tests as needed

        #10 $finish;
    end

    always begin
        #5 clk_i = ~clk_i;
    end
endmodule
