`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:51:48 04/21/2016 
// Design Name: 
// Module Name:    Extend 
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
module Extend(
	input[15:0] immediate_16,
    input ExtSel,
    output[31:0] immediate_32
    );
	assign immediate_32 = (ExtSel)? {{16{immediate_16[15]}}, immediate_16[15:0]} : {{16{1'b0}}, immediate_16[15:0]};

	
endmodule
