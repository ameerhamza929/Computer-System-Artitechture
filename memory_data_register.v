`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:49:33 05/08/2024 
// Design Name: 
// Module Name:    memory_data_register 
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
module memory_data_register(input [31:0]data_in,
	input clk,input rst,
	output reg [31:0]mdr_result
    );
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			mdr_result<=0;
		end
		else
			mdr_result<=data_in;
	end

endmodule
