`timescale 1ns / 1ps

module Decoder(
    input wire [31:0] instruction,
    //ISA Opcodes
    output wire  ALUReg, //alu operation based on register
    output wire  ALUImmediate, // alu operation based on immediate
    output wire  Branch, //Branch based on immediate
    output wire  JALR, //Jump based on register
    output wire  JAL,//Jump pased on immediate 
    output wire  AUIPC, //Load val of PC plus immediate into destination reg.
    output wire  LUI, //Stores immediate into register
    output wire  Load, //Stores the memory at register plus immediate to destination reg
    output wire  Store, //Stores into location register + immediate the value of register 2.
    output wire  System, //Not used right now, could be used for ecall and ebreak implemntation later.
    
    //Get Registers based on instruction
   output wire  [4:0] SourceRegister1, //rs1 in ISA
   output wire  [4:0] SourceRegister2, //rs2 in ISA
   output wire  [4:0] DestinationRegister, //rd in ISA
   
   //Used for alu and such operations
   output wire  [2:0] funct3,
   output wire  [6:0] funct7,
   
   //Immediate Value types 
   //We don't need an immediate for Register Register Interactions
   output wire  [31:0] Iimm, //Register-Immediate ALU 
   output wire  [31:0] Simm, //Store Immediate
   output wire  [31:0] Bimm, //Branch Immediate
   output wire  [31:0] Uimm, //LUI/AUIPC Immediates
   output wire  [31:0] Jimm  //Jump Immiedates
);


    //Check which opcode the instruction belongs to. (Set val to 1 if that is the opcode)
    assign ALUReg = (instruction[6:0] == 7'b0110011); 
    assign ALUImmediate = (instruction[6:0] == 7'b0010011); 
    assign Branch = (instruction[6:0] == 7'b1100011); 
    assign JALR = (instruction[6:0] == 7'b1100111); 
    assign JAL = (instruction[6:0] == 7'b1101111); 
    assign AUIPC = (instruction[6:0] == 7'b0010111);
    assign LUI = (instruction[6:0] == 7'b0110111); 
    assign Load = (instruction[6:0] == 7'b0000011); 
    assign Store = (instruction[6:0] == 7'b0100011); 
    assign System = (instruction[6:0] == 7'b1110011); 
    
    //Get Source Resigters.
    assign SourceRegister1 = instruction[19:15];
    assign SourceRegister2 = instruction[24:20];
    assign DestinationRegister  = instruction[11:7];
    
    //Get funct3 and funct7
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    //Get Immediates
    assign Iimm = {{21{instruction[31]}},instruction[30:20]};
    assign Simm = {{21{instruction[31]}},instruction[30:25],instruction[11:7]};
    assign Bimm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    assign Uimm = {instruction[31],instruction[30:12],12'b0};
    assign Jimm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:21],1'b0};    
    
endmodule
