`timescale 1ns / 1ps

module SOC_tb;
    reg clk;
    reg reset;

    SOC uut (
        .clk(clk),
        .reset(reset)
    );
    
    
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10;
        //Wait for reset and start running instructions
        reset = 0;
        #200;
        $stop;
    end

    // Output PC and Reg File Updates.
    always @(posedge clk) begin
        $display("PC = %h, Register 1 = %h, Register 2 = %h, Register 3 = %h, Register 4 = %h, Register 5 = %h",
                 uut.PC, uut.Registers[1], uut.Registers[2], uut.Registers[3], uut.Registers[4], uut.Registers[5]);
    end

endmodule
