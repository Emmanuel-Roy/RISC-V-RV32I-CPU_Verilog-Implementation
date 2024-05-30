`timescale 1ns / 1ps

module SOC(
    //Basic Inputs
    input wire clk,
    input wire reset
);
    // PC, NextPC, and Instruction Processing
    reg [31:0] PC;
    wire [31:0] nextPC;
    wire [31:0] instruction;

    // Loads a potential max of 256 instructions, feel free to add more or less memory spoace
    reg [31:0] InstructionMemory [0:255];  
    
    //This is used for the load and store commands, other than that its just normal memory.
    reg [31:0] SystemMemory [0:255];  
    
    // The RISC-V ISA has 32 Registers by default.
    reg [31:0] Registers [0:31]; 
   
    //This is the area that gets the data from the registers the instructions ask for.
    wire [31:0] REGData1;
    wire [31:0] REGData2;

    // ALU wires
    wire [31:0] ALUOut;
    wire TakeBranch;

    // These are the control signals given by the decoder
    wire ALUReg, ALUImmediate, Branch, JALR, JAL, AUIPC, LUI, Load, Store, System;
    wire [4:0] SourceRegister1, SourceRegister2, DestinationRegister;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [31:0] Iimm, Simm, Bimm, Uimm, Jimm;

    // Initialize instructions, registers, and memories.
    initial begin
        //Write Path to instruction file.
        $readmemh("E:/CPU/instructions.hex", InstructionMemory);
        Registers[0] = 0;  
        SystemMemory[0] = 0;  
    end

    //Fetch Instruction
    assign instruction = InstructionMemory[PC[9:2]];  //[9:2] used because that is the size of a word, plus MSB stuff.

    // Decoder
    Decoder decoder(
        .instruction(instruction),
        .ALUReg(ALUReg),
        .ALUImmediate(ALUImmediate),
        .Branch(Branch),
        .JALR(JALR),
        .JAL(JAL),
        .AUIPC(AUIPC),
        .LUI(LUI),
        .Load(Load),
        .Store(Store),
        .System(System),
        .SourceRegister1(SourceRegister1),
        .SourceRegister2(SourceRegister2),
        .DestinationRegister(DestinationRegister),
        .funct3(funct3),
        .funct7(funct7),
        .Iimm(Iimm),
        .Simm(Simm),
        .Bimm(Bimm),
        .Uimm(Uimm),
        .Jimm(Jimm)
    );

    // Read Register values.
    assign REGData1 = Registers[SourceRegister1];
    assign REGData2 = Registers[SourceRegister2];

    // ALU
    ALU alu(
        .instruction(instruction),
        .ALUVAL1(REGData1),
        .ALUReg(ALUReg),
        .ALUImmediate(ALUImmediate),
        .ALUREGVAl2(REGData2),
        .Iimm(Iimm),
        .funct3(funct3),
        .funct7(funct7),
        .ALUOut(ALUOut)
    );

    // Branch logic
    assign TakeBranch = (Branch && (
        (funct3 == 3'b000 && REGData1 == REGData2) ||   
        (funct3 == 3'b001 && REGData1 != REGData2) ||   
        (funct3 == 3'b100 && $signed(REGData1) < $signed(REGData2)) || 
        (funct3 == 3'b101 && $signed(REGData1) >= $signed(REGData2)) || 
        (funct3 == 3'b110 && REGData1 < REGData2) ||    
        (funct3 == 3'b111 && REGData1 >= REGData2)     
    ));

    // Next PC calculation
    wire [31:0] PC4 = PC + 4;
    wire [31:0] PCBimm = PC + Bimm;
    assign nextPC = (TakeBranch) ? PCBimm : (JAL ? (PC + Jimm) : (JALR ? (ALUOut & ~1) : PC4));

    // Write back and update PC.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0;
        end 
        
        else begin
            // Update PC
            PC <= nextPC;
            
            // Write back 
            if (LUI) begin
                Registers[DestinationRegister] <= Uimm;
            end 
            
            else if (AUIPC) begin
                Registers[DestinationRegister] <= PC + Uimm;
            end 
            
            else if (Load) begin
                Registers[DestinationRegister] <= SystemMemory[ALUOut[9:2]];
            end 
            
            else if (Store) begin
                SystemMemory[ALUOut[9:2]] <= REGData2;
            end 
            
            else if (ALUReg || ALUImmediate) begin
                Registers[DestinationRegister] <= ALUOut;
            end 
            
            else if (JAL || JALR) begin
                Registers[DestinationRegister] <= PC + 4;
            end
            
        end
    end

endmodule