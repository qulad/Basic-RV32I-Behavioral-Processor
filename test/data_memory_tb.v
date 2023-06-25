`timescale 1ns / 1ps
`include "src/data_memory.v"

module data_memory_tb;

reg clk;
reg reset;
reg mem_write;
reg [1:0] req_size;
reg [31:0] addr;
reg [31:0] data_i;
wire [31:0] data_o;

data_memory dut (
    .clk_i(clk),
    .reset_i(reset),
    .mem_write_i(mem_write),
    .req_size_i(req_size),
    .addr_i(addr),
    .data_i(data_i),
    .data_o(data_o)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock döngüsü

    reset = 1;
    mem_write = 0;
    req_size = 2'b00; // 8-bit
    addr = 0;
    data_i = 32'hAABBCCDD;

    #10 reset = 0;

    // Bellekten okuma testi
    #10 mem_write = 0;
    addr = 0;
    $display("Data Read (8-bit): %h", data_o);
    addr = 1;
    $display("Data Read (8-bit): %h", data_o);
    addr = 2;
    $display("Data Read (8-bit): %h", data_o);

    #10 req_size = 2'b01; // 16-bit
    addr = 0;
    $display("Data Read (16-bit): %h", data_o);
    addr = 1;
    $display("Data Read (16-bit): %h", data_o);
    addr = 2;
    $display("Data Read (16-bit): %h", data_o);

    #10 req_size = 2'b10; // 32-bit
    addr = 0;
    $display("Data Read (32-bit): %h", data_o);
    addr = 1;
    $display("Data Read (32-bit): %h", data_o);
    addr = 2;
    $display("Data Read (32-bit): %h", data_o);

    // Belleğe yazma testi
    #10 mem_write = 1;
    req_size = 2'b00; // 8-bit
    addr = 0;
    data_i = 8'hFF;
    #10;
    addr = 0;
    $display("Data Read (8-bit): %h", data_o);
    addr = 1;
    $display("Data Read (8-bit): %h", data_o);
    addr = 2;
    $display("Data Read (8-bit): %h", data_o);

    #10 req_size = 2'b01; // 16-bit
    addr = 0;
    data_i = 16'hFFFF;
    #10;
    addr = 0;
    $display("Data Read (16-bit): %h", data_o);
    addr = 1;
    $display("Data Read (16-bit): %h", data_o);
    addr = 2;
    $display("Data Read (16-bit): %h", data_o);

    #10 req_size = 2'b10; // 32-bit
    addr = 0;
    data_i = 32'hFFFFFFFF;
    #10;
    addr = 0;
    $display("Data Read (32-bit): %h", data_o);
    addr = 1;
    $display("Data Read (32-bit): %h", data_o);
    addr = 2;
    $display("Data Read (32-bit): %h", data_o);

    #10 $finish;
end

endmodule
