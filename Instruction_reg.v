`timescale 1ns / 1ps

module Integration(input clk,
	 input rst,
	 output [31:0]instruction,
	 output [31:0]data_in,
	  output [31:0]data_out,
	 output [31:0]pc_out,
	 output [31:0]jump_address,
	 output [5:0] opcode,
    output PCWrite,
    output IorD,
    output MemWrite,
    output IRWrite,
    output ALUSrcA,
    output [1:0] ALUSrcB,
    output [1:0] ALUOp,
    output MemtoReg,
    output RegWrite,
    output RegDst,
    output PCWriteCond,
    output MemRead,
    output [1:0] PCSource,
    output Branch,
	 output [4:0]rs,
	 output [4:0]rt,
	 output [4:0]rd,
	 output [31:0]alu_result
	 
 );
 	wire [5:0]func;
	wire [31:0]signextend;
	wire [31:0]rs_data;
	wire [31:0]rt_data;
	 wire [31:0]mdr_result;
	 wire [31:0]A_out;
	  wire [31:0]B_out;
	  wire [31:0]alu_ou_result;
	   wire[3:0]alu_control;
	 wire zero;

// Instantiate the module
PC pc (
    .clk(clk), 
    .rst(rst), 
    .jump_address(jump_address),
    .pc_source(PCSource), 
    .pcwrite(PCWrite), 
    .pc_out(pc_out)
    );
memory mem (
    .pc_address(pc_out), 
    .alu_address(rd), 
    .data_in(alu_ou_result), 
    .data_out(data_out), 
    .clk(clk), 
    .rst(rst), 
    .we(MemWrite), 
    .IorD(IorD), 
    .memread(MemRead)
    );

	
	Instruction_reg IR (
    .instruction(data_out), 
    .IRwrite(IRWrite), 
    .clk(clk), 
    .rst(rst), 
    .opcode(opcode), 
    .func(func), 
    .jump_address(jump_address), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .signextend(signextend)
    );
	
	 memory_data_register mdr (
    .data_in(data_out), 
    .clk(clk), 
    .rst(rst), 
    .mdr_result(mdr_result)
    );
	 
	 controlunit control (
    .clk(clk), 
    .rst(rst), 
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
    .Branch(Branch)
    );
	
	
	Registers registermem (
    .clk(clk), 
    .rst(rst), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .regdst(RegDst), 
    .regwrite(RegWrite), 
    .memtoreg(MemtoReg), 
    .alu_ou_result(alu_ou_result), 
    .mdr_result(mdr_result), 
    .rs_data(rs_data), 
    .rt_data(rt_data)
    );
	 
	 registerA Areg (
    .clk(clk), 
    .rst(rst), 
    .rs_data(rs_data), 
    .A_out(A_out)
    );
	
	 registerB Breg (
    .clk(clk), 
    .rst(rst), 
    .rt_data(rt_data), 
    .B_out(B_out)
    );
	
	Alu_Control alu_cont(
    .clk(clk), 
    .rst(rst), 
    .func(func), 
    .alu_op(ALUOp), 
    .alu_control(alu_control)
    );
	
	ALU alu (
    .alu_result(alu_result), 
    .zero(zero), 
	 .clk(clk),
    .inputA(A_out), 
    .inputB(B_out), 
    .signextend(signextend), 
    .pc(pc_out), 
    .alu_control(alu_control), 
    .alu_src_A(ALUSrcA), 
    .alu_src_B(ALUSrcB)
    );
	 ALUreg alureg (
    .alu_result(alu_result), 
    .clk(clk), 
    .rst(rst), 
    .alu_ou_result(alu_ou_result)
    );
endmodule
