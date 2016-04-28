`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:33 04/21/2016 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
	input[5:0] operation,
    input zero,
    output  PCWre,
    output  ALUSrcB,
    output  ALUM2Reg,
    output  RegWre,
    output  InsMemRW,
    output  DataMemRW,
    output  ExtSel,
    output  PCSrc,
    output  RegOut,
    output[2:0] ALUOp
    );

// Symbolic constants
	parameter ADD = 6'b000000,
			  ADDI = 6'b000001,
			  SUB = 6'b000010,
			  ORI = 6'b010000,
              AND = 6'b010001,
              OR = 6'b010010,
              MOVE = 6'b100000,
              SW = 6'b100110,
              LW = 6'b100111,
              BEQ = 6'b110000,
              HALT = 6'b111111;
	reg i_add, i_addi, i_sub, i_ori, i_and, i_or, i_move, i_sw, i_lw, i_beq, i_halt;

	always@(operation) begin
            i_add = 0;
            i_addi = 0;
            i_sub = 0;
            i_ori = 0;
            i_and = 0;
            i_or = 0;
            i_move = 0;
            i_sw = 0;
            i_lw = 0;
            i_beq = 0;
            i_halt = 0;
            case(operation)
                ADD: i_add = 1;
                ADDI: i_addi = 1;
                SUB: i_sub = 1;
                ORI: i_ori = 1;
                AND: i_and = 1;
                OR: i_or = 1;
                MOVE: i_move = 1;
                SW: i_sw = 1;
                LW: i_lw = 1;
                BEQ: i_beq = 1;
                HALT: i_halt = 1;
            endcase
        end

// Combinational logic of control lines
        assign PCWre = !i_halt;
        assign ALUSrcB = i_addi || i_ori || i_sw || i_lw;
        assign ALUM2Reg = i_lw;
        assign RegWre = !(i_sw || i_halt);
        assign InsMemRW = 0;
        assign DataMemRW = i_sw;
        assign ExtSel = !i_ori;
        assign PCSrc = (i_beq && zero);
        assign RegOut = !(i_addi || i_ori || i_lw);
        assign ALUOp = {i_and, i_ori || i_or, i_sub || i_ori || i_or || i_beq};

        
endmodule
