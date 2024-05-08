module Registers( input clk,input rst,
	input [4:0]rs,
	input [4:0]rt,
	input [4:0]rd,	
	input regdst,
	input regwrite,
	input memtoreg,
	input[31:0] alu_ou_result,
	input[31:0]mdr_result,
	output reg[31:0]rs_data,
	output reg[31:0]rt_data
    );
	reg [31:0] register [9:0];
	
	initial begin
		register[0]=32'b000000_00000_00000_00000_000000_00001;
		register[1]=32'b000000_00000_00000_00000_000000_00010;
		register[2]=32'b000000_00000_00000_00000_000000_00100;
		register[3]=32'b000000_00000_00000_00000_000000_00100;
		register[4]=32'b000000_00000_00000_00000_000000_00100;
	end
	always@(*)begin
		if(rst)begin
			rs_data=0;
			rt_data=0;
		end
		else begin
			rs_data=register[rs];
			rt_data=register[rt];
		end
	end
	
	always@(*)begin
		if(regwrite)begin
			if(regdst)begin
				if(memtoreg)begin
					register[rd]=mdr_result;
				end
				else
					register[rd]=alu_ou_result;
			end
			else begin
				if(memtoreg)begin
					register[rt]=mdr_result;
				end
				else
					register[rt]=alu_ou_result;
			end
		end
	end
	
endmodule
