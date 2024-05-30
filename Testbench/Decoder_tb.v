`timescale 1ns / 1ps

module Decoder_tb;

reg [31:0] instruction;
wire ALUReg;
wire ALUImmediate;
wire Branch;
wire JALR;
wire JAL;
wire AUIPC;
wire LUI;
wire Load;
wire Store;
wire System;
wire [4:0] SourceRegister1;
wire [4:0] SourceRegister2;
wire [4:0] DestinationRegister;
wire [2:0] funct3;
wire [6:0] funct7;
wire [31:0] Iimm;
wire [31:0] Simm;
wire [31:0] Bimm;
wire [31:0] Uimm;
wire [31:0] Jimm;

Decoder uut (
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

// Test sequence
initial begin
    // Test case 1 (ADD x1, x0, x0)
    instruction = 32'b0000000_00000_00000_000_00001_0110011;
    #10; 
    
    // Test case 2 (ADDI x1, x1, 1)
    instruction = 32'b000000000001_00001_000_00001_0010011;
    #10; 

    // Finish the simulation
    $finish;
end

endmodule