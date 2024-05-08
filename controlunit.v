`timescale 1ns / 1ps
module controlunit (
    input clk,
    input rst,
    input [5:0] opcode,
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
    output Branch
    );
  
  reg PCWrite_reg, IorD_reg, MemWrite_reg, IRWrite_reg, ALUSrcA_reg, MemtoReg_reg, RegWrite_reg, RegDst_reg, PCWriteCond_reg, MemRead_reg, Branch_reg;
  reg [1:0] PCSource_reg;
  reg [1:0] ALUSrcB_reg;
  reg [1:0] ALUOp_reg;
  
    reg [3:0] next_state, current_state;
  
    parameter IDLE = 4'b0000, FETCH = 4'b0001, DECODE = 4'b0010, RTYP1 = 4'b0011, RTYP2 = 4'b0100, LW = 4'b0101,
    LW1 = 4'b0110, LW2 = 4'b0111, SW = 4'b1000, SW1 = 4'b1001, BEQ = 4'b1010, JUMP = 4'b1011;
    
    always@(posedge clk or posedge rst)
    begin 
        if(rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    always@(current_state or opcode) begin
        
        case(current_state)
            IDLE: next_state = FETCH;
            FETCH: next_state= DECODE;
            DECODE: 
                case(opcode)
                    6'b000000: next_state = RTYP1;
                    6'b100011: next_state = LW;
                    6'b101011: next_state = SW;
                    6'b000100: next_state = BEQ;
                    6'b001000: next_state = JUMP;
                    default: next_state = IDLE;
                endcase
            RTYP1: next_state = RTYP2;
            LW: next_state = LW1;
            LW1: next_state = LW2;
            SW: next_state = SW1;
            SW1: next_state = IDLE;
            LW2: next_state = IDLE;
            RTYP2: next_state = IDLE;
            BEQ: next_state = IDLE;
            JUMP: next_state = IDLE;
        endcase
    end
    
    always@(current_state)
    begin
            PCWrite_reg = 0;
            IorD_reg = 0;
            MemWrite_reg = 0;
            IRWrite_reg = 0;
            ALUSrcA_reg = 0;
            ALUSrcB_reg = 0;
            ALUOp_reg = 0;
            MemtoReg_reg = 0;
            RegWrite_reg = 0;
            RegDst_reg = 0;
            PCWriteCond_reg = 0;
            MemRead_reg = 0;
            PCSource_reg = 0;
            Branch_reg = 0;
        case(current_state)
            FETCH: begin
                PCWrite_reg = 1;
                IRWrite_reg = 1;
                ALUSrcB_reg = 2'b01;
					 MemRead_reg=1;
            end
            DECODE: begin
                ALUSrcB_reg = 2'b11;
            end
            RTYP1: begin
                ALUSrcA_reg = 1;
                ALUOp_reg = 2'b10;
            end
            RTYP2: begin
                RegDst_reg = 1;
                RegWrite_reg = 1;
            end
            LW, SW: begin
                ALUSrcA_reg = 1;
                ALUSrcB_reg = 2'b10;
            end
            LW1: begin
                IorD_reg = 1;
            end
            LW2: begin
                MemtoReg_reg = 1;
                RegWrite_reg = 1;
            end
            SW1: begin
                IorD_reg = 1;
                MemWrite_reg = 1;
            end
            BEQ: begin
                ALUSrcA_reg = 1;
                ALUOp_reg = 2'b01;
                PCSource_reg = 2'b01;
                Branch_reg = 1;
            end
            JUMP: begin
                PCSource_reg = 2'b10;
                PCWrite_reg = 1;
            end
        endcase
    end
	
    assign PCWrite = PCWrite_reg;
    assign IorD = IorD_reg;
    assign MemWrite = MemWrite_reg;
    assign IRWrite = IRWrite_reg;
    assign ALUSrcA = ALUSrcA_reg;
    assign ALUSrcB = ALUSrcB_reg;
    assign ALUOp = ALUOp_reg;
    assign MemtoReg = MemtoReg_reg;
    assign RegWrite = RegWrite_reg;
    assign RegDst = RegDst_reg;
    assign PCWriteCond = PCWriteCond_reg;
    assign MemRead = MemRead_reg;
    assign PCSource = PCSource_reg;
    assign Branch = Branch_reg;
    
endmodule

