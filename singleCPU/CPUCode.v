`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:37:14 04/20/2016 
// Design Name: 
// Module Name:    CPUCode 
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
module CPUCode ();

//	Instruction section
    wire [31:0] instruction;
	wire [5:0] operation;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] immediate_16;
    wire [31:0] immediate_32;

//Clock cycle and PC
    reg clk;
    reg [31:0] PC;

//Operational Results
    wire [31:0] result;
    wire [31:0] write_data;

//Control signal line
    wire PCWre;
    wire ALUSrcB;
    wire ALUM2Reg;
    wire RegWre;
    wire InsMemRW;
    wire DataMemRW;
    wire ExtSel;
    wire PCSrc;
    wire RegOut;
    wire [2:0] ALUOp;
    wire [31:0] readData1;
    wire [31:0] readData2;
    wire zero;
	
	initial
		begin
		    PC = 0;
		    clk = 0;
	    end
   always #500
        clk = ~clk;
	
	InstructionMemory instructionMemory(PC, instruction);
	
	// Decomposition instruction
	assign operation[5:0] = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign immediate_16 = instruction[15:0];

	ControlUnit controlUnit(operation, zero, PCWre, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, DataMemRW, ExtSel, PCSrc, RegOut,ALUOp);

	RegisterSet registerSet(rs, rt, rd, write_data, RegWre, RegOut,clk,readData1,readData2);

	Extend extend(immediate_16, ExtSel, immediate_32);

	ALU alu(readData1, readData2, immediate_32, ALUSrcB, ALUOp, zero, result);

	DataMemory dataMemory(result, readData2, DataMemRW, ALUM2Reg, write_data);
	
	always@(posedge clk)
		begin
		   if  ( PCWre == 1)
		     PC <= (PCSrc == 0)? PC + 4 : PC + 4 + immediate_32 * 4;
		   else 
		     PC <= PC;
		end

	
endmodule
