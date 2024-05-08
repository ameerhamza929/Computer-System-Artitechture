`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:55:16 05/05/2024
// Design Name:   Integration
// Module Name:   D:/csa/fsm/integration_tb.v
// Project Name:  fsm
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Integration
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module integration_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] instruction;
	wire [31:0] data_in;
	wire [31:0] data_out;
	wire [31:0] pc_out;
	wire [31:0] jump_address;
	wire [5:0] opcode;
	wire PCWrite;
	wire IorD;
	wire MemWrite;
	wire IRWrite;
	wire ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [1:0] ALUOp;
	wire MemtoReg;
	wire RegWrite;
	wire RegDst;
	wire PCWriteCond;
	wire MemRead;
	wire [1:0] PCSource;
	wire Branch;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	wire[31:0]alu_result;

	// Instantiate the Unit Under Test (UUT)
	Integration uut (
		.clk(clk), 
		.rst(rst), 
		.instruction(instruction), 
		.data_in(data_in), 
		.data_out(data_out), 
		.pc_out(pc_out), 
		.jump_address(jump_address), 
		.opcode(opcode), 
		.PCWrite(PCWrite), 
		.IorD(IorD), 
		.MemWrite(MemWrite), 
		.IRWrite(IRWrite), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.ALUOp(ALUOp), 
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.RegDst(RegDst), 
		.PCWriteCond(PCWriteCond), 
		.MemRead(MemRead), 
		.PCSource(PCSource), 
		.Branch(Branch), 
		.rs(rs), 
		.rt(rt), 
		.rd(rd),
		.alu_result(alu_result)
	);
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end

	initial begin
		// Initialize Inputs
	
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst=0;
		
        
		// Add stimulus here

	end
      
endmodule

