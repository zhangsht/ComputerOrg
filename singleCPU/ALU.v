`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:05 04/21/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input[31:0] readData1,
    input[31:0] readData2,
    input[31:0] immediate_32,
    input ALUSrcB,
    input[2:0] ALUOp,
    output wire zero,
    output reg[31:0] result
    );
	wire[31:0] aluB;
    
    assign aluB = (ALUSrcB == 0) ? readData2 : immediate_32;

    always@( readData1 or aluB or ALUOp)
	    begin
	        case (ALUOp)
	            3'b000: result <= readData1 + aluB;
	            3'b001: result <= readData1 - aluB;
	            3'b010: result <= aluB - readData1;
	            3'b011: result <= readData1 | aluB;
	            3'b100: result <= readData1 & aluB;
	            3'b101: result <= ~readData1 & aluB;
	            3'b110: result <= readData1 ^ aluB;
	            3'b111: result <= readData1 ~^ aluB;
	        endcase

	    end
    assign zero = (result == 0) ? 1 : 0;

    
endmodule
