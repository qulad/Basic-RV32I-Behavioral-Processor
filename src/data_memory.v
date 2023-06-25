module data_memory(
    input clk_i,
    input reset_i,
    input mem_write_i,
    input [1:0] req_size_i, // 00->7:0, 01->15:0, 10->31:0
    input [31:0] addr_i,
    input [31:0] data_i,
    output reg [31:0] data_o
);

reg [31:0] mem[0:31]; // Bellek tanımı, 32 adres alanı için

always @(posedge clk_i or posedge reset_i) begin
    if (reset_i) begin
        for (integer i = 0; i < 32; i = i + 1) begin
            mem[i] <= 32'h00000000; // Belleği sıfırlama
        end
    end else begin
        if (mem_write_i) begin // Belleğe yazma
            case (req_size_i)
                2'b00: mem[addr_i] <= {24'h000000, data_i[7:0]};
                2'b01: mem[addr_i] <= {16'h0000, data_i[15:0]};
                2'b10: mem[addr_i] <= data_i;
                default: mem[addr_i] <= 32'h00000000; // Hata durumu için
            endcase
        end else begin // Bellekten okuma
            case (req_size_i)
                2'b00: data_o <= {24'h000000, mem[addr_i][7:0]};
                2'b01: data_o <= {16'h0000, mem[addr_i][15:0]};
                2'b10: data_o <= mem[addr_i];
                default: data_o <= 32'h00000000; // Hata durumu için
            endcase
        end
    end
end

endmodule
