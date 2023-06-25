`timescale 1ns / 1ps
`include "src/result_src_mux.v"

module result_src_mux_tb;
    reg [2:0] result_src_flag_i;
    reg [31:0] alu_result_i;
    reg [31:0] read_data_i;
    reg [31:0] extended_i;
    reg [31:0] pc_plus_4_i;
    reg [31:0] comp_i;
    wire [31:0] result_o;

    result_src_mux dut (
        .result_src_flag_i(result_src_flag_i),
        .alu_result_i(alu_result_i),
        .read_data_i(read_data_i),
        .extended_i(extended_i),
        .pc_plus_4_i(pc_plus_4_i),
        .comp_i(comp_i),
        .result_o(result_o)
    );

    initial begin
        $dumpfile("test/vcd/result_src_mux_tb.vcd");
        $dumpvars(0, result_src_mux_tb);

        alu_result_i = 32'd100;
        read_data_i = 32'd110;
        extended_i = 32'd11111;
        pc_plus_4_i = 32'd11010101;
        comp_i = 32'd100010001;

        #10;

        result_src_flag_i = 3'b000;
        #1;
        if (result_o !== alu_result_i)
            $display("ERROR: Senario 1, Expected Output: %d, Actual Output: %d", alu_result_i, result_o);
        else
            $display("Senario 1 is successfull.");
        
        #10;

        result_src_flag_i = 3'b001;
        #1;
        if (result_o !== read_data_i)
            $display("ERROR: Senario 2, Expected Output: %d, Actual Output: %d", read_data_i, result_o);
        else
            $display("Senario 2 is successfull.");
        
        #10;

        result_src_flag_i = 3'b010;
        #1;
        if (result_o !== extended_i)
            $display("ERROR: Senario 3, Expected Output: %d, Actual Output: %d", extended_i, result_o);
        else
            $display("Senario 3 is successfull.");
        
        #10;

        result_src_flag_i = 3'b011;
        #1;
        if (result_o !== pc_plus_4_i)
            $display("ERROR: Senario 4, Expected Output: %d, Actual Output: %d", pc_plus_4_i, result_o);
        else
            $display("Senario 4 is successfull.");
        
        #10;

        result_src_flag_i = 3'b100;
        #1;
        if (result_o !== comp_i)
            $display("ERROR: Senario 5, Expected Output: %d, Actual Output: %d", comp_i, result_o);
        else
            $display("Senario 5 is successfull.");
        
        #10;
        
        result_src_flag_i = 3'b101;
        #1;
        if (result_o !== 32'd0)
            $display("ERROR: Senario 6, Expected Output: %d, Actual Output: %d", 32'd0, result_o);
        else
            $display("Senario 6 is successfull.");
        
        #10;

        result_src_flag_i = 3'b110;
        #1;
        if (result_o !== 32'd0)
            $display("ERROR: Senario 7, Expected Output: %d, Actual Output: %d", 32'd0, result_o);
        else
            $display("Senario 7 is successfull.");
        
        #10;

        result_src_flag_i = 3'b111;
        #1;
        if (result_o !== 32'd0)
            $display("ERROR: Senario 8, Expected Output: %d, Actual Output: %d", 32'd0, result_o);
        else
            $display("Senario 8 is successfull.");
    
        $finish;
    end
endmodule
