`timescale 1ns / 1ps

module ALU(
    input wire [31:0] instruction,
    input wire [31:0] ALUVAL1, // Register Source 1 is always used
    
    // Either Register Source two or Iimm
    input wire ALUReg,
    input wire ALUImmediate,
    
    // Bring in both values, we will decide using an if statement.
    input wire [31:0] ALUREGVAl2, // This is the value from register source 2
    input wire [31:0] Iimm,
    
    // Funct3 chooses the operation
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    // ALU Out is sent to the destination register.
    output reg [31:0] ALUOut
);
    reg [31:0] ALUVAL2; // Internal value used for calculation
    wire [4:0] Shift = ALUReg ? ALUREGVAl2[4:0] : instruction[24:20];
    
    always @(*) begin
        if (ALUReg == 1) begin
            ALUVAL2 = ALUREGVAl2;
        end
        else if (ALUImmediate == 1) begin
            ALUVAL2 = Iimm;
        end 
        else begin
            ALUVAL2 = 0; 
        end
        // Determine ALUOut
        case(funct3)
            3'b000: ALUOut = (funct7[5] & instruction[30]) ? (ALUVAL1 - ALUVAL2) : (ALUVAL1 + ALUVAL2);
            3'b001: ALUOut = ALUVAL2 << Shift;
            3'b010: ALUOut = ($signed(ALUVAL1) < $signed(ALUVAL2)) ? 32'b1 : 32'b0;
            3'b011: ALUOut = (ALUVAL1 < ALUVAL2) ? 32'b1 : 32'b0;
            3'b100: ALUOut = (ALUVAL1 ^ ALUVAL2);
            3'b101: ALUOut = funct7[5] ? ($signed(ALUVAL1) >>> Shift) : (ALUVAL1 >> Shift); //Seems to have issues with the 31st bit.
            3'b110: ALUOut = (ALUVAL1 | ALUVAL2);
            3'b111: ALUOut = (ALUVAL1 & ALUVAL2);
            default: ALUOut = 32'b0; //In case something goes wrong.
        endcase
    end
endmodule