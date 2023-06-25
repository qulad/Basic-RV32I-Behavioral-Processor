`timescale 1ns / 1ps
`include "src/instruction_memory.v"

module instruction_memory_tb;
    reg clk;
    reg rst;
    reg [31:0] addr;
    wire [31:0] instruction;
    
    instruction_memory dut (
        .clk_i(clk),
        .reset_i(rst),
        .addr_i(addr),
        .instruction_o(instruction)
    );

    initial begin
        clk = 0;
        rst = 1;
        addr = 0;
        
        #10 rst = 0; // Reseti kaldır
        
        // İlk boot işlemi
        #10 addr = 0;
        #10 addr = 1;
        
        // Normal adres erişimi
        #10 addr = 2;
        #10 addr = 3;
        
        // Test durumu değerlendirme
        if (instruction == 32'h01234567) begin
            $display("PASS");
        end else begin
            $display("FAIL");
            $display(instruction);
        end
        
        // Simülasyon sonlandırma
        #10 $finish;
    end

    always begin
        #5 clk = ~clk;
    end
endmodule
