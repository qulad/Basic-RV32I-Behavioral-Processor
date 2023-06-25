`include "src/alu_src_mux.v"
`include "src/alu.v"
`include "src/control_unit.v"
`include "src/data_memory.v"
`include "src/extender.v"
`include "src/instruction_memory.v"
`include "src/pc_plus_4.v"
`include "src/pc_src_mux.v"
`include "src/pc_target.v"
`include "src/program_counter.v"
`include "src/register_file.v"
`include "src/result_src_mux.v"

module processor(
    input clk_i,
    input reset_i
);
    wire [31:0] w_pc_next;
    pc_src_mux d1 (
        .pc_src_i(w_pc_src),
        .zero_i(w_pc_plus_4),
        .one_i(w_pc_target),
        .pc_src_o(w_pc_next)
    );
    wire [31:0] w_pc;
    program_counter d2 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .pc_next_i(w_pc_next),
        .pc_o(w_pc)
    );
    wire [31:0] w_instruction;
    instruction_memory d3 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .addr_i(w_pc),
        .instruction_o(w_instruction)
    );
    wire [31:0] w_pc_plus_4;
    pc_plus_4 d4 (
        .instruction_i(w_pc),
        .instruction_o(w_pc_plus_4)
    );
    wire [19:0] w_imm_20;
    wire [11:0] w_imm_12;
    wire [4:0] w_a1, w_a2, w_a3;
    wire w_pc_src, w_mem_write, w_alu_sign, w_alu_src, w_reg_write;
    wire [1:0] w_req_size, w_imm_src;
    wire [2:0] w_result_src, w_alu_control;
    wire [31:0] w_control_logic;
    control_unit d5 (
        .instruction_i(w_instruction),
        .AluFlags_i(w_alu_flags),
        .imm_20_o(w_imm_20),
        .imm_12_o(w_imm_12),
        .A1_o(w_a1),
        .A2_o(w_a2),
        .A3_o(w_a3),
        .PcSrc_o(w_pc_src),
        .ResultSrc_o(w_result_src),
        .MemWrite_o(w_mem_write),
        .ReqSize_o(w_req_size),
        .AluControl_o(w_alu_control),
        .AluSign_o(w_alu_sign),
        .AluSrc_o(w_alu_src),
        .ImmSrc_o(w_imm_src),
        .RegWrite_o(w_reg_write),
        .ControlLogic_o(w_control_logic)
    );
    wire [31:0] w_rd1, w_rd2;
    register_file d6 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .we3_i(w_reg_write),
        .a1_i(w_a1),
        .a2_i(w_a2),
        .a3_i(w_a3),
        .wd3_i(w_write_data),
        .rd1_o(w_rd1),
        .rd2_o(w_rd2)
    );
    wire [31:0] w_extended;
    extender d7 (
        .extend_i(w_imm_src),
        .u_type_i(w_imm_20), // 20 bits
        .j_type_i(), // 9 bits
        .b_type_i(), // 13 bits
        .i_and_s_type_i(w_imm_12), // 12 bits
        .extended_o(w_extended)
    );
    wire [31:0] w_pc_target;
    pc_target d8 (
        .pc_i(w_pc),
        .offset_i(w_extended),
        .instruction_o(w_pc_target)
    );
    wire [31:0] w_src_b;
    alu_src_mux d9 (
        .alu_src_i(w_alu_src),
        .rd2_i(w_rd2),
        .extended_i(w_extended),
        .src_b_o(w_src_b)
    );
    wire [31:0] w_alu_result;
    wire [2:0] w_alu_flags;
    alu d10 (
        .src_a_i(w_rd1),
        .src_b_i(w_src_b),
        .alu_sign_i(w_alu_sign),
        .alu_control_i(w_alu_control),
        .alu_result_o(w_alu_result),
        .alu_flags_o(w_alu_flags)
    );
    wire [31:0] w_read_data;
    data_memory d11 (
        .clk_i(clk_i),
        .reset_i(reset_i),
        .mem_write_i(w_mem_write),
        .req_size_i(w_req_size),
        .addr_i(w_alu_result),
        .data_i(w_rd2),
        .data_o(w_read_data)
    );
    wire [31:0] w_write_data;
    result_src_mux d12 (
        .result_src_flag_i(w_result_src),
        .alu_result_i(w_alu_result),
        .read_data_i(w_read_data),
        .extended_i(w_extended),
        .pc_plus_4_i(w_pc_plus_4),
        .comp_i(w_control_logic),
        .result_o(w_write_data)
    );
endmodule
