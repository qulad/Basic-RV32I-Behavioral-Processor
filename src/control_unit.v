module control_unit(
    input [31:0] instruction_i,

    // Input Flags
    input [2:0] AluFlags_i, // [0]->Negative, [1]->Zero, [2]->oVerflow, [3]->Carry

    output reg [19:0] imm_20_o,
    output reg [11:0] imm_12_o,
    output reg [4:0] A1_o,
    output reg [4:0] A2_o,
    output reg [4:0] A3_o,
    // Output Flags
    output reg PcSrc_o,
    output reg [2:0] ResultSrc_o,
    output reg MemWrite_o,
    output reg [1:0] ReqSize_o, // 00->7:0, 01->15:0, 10->31:0
    output reg [2:0] AluControl_o,
    output reg AluSign_o, // 0->Signed, 1->Unsigned
    output reg AluSrc_o,
    output reg [1:0] ImmSrc_o,
    output reg RegWrite_o,

    output reg [31:0] ControlLogic_o
);
    reg [11:0] imm12;
    reg [19:0] imm20;
    always @(*) begin
        // R Type
        if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b000) && (instruction_i[6:0] == 7'b0110011)) begin // add
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b1000000) && (instruction_i[14:12] == 3'b000) && (instruction_i[6:0] == 7'b0110011)) begin // sub
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b001) && (instruction_i[6:0] == 7'b0110011)) begin // sll
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b111;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b010) && (instruction_i[6:0] == 7'b0110011)) begin // slt
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            ResultSrc_o = 3'b100;
            if (AluFlags_i[0] == 1'b1)
                ControlLogic_o <= 32'd1;
            else
                ControlLogic_o = 32'd0;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b011) && (instruction_i[6:0] == 7'b0110011)) begin // sltu
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b1;
            AluControl_o = 3'b001;
            ResultSrc_o = 3'b100;
            if (AluFlags_i[0] == 1'b1)
                ControlLogic_o = 32'd1;
            else
                ControlLogic_o = 32'd0;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b100) && (instruction_i[6:0] == 7'b0110011)) begin // xor
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b011;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b101) && (instruction_i[6:0] == 7'b0110011)) begin // srl
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b110;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b1000000) && (instruction_i[14:12] == 3'b101) && (instruction_i[6:0] == 7'b0110011)) begin // sra
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b100;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b110) && (instruction_i[6:0] == 7'b0110011)) begin // or
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b1;
            AluControl_o = 3'b010;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b111) && (instruction_i[6:0] == 7'b0110011)) begin // and
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b010;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b001) && (instruction_i[6:0] == 7'b0010011)) begin // slli
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b111;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b101) && (instruction_i[6:0] == 7'b0010011)) begin // srli
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b110;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[31:25] == 7'b0000000) && (instruction_i[14:12] == 3'b101) && (instruction_i[6:0] == 7'b0010011)) begin // srai
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b100;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        
        // I Type
        else if ((instruction_i[14:12] == 3'b000) && (instruction_i[6:0] == 7'b0000011)) begin // lb
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ReqSize_o = 2'b00;
            ResultSrc_o = 3'b001;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b001) && (instruction_i[6:0] == 7'b0000011)) begin // lh
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ReqSize_o = 2'b01;
            ResultSrc_o = 3'b001;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b010) && (instruction_i[6:0] == 7'b0000011)) begin // lw
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ReqSize_o = 2'b10;
            ResultSrc_o = 3'b001;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b100) && (instruction_i[6:0] == 7'b0000011)) begin // lbu
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b000;
            ReqSize_o = 2'b00;
            ResultSrc_o = 3'b001;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b101) && (instruction_i[6:0] == 7'b0000011)) begin // lhu
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b000;
            ReqSize_o = 2'b01;
            ResultSrc_o = 3'b001;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b000) && (instruction_i[6:0] == 7'b0010011)) begin // addi
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b010) && (instruction_i[6:0] == 7'b0010011)) begin // slti
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            ResultSrc_o = 3'b100;
            if (AluFlags_i[0] == 1'b1)
                ControlLogic_o = 32'd1;
            else
                ControlLogic_o = 32'd0;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b011) && (instruction_i[6:0] == 7'b0010011)) begin // sltiu
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b001;
            ResultSrc_o = 3'b100;
            if (AluFlags_i[0] == 1'b1)
                ControlLogic_o = 32'd1;
            else
                ControlLogic_o = 32'd0;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b100) && (instruction_i[6:0] == 7'b0010011)) begin // xori
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b011;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b110) && (instruction_i[6:0] == 7'b0010011)) begin // ori
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b1;
            AluControl_o = 3'b010;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if ((instruction_i[14:12] == 3'b111) && (instruction_i[6:0] == 7'b0010011)) begin // andi
            A1_o = instruction_i[19:15];
            A3_o = instruction_i[11:7];
            PcSrc_o = 1'b0;
            imm_12_o = instruction_i[31:20];
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b010;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end

        // S Type
        else if ((instruction_i[14:12] == 3'b000) && (instruction_i[6:0] == 7'b0100011)) begin // sb
            // Build imm
            imm12 = 12'd0;
            imm12[11:5] = instruction_i[31:25];
            imm12[4:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            PcSrc_o = 1'b0;
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            MemWrite_o = 1'b1;
            ReqSize_o = 2'b00;
        end
        else if ((instruction_i[14:12] == 3'b001) && (instruction_i[6:0] == 7'b0100011)) begin // sh
            // Build imm
            imm12 = 12'd0;
            imm12[11:5] = instruction_i[31:25];
            imm12[4:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            PcSrc_o = 1'b0;
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            MemWrite_o = 1'b1;
            ReqSize_o = 2'b01;
        end
        else if ((instruction_i[14:12] == 3'b010) && (instruction_i[6:0] == 7'b0100011)) begin // sw
            // Build imm
            imm12 = 12'd0;
            imm12[11:5] = instruction_i[31:25];
            imm12[4:0] = instruction_i[11:7];
            // Set flags
            PcSrc_o = 1'b0;
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            MemWrite_o = 1'b1;
            ReqSize_o = 2'b10;
        end
        
        // B Type
        else if ((instruction_i[14:12] == 3'b000) && (instruction_i[6:0] == 7'b1100011)) begin // beq
            // Build imm
            imm12 = 12'd0;
            imm12[11] = instruction_i[31];
            imm12[10] = instruction_i[7];
            imm12[9:4] = instruction_i[30:25];
            imm12[3:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            if (AluFlags_i[1] == 1'b1)
                PcSrc_o = 1'b1;
            else
                PcSrc_o = 1'b0;
        end
        else if ((instruction_i[14:12] == 3'b001) && (instruction_i[6:0] == 7'b1100011)) begin // bne
            // Build imm
            imm12 = 12'd0;
            imm12[11] = instruction_i[31];
            imm12[10] = instruction_i[7];
            imm12[9:4] = instruction_i[30:25];
            imm12[3:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            if (AluFlags_i[1] == 1'b0)
                PcSrc_o = 1'b1;
            else
                PcSrc_o = 1'b0;
        end
        else if ((instruction_i[14:12] == 3'b100) && (instruction_i[6:0] == 7'b1100011)) begin // blt
            // Build imm
            imm12 = 12'd0;
            imm12[11] = instruction_i[31];
            imm12[10] = instruction_i[7];
            imm12[9:4] = instruction_i[30:25];
            imm12[3:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            if (AluFlags_i[0] == 1'b1)
                PcSrc_o = 1'b1;
            else
                PcSrc_o = 1'b0;
        end
        else if ((instruction_i[14:12] == 3'b101) && (instruction_i[6:0] == 7'b1100011)) begin // bge
            // Build imm
            imm12 = 12'd0;
            imm12[11] = instruction_i[31];
            imm12[10] = instruction_i[7];
            imm12[9:4] = instruction_i[30:25];
            imm12[3:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b0;
            AluControl_o = 3'b001;
            if (AluFlags_i[0] == 1'b0)
                PcSrc_o = 1'b1;
            else
                PcSrc_o = 1'b0;
        end
        else if ((instruction_i[14:12] == 3'b110) && (instruction_i[6:0] == 7'b1100011)) begin // bltu
            // Build imm
            imm12 = 12'd0;
            imm12[11] = instruction_i[31];
            imm12[10] = instruction_i[7];
            imm12[9:4] = instruction_i[30:25];
            imm12[3:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b1;
            AluControl_o = 3'b001;
            if (AluFlags_i[0] == 1'b1)
                PcSrc_o = 1'b1;
            else
                PcSrc_o = 1'b0;
        end
        else if ((instruction_i[14:12] == 3'b111) && (instruction_i[6:0] == 7'b1100011)) begin // bgeu
            // Build imm
            imm12 = 12'd0;
            imm12[11] = instruction_i[31];
            imm12[10] = instruction_i[7];
            imm12[9:4] = instruction_i[30:25];
            imm12[3:0] = instruction_i[11:7];
            // Set flags
            A1_o = instruction_i[19:15];
            A2_o = instruction_i[24:20];
            imm_12_o = imm12;
            ImmSrc_o = 2'b11;
            AluSrc_o = 1'b0;
            AluSign_o = 1'b1;
            AluControl_o = 3'b001;
            if (AluFlags_i[0] == 1'b0)
                PcSrc_o = 1'b1;
            else
                PcSrc_o = 1'b0;
        end
        
        // J Type
        else if (instruction_i[6:0] == 7'b1101111) begin // jal
            // Build imm
            imm20 = 20'd0;
            imm20[19] = instruction_i[31];
            imm20[18:11] = instruction_i[19:12];
            imm20[10] = instruction_i[20];
            imm20[9:0] = instruction_i[30:21];
            // Set flags
            PcSrc_o = 1'b1;
            A1_o = 5'b00000;
            A3_o = instruction_i[11:7];
            ImmSrc_o = 2'b00;
            imm_20_o = imm20;
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ResultSrc_o = 3'b011;
            RegWrite_o = 1'b1;
        end

        // U Type
        else if (instruction_i[6:0] == 7'b0110111) begin // lui
            PcSrc_o = 1'b0;
            ImmSrc_o = 2'b00;
            imm_20_o = instruction_i[31:12];
            A1_o = 5'b00000;
            A3_o = instruction_i[11:7];
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end
        else if (instruction_i[6:0] == 7'b0010111) begin // auipc
            PcSrc_o = 1'b1;
            ImmSrc_o = 2'b00;
            imm_20_o = instruction_i[31:12];
            A1_o = 5'b00000;
            A3_o = instruction_i[11:7];
            AluSrc_o = 1'b1;
            AluSign_o = 1'b0;
            AluControl_o = 3'b000;
            ResultSrc_o = 3'b000;
            RegWrite_o = 1'b1;
        end

        else begin // Invalid Instruction
        end
    end
endmodule
