`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module memory
(	input [31:0]pc_address,
	input [4:0]alu_address, 
	input [31:0]data_in, 
	output reg [31:0] data_out,  
	input clk,
	input rst, 
	input we,
	input IorD,
	input memread); 

	reg [31:0] mem_memory [9:0];
	

	
	initial begin
		mem_memory [0] = 32'b000000_00001_00010_00011_000000_00010; //add $1, $2, $3
		mem_memory [1] = 32'b001000_00000_00000_00000_000000_00011;
		mem_memory [2] = 32'b000000_00001_00010_00011_000000_00010;
		mem_memory [3] = 32'b000000_00001_00010_00011_000000_10000;
		
	end
	
	
	
	always@(posedge clk) begin
		if(we)begin
				mem_memory[alu_address]<=data_in;			
			end
	end
	always @(*)begin
		if(rst)begin
			data_out=0;
		end
		else begin
			if(memread)begin
				if(!IorD)begin
					data_out=mem_memory [pc_address] ; 
				end	
				else
					data_out=mem_memory [alu_address] ;
			end	
		end		
	end
endmodule 
