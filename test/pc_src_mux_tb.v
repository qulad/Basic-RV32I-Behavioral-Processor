`timescale 1ns / 1ps
`include "src/pc_src_mux.v"

module pc_src_mux_tb;
    reg                   pc_src_i;
    reg           [31:0]  zero_i;
    reg           [31:0]  one_i;
    wire    [31:0]  pc_src_o;

    pc_src_mux dut (
        .pc_src_i(pc_src_i),
        .zero_i(zero_i),
        .one_i(one_i),
        .pc_src_o(pc_src_o)
    );

    reg [31:0] test_zero_i;
    reg [31:0] test_one_i;
    reg test_pc_src_i;
    reg [31:0] expected_output;

    initial begin
        $dumpfile("test/vcd/pc_src_mux_tb.vcd");
        $dumpvars(0, pc_src_mux_tb);

        test_zero_i = 32'd0;
        test_one_i = 32'd1;
        test_pc_src_i = 1'b0;
        expected_output = 32'd0;

        #10;

        zero_i = test_zero_i;
        one_i = test_one_i;
        pc_src_i = test_pc_src_i;

        #1;

        if (pc_src_o != expected_output)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", expected_output, pc_src_o);
        else
            $display("Senario 1 is successfull.");

        test_zero_i = 32'd0;
        test_one_i = 32'd1;
        test_pc_src_i = 1'b1;
        expected_output = 32'd1;

        #10;

        zero_i = test_zero_i;
        one_i = test_one_i;
        pc_src_i = test_pc_src_i;

        #1;

        if (pc_src_o != expected_output)
            $display("ERROR: Senario 2, Expected Output: %d, Actual Output: %d", expected_output, pc_src_o);
        else
            $display("Senario 2 is successfull.");

        $finish;
    end

endmodule
