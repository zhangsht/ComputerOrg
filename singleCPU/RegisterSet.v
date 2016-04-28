`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:38 04/21/2016 
// Design Name: 
// Module Name:    RegisterSet 
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
module RegisterSet(
	input[4:0]   rs,rt,rd,
    input[31:0] write_data,
    input       RegWre,RegOut,clk,  
    output[31:0] readData1,readData2
	);
	
	wire[4:0] addr;
    assign addr = (RegOut == 0) ? rt : rd;

    reg[31:0]  register [1:31];
    integer i;
    initial
	    begin
	      for (i = 0; i < 32; i = i + 1)
	        register[i] = 0;
	    end

    assign readData1 = (rs == 0)? 0 : register[rs]; 
    assign readData2 = (rt == 0)? 0 : register[rt]; 

    always @(posedge clk) 
	    begin
            if ((addr != 0) && (RegWre == 1))
            	register[addr] <= write_data;
	    end


endmodule
