`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:12:20 04/21/2016 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory(
	input[31:0] result,
    input[31:0] readData2,
    input DataMemRW,
    input ALUM2Reg,
    output[31:0] write_data
    );

	reg[31:0] DataMem [0:63];
    reg[31:0] DataOut;
    
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            DataMem[i] = 0;
    end

    always@(result or DataMemRW) 
	    begin
	        if (DataMemRW == 0)
	            DataOut = DataMem[result];
	        else
	            DataMem[result] = readData2;
	    end
    
     assign write_data = (ALUM2Reg == 0) ? result : DataOut;


endmodule
