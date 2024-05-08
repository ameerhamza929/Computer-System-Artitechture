`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:30:03 05/08/2024 
// Design Name: 
// Module Name:    ALUreg 
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
module ALUreg(input[31:0]alu_result,
	input clk,input rst,
	output reg[31:0]alu_ou_result
    );
	always@(posedge clk or posedge rst)begin
		if(rst)
			alu_ou_result<=0;
		else
			alu_ou_result<=alu_result;
	end


endmodule
