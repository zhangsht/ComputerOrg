`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:27 04/21/2016 
// Design Name: 
// Module Name:    InstructionMemory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module InstructionMemory(input [31:0] PC, output reg [31:0] instruction);
	reg[31:0] instructionInput[0:64];
    initial
	    begin
	        $readmemb("text.txt", instructionInput);
	    end

//get the next instruction changed with PC
    always @(PC)
    	begin
            instruction <= instructionInput[PC >> 2];
        end


endmodule
