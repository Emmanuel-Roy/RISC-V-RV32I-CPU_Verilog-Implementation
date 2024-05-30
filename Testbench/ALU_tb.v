`timescale 1ns / 1ps

module ALU_tb;
    reg [31:0] instruction;
    reg [31:0] ALUVAL1;
    reg ALUReg;
    reg ALUImmediate;
    reg [31:0] ALUREGVAl2;
    reg [31:0] Iimm;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [31:0] ALUOut;

    ALU uut (
        .instruction(instruction),
        .ALUVAL1(ALUVAL1),
        .ALUReg(ALUReg),
        .ALUImmediate(ALUImmediate),
        .ALUREGVAl2(ALUREGVAl2),
        .Iimm(Iimm),
        .funct3(funct3),
        .funct7(funct7),
        .ALUOut(ALUOut)
    );

    initial begin
        // Initialize
        instruction = 0;
        ALUVAL1 = 32'h00000000;
        ALUReg = 0;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000000;
        Iimm = 32'h00000000;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #5;

        //ADD (ALUVAL1 + ALUREGVAl2) 
        //Expected Output: ALUOut = 32'h00000008
        instruction = 32'h00000000;
        ALUVAL1 = 32'h00000005;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000003;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        
        //SUB (ALUVAL1 - ALUREGVAl2)
        //Expected Output: ALUOut = 32'h00000002
        instruction = 32'h40000000; // funct7[5] = 1
        ALUVAL1 = 32'h00000005;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000003;
        funct3 = 3'b000;
        funct7 = 7'b0100000;
        #10;

        //SLL (ALUVAL2 << shamt)
        //Expected Output: ALUOut = 32'h00000002
        instruction = 32'h00000000;
        ALUVAL1 = 32'h00000000;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000001;
        funct3 = 3'b001;
        funct7 = 7'b0000000;
        #10;

        //SLT ($signed(ALUVAL1) < $signed(ALUVAL2))
        //Expected Output: ALUOut = 32'h00000001
        instruction = 32'h00000000;
        ALUVAL1 = 32'h00000002;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000003;
        funct3 = 3'b010;
        funct7 = 7'b0000000;
        #10;

        //SLTU (ALUVAL1 < ALUVAL2)
        //Expected Output: ALUOut = 32'h00000001
        instruction = 32'h00000000;
        ALUVAL1 = 32'h00000002;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000003;
        funct3 = 3'b011;
        funct7 = 7'b0000000;
        #10;

        //XOR (ALUVAL1 ^ ALUVAL2)
        //Expected Output: ALUOut = 32'h000000FF
        instruction = 32'h00000000;
        ALUVAL1 = 32'h0000000F;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h000000F0;
        funct3 = 3'b100;
        funct7 = 7'b0000000;
        #10;

        //SRL (ALUVAL1 >> shamt)
        //Expected Output: ALUOut = 32'h00000008
        instruction = 32'h00000000;
        ALUVAL1 = 32'h00000010;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000001;
        funct3 = 3'b101;
        funct7 = 7'b0000000;
        #10;

        //SRA ($signed(ALUVAL1) >>> shamt)
        //Expected Output: ALUOut = 32'hC0000008
        instruction = 32'h40000000; 
        ALUVAL1 = 32'h80000010;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h00000001;
        funct3 = 3'b101;
        funct7 = 7'b0100000;
        #10;

        //OR (ALUVAL1 | ALUVAL2)
        //Expected Output: ALUOut = 32'h000000FF
        instruction = 32'h00000000;
        ALUVAL1 = 32'h0000000F;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h000000F0;
        funct3 = 3'b110;
        funct7 = 7'b0000000;
        #10;
        
        //AND (ALUVAL1 & ALUVAL2)
        //Expected Output: ALUOut = 32'h00000000
        instruction = 32'h00000000;
        ALUVAL1 = 32'h0000000F;
        ALUReg = 1;
        ALUImmediate = 0;
        ALUREGVAl2 = 32'h000000F0;
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        #10;

        //ADDI (ALUVAL1 + Iimm)
        //Expected Output: ALUOut = 32'h00000008
        instruction = 32'h00000000;
        ALUVAL1 = 32'h00000005;
        ALUReg = 0;
        ALUImmediate = 1;
        ALUREGVAl2 = 32'h00000000;
        Iimm = 32'h00000003;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $finish;
    end
endmodule
