`timescale 1ns / 1ps
`include "src/alu.v"

module alu_testbench;

    reg [31:0] src_a_i;
    reg [31:0] src_b_i;
    reg [1:0] alu_control_i;
    wire [31:0] alu_result_o;
    wire [2:0] alu_flags_o;
    
    // ALU modülünü çağırma
    alu dut (
        .src_a_i(src_a_i),
        .src_b_i(src_b_i),
        .alu_control_i(alu_control_i),
        .alu_result_o(alu_result_o),
        .alu_flags_o(alu_flags_o)
    );
    
    // Zamanlama sinyali oluşturma
    reg clk;
    always #5 clk = ~clk;
    
    // Test senaryoları için sinyaller
    reg [31:0] expected_result;
    reg [2:0] expected_flags;
    
    initial begin
        clk = 0;
        
        // Senaryo 1: Toplama
        src_a_i = 10;
        src_b_i = 5;
        alu_control_i = 2'b00;
        expected_result = 15;
        expected_flags = 3'b000;
        
        // Senaryo 2: Çıkarma
        src_a_i = 10;
        src_b_i = 5;
        alu_control_i = 2'b01;
        expected_result = 5;
        expected_flags = 3'b000;
        
        // Senaryo 3: Mantıksal VE
        src_a_i = 5;
        src_b_i = 3;
        alu_control_i = 2'b10;
        expected_result = 1;
        expected_flags = 3'b001;
        
        // Senaryo 4: Mantıksal VEYA
        src_a_i = 5;
        src_b_i = 3;
        alu_control_i = 2'b11;
        expected_result = 7;
        expected_flags = 3'b000;
        
        // Test senaryolarını çalıştırma
        #10;
        run_test(1);
        run_test(2);
        run_test(3);
        run_test(4);
        
        $finish;
    end
    
    // Test senaryosunu çalıştıran fonksiyon
    task run_test(input test_number);
        begin
            #5;
            if (alu_result_o === expected_result && alu_flags_o === expected_flags)
                $display("Test %d: PASS", test_number);
            else
                $display("Test %d: FAIL", test_number);
        end
    endtask
    
endmodule
